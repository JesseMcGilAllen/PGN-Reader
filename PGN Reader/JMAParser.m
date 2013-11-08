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
    
    NSArray *linesInFile = [fileContents componentsSeparatedByString:@"\n"];
    
    [self gamesFromFile:linesInFile forDatabase:newDatabase];
    

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
    newGame.moves = [attributes lastObject];
    
    for (NSString *attribute in attributes) {
        NSString *strippedAttribute = [self trimQuoteFrom:attribute];
        [self assign:strippedAttribute for:newGame];
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
                                                                  withString:@""];
    
    return newAttribute;
}


/*
This method will compare the Prefix of an attribute with a game attribute saved
 in Core Data. A Space is added to the Game Attribute in ensure the right 
 attribute is saved.  A boolean is returned with the result.
*/
- (BOOL)comparePrefixOf:(NSString *)attribute to:(NSString *)gameAttribute
{
    NSString *attributeLowerCase = [attribute lowercaseString];
    NSString *comparisonAttribute = [[NSString alloc] initWithFormat:@"%@ ", gameAttribute];
    
    
    if ([attributeLowerCase hasPrefix:[comparisonAttribute lowercaseString]]) {
        return YES;
    }
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
        
        [self valueForDateAttribute:attribute in:game];
        
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

/*
 This method creates a NSDateFormatter object and uses it to convert the 
 incoming attribute value to a date and sets the newGame object date value
*/
- (void)valueForDateAttribute:(NSString *)attribute in:(Game *)newGame
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *valueForDate = [self valueFrom:attribute
                                 forCoreData:DATE_CD];
    
    NSDate *date = [dateFormatter dateFromString:valueForDate];
    
    newGame.date = date;
    //NSLog(@"Date: %@", newGame.date);
}

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

@end
