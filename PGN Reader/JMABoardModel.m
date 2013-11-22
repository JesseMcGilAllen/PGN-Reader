//
//  JMABoardModel.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/21/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMABoardModel.h"
#import "JMAConstants.h"
#import "JMASquare.h"
#import "JMAChessConstants.h"
#import "JMAPiece.h"

@interface JMABoardModel ()


@property (strong, nonatomic) NSDictionary *squares;
@property (strong, nonatomic) NSMutableArray *pieces;

@end

@implementation JMABoardModel

- (id)init
{
    self = [super init];
    if (self) {
        [self createSquares];
        [self createPieces];
    }
    return self;
}


/*
 This method creates the 64 squares of the chess board and sets their 
 coordinate and color
*/
- (void)createSquares
{
    NSMutableDictionary *squares = [[NSMutableDictionary alloc] init];
    NSArray *files = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    NSArray *ranks = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    
    NSString *squareColor = DARK;
    
    for (NSString *rank in ranks) {
        for (NSString *file in files) {
            JMASquare *aSquare = [[JMASquare alloc] init];
            aSquare.coordinate = [[NSString alloc] initWithFormat:@"%@%@", file, rank];
            aSquare.color = squareColor;
            
            if ([squareColor isEqualToString:LIGHT]) {
                squareColor = DARK;
            } else {
                squareColor = LIGHT;
            }
            
            [squares setObject:aSquare forKey:aSquare.coordinate];
            
        }
        
        if ([squareColor isEqualToString:LIGHT]) {
            squareColor = DARK;
        } else {
            squareColor = LIGHT;
        }

    }
    
    self.squares = [NSDictionary dictionaryWithDictionary:squares];
}


- (void)createPieces
{
    self.pieces = [[NSMutableArray alloc] init];
    
    JMAPiece *a8Rook = [[JMAPiece alloc] initWithSquare:self.squares[A8] type:ROOK forColor:BLACK];
    [self.pieces addObject:a8Rook];
    
    JMAPiece *b8Knight = [[JMAPiece alloc] initWithSquare:self.squares[B8] type:KNIGHT forColor:BLACK];
    [self.pieces addObject:b8Knight];
    
    JMAPiece *c8Bishop = [[JMAPiece alloc] initWithSquare:self.squares[C8] type:BISHOP forColor:BLACK];
    [self.pieces addObject:c8Bishop];
    
    JMAPiece *d8Queen = [[JMAPiece alloc] initWithSquare:self.squares[D8] type:QUEEN forColor:BLACK];
    [self.pieces addObject:d8Queen];
    
    JMAPiece *e8King = [[JMAPiece alloc] initWithSquare:self.squares[E8] type:KING forColor:BLACK];
    [self.pieces addObject:e8King];
    
    JMAPiece *f8Bishop = [[JMAPiece alloc] initWithSquare:self.squares[F8] type:BISHOP forColor:BLACK];
    [self.pieces addObject:f8Bishop];
    
    JMAPiece *g8Knight = [[JMAPiece alloc] initWithSquare:self.squares[G8] type:KNIGHT forColor:BLACK];
    [self.pieces addObject:g8Knight];
    
    JMAPiece *h8Rook = [[JMAPiece alloc] initWithSquare:self.squares[H8] type:ROOK forColor:BLACK];
    [self.pieces addObject:h8Rook];
    
    JMAPiece *a7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[A7] type:PAWN forColor:BLACK];
    [self.pieces addObject:a7Pawn];
    
    JMAPiece *b7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[B7] type:PAWN forColor:BLACK];
    [self.pieces addObject:b7Pawn];
    
    JMAPiece *c7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[C7] type:PAWN forColor:BLACK];
    [self.pieces addObject:c7Pawn];
    
    JMAPiece *d7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[D7] type:PAWN forColor:BLACK];
    [self.pieces addObject:d7Pawn];
    
    JMAPiece *e7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[E7] type:PAWN forColor:BLACK];
    [self.pieces addObject:e7Pawn];
    
    JMAPiece *f7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[F7] type:PAWN forColor:BLACK];
    [self.pieces addObject:f7Pawn];
    
    JMAPiece *g7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[G7] type:PAWN forColor:BLACK];
    [self.pieces addObject:g7Pawn];
    
    JMAPiece *h7Pawn = [[JMAPiece alloc] initWithSquare:self.squares[H7] type:PAWN forColor:BLACK];
    [self.pieces addObject:h7Pawn];
    
    JMAPiece *a2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[A2] type:PAWN forColor:WHITE];
    [self.pieces addObject:a2Pawn];
    
    JMAPiece *b2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[B2] type:PAWN forColor:WHITE];
    [self.pieces addObject:b2Pawn];
    
    JMAPiece *c2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[C2] type:PAWN forColor:WHITE];
    [self.pieces addObject:c2Pawn];
    
    JMAPiece *d2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[D2] type:PAWN forColor:WHITE];
    [self.pieces addObject:d2Pawn];
    
    JMAPiece *e2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[E2] type:PAWN forColor:WHITE];
    [self.pieces addObject:e2Pawn];
    
    JMAPiece *f2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[F2] type:PAWN forColor:WHITE];
    [self.pieces addObject:f2Pawn];
    
    JMAPiece *g2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[G2] type:PAWN forColor:WHITE];
    [self.pieces addObject:g2Pawn];
    
    JMAPiece *h2Pawn = [[JMAPiece alloc] initWithSquare:self.squares[H2] type:PAWN forColor:WHITE];
    [self.pieces addObject:h2Pawn];
    
    JMAPiece *a1Rook = [[JMAPiece alloc] initWithSquare:self.squares[A1] type:ROOK forColor:WHITE];
    [self.pieces addObject:a1Rook];
    
    JMAPiece *b1Knight = [[JMAPiece alloc] initWithSquare:self.squares[B1] type:KNIGHT forColor:WHITE];
    [self.pieces addObject:b1Knight];
    
    JMAPiece *c1Bishop = [[JMAPiece alloc] initWithSquare:self.squares[C1] type:BISHOP forColor:WHITE];
    [self.pieces addObject:c1Bishop];
    
    JMAPiece *d1Queen = [[JMAPiece alloc] initWithSquare:self.squares[D1] type:QUEEN forColor:WHITE];
    [self.pieces addObject:d1Queen];
    
    JMAPiece *e1King = [[JMAPiece alloc] initWithSquare:self.squares[E1] type:KING forColor:WHITE];
    [self.pieces addObject:e1King];
    
    JMAPiece *f1Bishop = [[JMAPiece alloc] initWithSquare:self.squares[F1] type:BISHOP forColor:WHITE];
    [self.pieces addObject:f1Bishop];
    
    JMAPiece *g1Knight = [[JMAPiece alloc] initWithSquare:self.squares[G1] type:KNIGHT forColor:WHITE];
    [self.pieces addObject:g1Knight];
    
    JMAPiece *h1Rook = [[JMAPiece alloc] initWithSquare:self.squares[H1] type:ROOK forColor:WHITE];
    [self.pieces addObject:h1Rook];
}

/*
 This method returns the square from the squares dictionary for the incoming 
 coordinate parameter
*/
- (JMASquare *)squareforCoordinate:(NSString *)coordinate
{
    return [self.squares objectForKey:coordinate];
}
/*
 This method returns the dictionary of squares
*/
- (NSDictionary *)squares
{
    return _squares;
}


@end
