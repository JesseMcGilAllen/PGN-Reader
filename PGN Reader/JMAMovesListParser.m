//
//  JMAMovesListParser.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/14/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAMovesListParser.h"
#import "JMAConstants.h"
#import "JMAChessConstants.h"
#import "JMAMove.h"

@interface JMAMovesListParser ()

@property (strong, nonatomic) NSArray *movesToProcess;
@property (strong, nonatomic) NSMutableString *textViewString;
@property (strong, nonatomic) NSMutableArray *moves;

@property (assign, nonatomic) int moveNumber;

@end

@implementation JMAMovesListParser

- (id)init
{
    return [self initWithMoves:nil];
}

- (id)initWithMoves:(NSString *)moves
{
    self = [super init];
    
    if (self) {
        _movesToProcess = [moves componentsSeparatedByString:SPACE];
        _textViewString = [NSMutableString stringWithString:EMPTY_STRING];
        _moves = [[NSMutableArray alloc] init];
        _moveNumber = (int)ONE;
    };
    
    //NSLog(@"%@", moves);
    [self parse];
    
    return self;
}

/*
 This method will return a string of moves formatted for being put in a 
 text view.
*/
- (NSString *)movesForTextView
{
    return self.textViewString;
}

/*
 This method returns an array of moves ready for playback
*/
- (NSArray *)movesForGame
{
    NSArray *movesArray = [NSArray arrayWithArray:self.moves];
    
    return movesArray;
}


/*
 This method will parse the movesToProcess string into the moves array 
 and the movesForTextView objects
*/
- (void)parse
{

    NSRegularExpression *regularExpression = [self moveRegularExpression];
    
    [self.movesToProcess enumerateObjectsUsingBlock:^(NSString *component, NSUInteger index, BOOL *stop) {
        
    
        NSUInteger numberOfMatches = [regularExpression numberOfMatchesInString:component
                                                            options:ZERO
                                                              range:NSMakeRange(ZERO, [component length])];
        
        if (numberOfMatches == ONE) {
            [self processComponent:component];
        } else {
            NSArray *findings = [regularExpression matchesInString:component
                                                             options:ZERO
                                                               range:NSMakeRange(ZERO, [component length])];
            
            [self processRegularExpressionFindings:findings
                                      forComponent:component];
        }
        
        
        
        if (index == ([self.movesToProcess count] - ONE)) {
            self.finished = YES;
        }
        

    }];
}


/*
 This method creates an regular expression of various possible valid moves a 
 game's move file whould have.  The regular expression is returned to the 
 calling method.
*/
- (NSRegularExpression *)moveRegularExpression
{
    NSError *error = nil;
    
    
    
    NSString *moveNumberExpression = @"[1-9][0-9]{0,2}\\.";
    NSString *pawnMoveExpression = @"[a-h](x[a-h])?[1-8](=[Q|N|R|B])?";
    NSString *castlingExpression = @"O-O(-O)?";
    NSString *pieceMoveExpression = @"(Q|K|R|N|B)([a-h]|[1-8])?(x)?[a-h][1-8]";
    NSString *resultExpression = @"(1-0|0-1|1\\/2-1\\/2|\\*)";
    
    NSString *compoundExpressionString =
        [[NSString alloc] initWithFormat:@"(%@|%@|%@|%@|%@)",
         moveNumberExpression,
         pawnMoveExpression,
         castlingExpression,
         pieceMoveExpression,
         resultExpression];
    
    NSRegularExpression *regularExpression =
    [NSRegularExpression regularExpressionWithPattern:compoundExpressionString
                                              options:NSRegularExpressionCaseInsensitive
                                                error:&error];
    
    if (error) {
        NSLog(@"error %@", [error localizedDescription]);
    }
    
    return regularExpression;
}


/*
 This method checks if the incoming parameter is a move number.  If it is, the
 processMoveNumber method is called.  Else, The processMove method is called.
*/
- (void)processComponent:(NSString *)component
{
    
    
    if ([self isMoveNumber:component]) {
        
        [self processMoveNumber:component];
        
    } else  if ([self isGameResult:component]) {
        
        [self processGameResult:component];
    } else {
        
        [self processMove:component];
    }
}

/*
 This method calls the process Component method for the substring that each
 range in the results array specifies.
*/
- (void)processRegularExpressionFindings:(NSArray *)results
                            forComponent:(NSString *)component
{
    
    
    for (NSTextCheckingResult *result in results) {
        
        [self processComponent:[component substringWithRange:result.range]];
    }
}


/*
 This method checks if the incoming string represents a move number and returns
 the result
*/
- (BOOL)isMoveNumber:(NSString *)component
{
    component = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int moveValue = [[component stringByReplacingOccurrencesOfString:PERIOD
                                                          withString:SPACE] intValue];
    
    
    
    if (moveValue > ZERO) {
        return YES;
    } else {
        return NO;
    }
    
}

/*
 This method checks if the incoming string parameter represents the game's 
 result
*/
- (BOOL)isGameResult:(NSString *)component
{
    NSArray *possibleResults = @[@"1-0", @"0-1", @"1/2-1/2", @"*"];
    
    if ([possibleResults containsObject:component]) {
        return YES;
    } else {
        return NO;
    }
    
    
}

/*
 This method adds the component to the TextViewString and increments the 
 move number property
*/
- (void)processMoveNumber:(NSString *)component
{
    self.moveNumber++;
    if (self.moveNumber > ONE) {
        [self.textViewString appendString:NEW_LINE];
        
    }
    
    
    
    [self.textViewString appendString:component];
    
}

/*
 This method adds the component parameter to the moves array and textView String
*/
- (void)processMove:(NSString *)component
{
    
    JMAMove *halfMove = [[JMAMove alloc] initWithMoveString:component];
    [self.textViewString appendString:SPACE];
    [self.textViewString appendString:component];
    
    [self.moves addObject:halfMove];

}

/*
 This method adds the component parameter to the moves array
*/
- (void)processGameResult:(NSString *)component
{
    [self.textViewString appendString:NEW_LINE];
    [self.textViewString appendString:component];
}


@end
