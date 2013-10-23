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

@interface JMAParser ()

@end

@implementation JMAParser

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
    This method acts as the controller for the class's
    intended operation.
*/
- (void)parseFileWithUrl:(NSURL *)url
{
    NSString *fileName = [url lastPathComponent];
    NSString *fileContents = [self stringForURL:url];

    Database *newDatabase = [self databaseFor:fileName];
    
    NSArray *linesInFile = [fileContents componentsSeparatedByString:@"\n"];
    
    [self gamesFromFile:linesInFile for:newDatabase];
    

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
    
    NSLog(@"%@", [url lastPathComponent]);
    
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
    [NSEntityDescription insertNewObjectForEntityForName:@"Database"
                                  inManagedObjectContext:self.managedObjectContext];
    
    newDatabase.name = fileName;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"FAIL!!!: %@", [error localizedDescription]);
    }
    
    return newDatabase;
}

/*
 This method seperates the file contents into game strings to be saved
 as Game objects in a Database object
*/
- (void)gamesFromFile:(NSArray *)linesInFile for:(Database *)database
{
    NSMutableString *individualGame = [[NSMutableString alloc] init];
    NSPredicate *predicate = [self predicateForResults];
    
    for (NSString *line in linesInFile) {
        [individualGame appendString:line];
        
        if ([predicate evaluateWithObject:line]) {
            // Game *newGame = [self gameFrom:individualGame];
            
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
    [NSEntityDescription insertNewObjectForEntityForName:@"Game"
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

# pragma mark - left off

/*
    This method does the heavy lifting of the class.  an individual game's data
 is seperated into seperate strings based on bracket location.  Then the required
 game data is found and saved in the Game object.
 
*/
- (Game *)populateData:(NSArray *)attributes for:(Game *)newGame
{
    NSCharacterSet *quoteSet =
    [NSCharacterSet characterSetWithCharactersInString:@"\""];
    NSMutableDictionary *coreDataHeaders = [[NSMutableDictionary alloc] init];
    
    for (int index = 0; index < [attributes count]; index++) {
        NSString *header = attributes[index];
        header = [header stringByTrimmingCharactersInSet:quoteSet];
        
//        for (NSString *neededHeader in self.headers) {
//            
//            if ([header hasPrefix:neededHeader]) {
//                int startingIndex = [neededHeader length] + ONE;
//               NSString *headerValue = [header substringFromIndex:startingIndex];
//                
//                [coreDataHeaders setObject:headerValue forKey:neededHeader];
//            }
//        }
        
    }
    
    newGame.moves = [attributes lastObject];
    
    return newGame;
}

@end
