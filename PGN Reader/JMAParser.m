//
//  JMAParser.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/20/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAParser.h"
#import "Database.h"
#import "Game.h"
#import "JMAConstants.h"
#import "JMADatabasesTableViewController.h"

@interface JMAParser ()

@end

@implementation JMAParser

- (id)init
{
    self = [super init];
    if (self) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
    }
    return self;
}

/*
    This method acts as the controller for the class's
    intended operation.
*/
- (BOOL)parseFileWithUrl:(NSURL *)url withPersistentStoreCoordinator:persistentStoreCoordinator;
{
    self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    
    NSString *fileName = [url lastPathComponent];
    NSString *fileContents = [self stringForURL:url];

    Database *newDatabase = [self databaseFor:fileName];
    
    [self processFile:fileContents forDatabase:newDatabase];
    
    //NSArray *linesInFile = [fileContents componentsSeparatedByString:@"\n"];
    
    //[self gamesFromFile:linesInFile forDatabase:newDatabase];
    

    return YES;
    

}

/*
 The method will initialize a string with the contents of a url parameter
 and return the string.
 
 */
- (NSString *)stringForURL:(NSURL *)url
{
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfURL:url
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
    
    //nslog(@"%@", [url lastPathComponent]);
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return @"Error";
    } else {
        return fileContents;
    }
}

/*
 This method will create the Database for the file in Core Data and return it.
*/
- (Database *)databaseFor:(NSString *)fileName
{
    Database *newDatabase =
    [NSEntityDescription insertNewObjectForEntityForName:DATABASE_CD_ENTITY
                                  inManagedObjectContext:self.managedObjectContext];
    
    newDatabase.name = fileName;
    
    [self save];
    
    return newDatabase;
}

/*
 This method creates a compound predicate that contains the possible results
 of a game and returns the predicate.
 */
- (NSPredicate *)predicateForResults
{
    NSMutableArray *subpredicates = [NSMutableArray array];
    NSArray *results = @[@" 1-0", @" 1/2-1/2", @" 0-1", @" *"];
    for (NSString *result in results)
    {
        [subpredicates addObject:[NSPredicate predicateWithFormat:@"SELF CONTAINS %@", result]];
        
        
    }
    
    return [NSCompoundPredicate orPredicateWithSubpredicates:subpredicates];
}

/*
 This method will create a Game object and populate it with a game and return it
*/
- (Game *)gameFrom:(NSString *)individualGame
{
    NSArray *attributesArray = [self seperateAttributesFrom:individualGame];
    
    Game *newGame =
    [NSEntityDescription insertNewObjectForEntityForName:GAME_CD_ENTITY
                                  inManagedObjectContext:self.managedObjectContext];
    
    [self populateData:attributesArray for:newGame];
    
    return newGame;
}

/*
    This method takes a string and seperates it into an array based on the 
    location of square brackets.  It then returns the array.
*/
- (NSArray *)seperateAttributesFrom:(NSString *)gameString
{
    NSCharacterSet *bracketSet =
    [NSCharacterSet characterSetWithCharactersInString:@"[]"];
    
    NSArray *attributesArray =
    [gameString componentsSeparatedByCharactersInSet:bracketSet];
    
    return attributesArray;
}



/*
    This method does the heavy lifting of the class.  an individual game's data
 is seperated into seperate strings based on bracket location.  Then the required
 game data is found and saved in the Game object.
 
*/
- (Game *)populateData:(NSArray *)attributes for:(Game *)newGame
{
//    for (NSString *attribute in attributes) {
//        NSLog(@"Attribute: %@", attribute);
//    }
    
     NSMutableArray *headers = [[NSMutableArray alloc] initWithArray:attributes];
    [headers removeLastObject];
    newGame.moves = [attributes lastObject];
    
    //NSLog(@"Moves: %@", newGame.moves);

    for (NSString *header in headers) {
    
        
       NSString *newHeader = [self trimQuoteFrom:header];
        
        if ([newHeader length] > TWO) {
            NSArray *headerComponents = [self processHeader:newHeader];
  
            [self assignHeader:headerComponents forGame:newGame];
        }
        
    }
    
    return newGame;
}


