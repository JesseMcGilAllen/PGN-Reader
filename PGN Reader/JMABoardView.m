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
#import "JMAMove.h"

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
 This method will move the piece's location from the first square in array
 to the second if the move is not a castling move
*/
- (void)updateBoardWithMove:(JMAMove *)move squares:(NSArray *)squares
{
    
    if (move.isCastling) {
        [self updateBoardWithSquaresForCastling:squares];
        return;
    }
        
    JMASquare *originSquare = squares[ZERO];
    JMASquare *destinationSquare = squares[ONE];
    JMAPiece *pieceToRemove;
    JMAPiece *piece = originSquare.piece;
    
    if (move.isEnPassant) {
        JMASquare *square = [self.model squareforCoordinate:move.capturedPieceSquareCoordinate];
        pieceToRemove = square.piece;
    } else if (move.isCapture) {
        pieceToRemove = destinationSquare.piece;
        
    } else if (move.isPromotion) {
        pieceToRemove = piece;
    }
    
    [UIView animateWithDuration:(ONE / TWO)
                     animations:^{
                         piece.frame = destinationSquare.frame;
                         [self bringSubviewToFront:piece];
                         if (pieceToRemove) {
                             [pieceToRemove removeFromSuperview];
                         }
                         
                         if (move.isPromotion) {
                             
                             if (move.isCapture) {
                                 [piece removeFromSuperview];
                             }
                             JMAPiece *promotedPiece = [self.model createPieceForPromotionOnSquare:destinationSquare forMove:move];
                             
                             promotedPiece.frame = destinationSquare.frame;
                             [self addSubview:promotedPiece];
                         }
                     }];
}

/*
 This method will use the first two elements in the array to move the king and
 the last two elements of the array to move the rook
*/
- (void)updateBoardWithSquaresForCastling:(NSArray *)squares
{
    JMASquare *kingOriginSquare = squares[ZERO];
    JMASquare *kingDestinationSquare = squares[ONE];
    
    JMASquare *rookOriginSquare = squares[TWO];
    JMASquare *rookDestinationSquare = squares[THREE];
    
    JMAPiece *king = kingOriginSquare.piece;
    JMAPiece *rook = rookOriginSquare.piece;
    
    [UIView animateWithDuration:ONE animations:^{
        king.frame = kingDestinationSquare.frame;
        rook.frame = rookDestinationSquare.frame;
        [self bringSubviewToFront:king];
        [self bringSubviewToFront:rook];
    }];
    
}

/*
 This method updates the board by moving the move's pieceToMove from the origin
 Square to the destinationSquare and adding captured pieces back if necessary.
*/
- (void)updateBoardWithTakebackMove:(JMAMove *)move squares:(NSArray *)squares;
{
    if (move.isCastling) {
        [self updateBoardWithSquaresForCastling:squares];
        return;
    }
    
    
    JMASquare *originSquare = squares[ZERO];
    JMASquare *destinationSquare = squares[ONE];
    JMAPiece *pieceToMove = move.pieceToMove;
    
    [UIView animateWithDuration:(ONE / TWO) animations:^{
        if (move.isPromotion) {
            JMAPiece *pieceToRemove = destinationSquare.piece;
            [pieceToRemove removeFromSuperview];
            destinationSquare.piece = pieceToMove;
        }
        
        pieceToMove.frame = destinationSquare.frame;
        
        
        if (move.isEnPassant) {
            JMASquare *square = [self.model squareforCoordinate:move.capturedPieceSquareCoordinate];
            move.capturedPiece.frame = square.frame;
            [self addSubview:move.capturedPiece];
            
        } else if (move.isCapture) {
            move.capturedPiece.frame = originSquare.frame;
            [self addSubview:move.capturedPiece];
        }
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    //[self drawBoard];
    //[self setupBoard];
    

}

*/
@end
