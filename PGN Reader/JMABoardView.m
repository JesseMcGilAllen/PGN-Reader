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
    NSMutableDictionary *squares = [[NSMutableDictionary alloc] init];
    NSArray *ranks = @[@8, @7, @6, @5, @4, @3, @2, @1];
    NSArray *files = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    CGRect rect = self.frame;
    NSString *color = WHITE;
    
    double squareWidth = rect.size.width / EIGHT;
    double squareHeight = rect.size.height / EIGHT;
    int widthIndex = (int)ZERO;
    int heightIndex = (int)ZERO;
    
    for (double squareOriginX = ZERO; squareOriginX < rect.size.width; squareOriginX += squareWidth) {
        JMASquare *square;
        
        for (double squareOriginY = ZERO; squareOriginY < rect.size.height; squareOriginY += squareHeight) {
            
            
            square = [[JMASquare alloc] initWithFrame:CGRectMake(squareOriginX, squareOriginY, squareWidth, squareHeight)];
            
            [self configureSquare:square withRank:ranks[heightIndex] file:files[widthIndex] andColor:color];
            
             color = [self checkColor:color forSquare:square];
            
            [squares setObject:square forKey:square.coordinate];
            [self addSubview:square];
            
            // NSLog(@"Square dimensions: %f, %f, %f, %f", square.frame.origin.x, square.frame.origin.y, square.frame.size.width, square.frame.size.height);
           
            heightIndex = [self updateIndex:heightIndex];
            
        }
       
        
        
        widthIndex = [self updateIndex:widthIndex];
        
        color = [self checkColor:color forSquare:square];

        
    }
    
    self.squares = squares;
    

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
    
    
    
    
    
    
    JMAPiece *a1Rook = [[JMAPiece alloc] initWithSquare:self.squares[A1] type:ROOK forColor:WHITE];
    [self.pieces addObject:a1Rook];
    

    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    [self drawBoard];
    [self setupBoard];
    

}


@end