/*
 This method trims the " character from the beginning and end of the string
 parameter and returns it.
*/
- (NSString *)trimQuoteFrom:(NSString *)attribute
{
    
    // NSLog(@"Old Header: %@", attribute);
    //NSCharacterSet *quoteSet =
    //[NSCharacterSet characterSetWithCharactersInString:@"\""];
    
    // NSString *newAttribute = [attribute stringByTrimmingCharactersInSet:quoteSet];
    
    attribute = [attribute stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *newAttribute = [attribute stringByReplacingOccurrencesOfString:@"\""
                                                                  withString:EMPTY_STRING];

    return newAttribute;
}



/*
 This method saves the managedObjectContext
*/
- (void)save
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"FAIL!!!: %@", [error localizedDescription]);
    }
}

/*
 This method calls a method to trim the quotes from the incoming
 string.  Then the method returns an array of the header elements
*/
- (NSArray *)processHeader:(NSString *)header
{

    NSRange firstSpace = [header rangeOfString:SPACE];
    
    
    NSArray *components = @[[header substringToIndex:firstSpace.location],
                            [header substringFromIndex:firstSpace.location]];
    
    
    
    return components;
}


/*
 This method calls a method that checks the first element of the incoming array.
 if it is similiar one of the Game object properties.  If similiar the method
 sets the corresponding property to the second element of the array.
*/
- (void)assignHeader:(NSArray *)headerComponents forGame:(Game *)game
{
    if ([self header:headerComponents[ZERO] representsAttribute:BLACK_CD]) {
       
        game.black = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:BLACK_ELO_CD]) {
        
        game.blackElo = [NSNumber numberWithInt:[headerComponents[ONE] integerValue]];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:DATE_CD]) {
        
        game.date = headerComponents[ONE];
        
        // [self valueForDateAttribute:headerComponents[ONE] in:game];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:ECO_CD]) {
        
        game.eco = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:EVENT_CD]) {
        
        game.event = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:RESULT_CD]) {
        
        game.result = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:SITE_CD]) {
        
        game.site = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:WHITE_CD]) {
        
        game.white = headerComponents[ONE];
        
    } else if ([self header:headerComponents[ZERO] representsAttribute:WHITE_ELO_CD]) {
        
        game.whiteElo = [NSNumber numberWithInt:[headerComponents[ONE] integerValue]];
    }
}


/*
 This method checks if the to incoming strings are ordered the same
*/
- (BOOL)header:(NSString *)header representsAttribute:(NSString *)attribute
{
    NSComparisonResult result = [header caseInsensitiveCompare:attribute];
    
    if (result == NSOrderedSame) {
        return YES;
    }
    
    return NO;
}

# pragma mark - Attempt Three

/*
 This method is an attempt to improve the speed of the parsing
 process
 */
- (void)processFile:(NSString *)fileContents forDatabase:(Database *)database
{
    NSRegularExpression *regularExpression = [self regularExpressionToSeperateGames];
    
    __block NSUInteger location = ZERO;
    __block NSRange gameRange;
    __block int gameCount = (int)ZERO;
    
    [regularExpression enumerateMatchesInString:fileContents options:ZERO
                                         range:NSMakeRange(ZERO, [fileContents length])
                                    usingBlock:^(NSTextCheckingResult *match,
                                                 NSMatchingFlags flags,
                                                 BOOL *stop)
    {
        
        gameRange.location = location;
        gameRange.length = ([match range].location + [match range].length) - location;
     
        NSString *gameString = [fileContents substringWithRange:gameRange];
        
        Game *aGame = [self gameFrom:gameString];
        
        aGame.orderingValue = [NSNumber numberWithInt:gameCount];
        
        [database addGamesObject:aGame];
        
        
        gameCount++;
        
        location = gameRange.location + gameRange.length;
    }];
    
    [self save];
    
    
}

- (NSRegularExpression *)regularExpressionToSeperateGames
{
    NSRegularExpression *regularExpression;
    NSString *resultExpression = @"\\s(1-0|0-1|1\\/2-1\\/2|\\*)";
    NSError *error = nil;
    
    regularExpression = [NSRegularExpression regularExpressionWithPattern:resultExpression
                                                                  options:ZERO
                                                                    error:&error];
    
    return regularExpression;
}

- (NSArray *)headersFromAttributes:(NSArray *)attributes
{
    NSMutableArray *headers = [[NSMutableArray alloc] initWithArray:attributes];
    

    
    return headers;
}

@end
