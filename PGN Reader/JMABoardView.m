//
//  JMABoardView.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMABoardView.h"
#import "JMASquare.h"
#import "JMAChessConstants.h"
#import "JMAConstants.h"
#import "JMAPiece.h"
#import "JMABoardModel.h"

@interface JMABoardView ()

@property (strong, nonatomic) NSDictionary *squares;
@property (strong, nonatomic) NSMutableArray *pieces;

@end

@implementation JMABoardView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    
    
    
    return self;
}

/*
 This method draws a 64 square board and configures the individual squares with
 a coordinate and color
*/
- (void)drawBoard
{
    NSArray *ranks = @[@8, @7, @6, @5, @4, @3, @2, @1];
    NSArray *files = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    CGRect rect = self.frame;
    CGRect squareFrame;
    NSString *coordinate;
    
    double squareWidth = rect.size.width / EIGHT;
    double squareHeight = rect.size.height / EIGHT;
    int widthIndex = (int)ZERO;
    int heightIndex = (int)ZERO;
    
    for (double squareOriginX = ZERO; squareOriginX < rect.size.width; squareOriginX += squareWidth) {
        
        
        for (double squareOriginY = ZERO; squareOriginY < rect.size.height; squareOriginY += squareHeight) {
            
            coordinate = [[NSString alloc] initWithFormat:@"%@%@", files[widthIndex], ranks[heightIndex]];
            
            JMASquare *aSquare = [self.model squareforCoordinate:coordinate];
            squareFrame = CGRectMake(squareOriginX, squareOriginY, squareWidth, squareHeight);
            aSquare.frame = squareFrame;
            
            [self addSubview:aSquare];
            
            if (aSquare.piece) {
                aSquare.piece.frame = aSquare.frame;
                [self addSubview:aSquare.piece];
            }
            
            heightIndex = [self updateIndex:heightIndex];
            
        }
        widthIndex = [self updateIndex:widthIndex];
    }
    
    
    
}


/*
 This method checks if the square's background color has been set
 If it has then the opposite color is returned.  If the square's background 
 color has not been set then it is and then the opposite color is returned.
 
 The background color check makes sure the last rank's squares have the correct
 color.
*/
- (NSString *)checkColor:(NSString *)color forSquare:(JMASquare *)square
{
    
    if (square.backgroundColor) {
        if ([color isEqualToString:WHITE]) {
            return BLACK;
        } else {
            return WHITE;
        }
    }
    
    if ([color isEqualToString:WHITE]) {
        square.backgroundColor = [UIColor whiteColor];
        return BLACK;
    } else {
        square.backgroundColor = [UIColor blueColor];
        return WHITE;
    }
}


/*
 This method calls the setter methods for the incoming square parameter's
 color and coordinate properties
*/
- (void)configureSquare:(JMASquare *)square
               withRank:(NSString *)rank
                   file:(NSString *)file
               andColor:(NSString *)color
{
    square.color = color;
    square.coordinate = [[NSString alloc] initWithFormat:@"%@%@", file, rank];
    
    
}

/*
 The method checks if the incoming index parameter is equal to 7.  If it is the
 index is reset to 0 else the value is incremented.  The updated value is 
 returned.
*/
- (int)updateIndex:(int)index
{
    if (index == SEVEN) {
        index = (int)ZERO;
    } else {
        index++;
    }
    
    return index;

}


/*
 This method removes the square objects from the board view
*/
- (void)resetBoard
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

/*
 This method creates and adds the pieces needed for the starting position to the
 board
*/
- (void)setupBoard
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
    
    [self addPiecesToBoard];
    
}


/*
 This method adds each piece object to the board view
*/
- (void)addPiecesToBoard
{
    for (JMAPiece *piece in self.pieces) {
        [self addSubview:piece];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    [self drawBoard];
    //[self setupBoard];
    

}


@end
