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
 This method seperates the file contents into game strings to be saved
 as Game objects in a Database object
*/
- (void)gamesFromFile:(NSArray *)linesInFile forDatabase:(Database *)database
{
    NSMutableString *individualGame = [[NSMutableString alloc] init];
    NSPredicate *predicate = [self predicateForResults];
    
    for (NSString *line in linesInFile) {
        [individualGame appendString:line];
        
        if ([predicate evaluateWithObject:line]) {
            
            Game *newGame = [self gameFrom:individualGame];
            [database addGamesObject:newGame];
    
            [self save];
            
            individualGame = [[NSMutableString alloc] init];
        }
        
    }

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
     NSMutableArray *headers = [[NSMutableArray alloc] initWithArray:attributes];
    [headers removeLastObject];
    newGame.moves = [attributes lastObject];

    for (NSString *header in headers) {
        
        if ([header length] > TWO) {
            NSArray *headerComponents = [self processHeader:header];
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
    //NSCharacterSet *quoteSet =
    //[NSCharacterSet characterSetWithCharactersInString:@"\""];
    
    // NSString *newAttribute = [attribute stringByTrimmingCharactersInSet:quoteSet];
    NSString *newAttribute = [attribute stringByReplacingOccurrencesOfString:@"\""
                                                                  withString:EMPTY_STRING];

    return newAttribute;
}


# pragma mark - potential time sink
/*
This method will compare the Prefix of an attribute with a game attribute saved
 in Core Data. A Space is added to the Game Attribute in ensure the right 
 attribute is saved.  A boolean is returned with the result.
*/
- (BOOL)comparePrefixOf:(NSString *)attribute to:(NSString *)gameAttribute
{
    
    NSString *attributeLowerCase = [attribute lowercaseString];
    NSString *comparisonAttribute = [[NSString alloc] initWithFormat:@"%@ ", gameAttribute];
    //NSComparisonResult result = [attribute caseInsensitiveCompare:gameAttribute];
  
    if ([attributeLowerCase hasPrefix:[comparisonAttribute lowercaseString]]) {
        return YES;
    }
    
    // if (result == NSOrderedSame) {
    //    return YES;
    // }
    return NO;
}

/*
  This method will call the comparePrefixOf method for the parameter until
  The appropiate game attribute is found.  
 Once found the appropiate method will be called to assign the attributes value.
*/
- (void)assign:(NSString *)attribute for:(Game *)game
{
    
    if ([self comparePrefixOf:attribute to:BLACK_CD]) {
        
        [self valueForBlackAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:BLACK_ELO_CD]) {
        
        [self valueForBlackEloAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:DATE_CD]) {
        
        //[self valueForDateAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:ECO_CD]) {
        
        [self valueForEcoAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:EVENT_CD]) {
        
        [self valueForEventAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:RESULT_CD]) {
        
        [self valueForResultAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:SITE_CD]) {
        
        [self valueForSiteAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:WHITE_CD]) {
        
        [self valueForWhiteAttribute:attribute in:game];
        
    } else if ([self comparePrefixOf:attribute to:WHITE_ELO_CD]) {
        
        [self valueForWhiteEloAttribute:attribute in:game];
        
    }

}

/*
 This method returns the value from the incoming attribute parameter for the
 incoming Core Data property
*/
- (NSString *)valueFrom:(NSString *)attribute forCoreData:(NSString *)property
{
    NSString *value = [attribute substringFromIndex:[property length]];
    
    return value;
}

/*
 This method sets the value of the black property of the
 incoming newGame object.
*/
- (void)valueForBlackAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForBlack = [self valueFrom:attribute
                                  forCoreData:BLACK_CD];
    
    newGame.black = valueForBlack;
}

/*
 This method converts the value of the Black Elo attribute
 and sets the property in the incoming newGame object
*/
- (void)valueForBlackEloAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForBlackElo = [self valueFrom:attribute
                                     forCoreData:BLACK_ELO_CD];
    
    NSInteger eloInteger = [valueForBlackElo integerValue];
    NSNumber *elo = [NSNumber numberWithInteger:eloInteger];
    
    newGame.blackElo = elo;
    //NSLog(@"black Elo: %@", newGame.blackElo);
    
}

///*
// This method creates a NSDateFormatter object and uses it to convert the 
// incoming attribute value to a date and sets the newGame object date value
//*/
//- (void)valueForDateAttribute:(NSString *)attribute in:(Game *)newGame
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//    
//    NSString *valueForDate = [self valueFrom:attribute
//                                 forCoreData:DATE_CD];
//    
//    NSDate *date = [dateFormatter dateFromString:valueForDate];
//    
//    newGame.date = date;
//    //NSLog(@"Date: %@", newGame.date);
//}

/*
 This method sets the value of the eco property of the newGame object
*/
- (void)valueForEcoAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForEco = [self valueFrom:attribute
                                forCoreData:ECO_CD];
    
    newGame.eco = valueForEco;
    //nslog(@"ECO: %@", newGame.eco);
}

/*
 This method sets the value of the event property of the newGame object
*/
- (void)valueForEventAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForEvent = [self valueFrom:attribute
                                  forCoreData:EVENT_CD];
    
    newGame.event = valueForEvent;
    //nslog(@"Event: %@", newGame.event);
}

/*
 This method sets the value of the result property of the newGame object
*/
- (void)valueForResultAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForResult = [self valueFrom:attribute
                                   forCoreData:RESULT_CD];
    
    newGame.result = valueForResult;
}

/*
 This method sets the value of the site property of the newGame object
*/
- (void)valueForSiteAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForSite = [self valueFrom:attribute
                                 forCoreData:SITE_CD];
    
    newGame.site = valueForSite;
}

/*
 This method sets the value of the white property of the newGame object
*/
- (void)valueForWhiteAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForWhite = [self valueFrom:attribute
                                  forCoreData:WHITE_CD];
    
    newGame.white = valueForWhite;
}


/*
 This method converts the value of the White Elo attribute
 and sets the property in the incoming newGame object
*/
- (void)valueForWhiteEloAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSString *valueForWhiteElo = [self valueFrom:attribute
                                     forCoreData:WHITE_ELO_CD];
    
    NSInteger eloInteger = [valueForWhiteElo integerValue];
    NSNumber *elo = [NSNumber numberWithInteger:eloInteger];
    
    newGame.whiteElo = elo;
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




# pragma mark - attempt Two

/*
 This method calls a method to trim the quotes from the incoming
 string.  Then the method returns an array of the header elements
*/
- (NSArray *)processHeader:(NSString *)header
{
    header = [self trimQuoteFrom:header];
    
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
        
        
        //aGame.gameString = gameString;
        //aGame.completed = NO;
        
        
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
