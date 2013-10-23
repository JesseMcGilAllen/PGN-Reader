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

// array of game headers needed by app
@property (strong, nonatomic) NSArray *headers;


@end

@implementation JMAParser

- (id)init
{
    self = [super init];
    if (self) {
        _headers = @[@"Event", @"Site", @"Date", @"White", @"Black",
                     @"Result", @"ECO", @"WhiteElo", @"BlackElo"];
        

        
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
    
    Database *newDatabase = [self databaseFor:fileName];
    
    NSString *fileContents = [self stringForURL:url];
    
    NSArray *linesInFile = [fileContents componentsSeparatedByString:@"\n"];
    [self gamesFromFile:linesInFile for:newDatabase];
    

}

/*
 This method will create the Database for the file in Core Data.
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
*/
- (void)gamesFromFile:(NSArray *)linesInFile for:(Database *)database
{
    NSMutableString *individualGame = [[NSMutableString alloc] init];
    NSPredicate *predicate = [self predicateForResults];
    
    for (NSString *line in linesInFile) {
        [individualGame appendString:line];
        
        if ([predicate evaluateWithObject:line]) {
            Game *newGame = [self gameFrom:individualGame];
            
            individualGame = [[NSMutableString alloc] init];
        }
        
    }

}


/*
 This method will create a Game object and save it into Core Data
*/
- (Game *)gameFrom:(NSString *)individualGame
{
    NSCharacterSet *bracketSet =
    [NSCharacterSet characterSetWithCharactersInString:@"[]"];
    
    NSArray *headerSeperatedData =
    [individualGame componentsSeparatedByCharactersInSet:bracketSet];
    
    Game *newGame =
    [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                  inManagedObjectContext:self.managedObjectContext];
    
    
    [self populateData:headerSeperatedData for:newGame];
    
    return newGame;
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

- (Game *)populateData:(NSArray *)gameHeaders for:(Game *)newGame
{
    NSCharacterSet *quoteSet =
    [NSCharacterSet characterSetWithCharactersInString:@"\""];
    
    for (int index = 0; index < [gameHeaders count]; index++) {
        NSString *header = gameHeaders[index];
        header = [header stringByTrimmingCharactersInSet:quoteSet];
        for (NSString *neededHeader in self.headers) {
            if ([header hasPrefix:neededHeader]) {
                NSLog(@"%@", header);
            }
        }
        
    }
    
    newGame.moves = [gameHeaders lastObject];
    
    return newGame;
}

@end
