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
#import "JMAMove.h"

@interface JMABoardModel ()

@property (strong, nonatomic) NSDictionary *squaresDictionary;
@property (strong, nonatomic) NSMutableArray *pieces;
@property (strong, nonatomic) NSArray *moves;

// White Pieces
@property (strong, nonatomic, readwrite) NSMutableArray *whitePawns;
@property (strong, nonatomic, readwrite) NSMutableArray *whiteRooks;
@property (strong, nonatomic, readwrite) NSMutableArray *whiteKnights;
@property (strong, nonatomic, readwrite) NSMutableArray *whiteBishops;
@property (strong, nonatomic, readwrite) NSMutableArray *whiteQueens;
@property (strong, nonatomic, readwrite) JMAPiece *whiteKing;

//Black Pieces
@property (strong, nonatomic, readwrite) NSMutableArray *blackPawns;
@property (strong, nonatomic, readwrite) NSMutableArray *blackRooks;
@property (strong, nonatomic, readwrite) NSMutableArray *blackKnights;
@property (strong, nonatomic, readwrite) NSMutableArray *blackBishops;
@property (strong, nonatomic, readwrite) NSMutableArray *blackQueens;
@property (strong, nonatomic, readwrite) JMAPiece *blackKing;

@property (strong, nonatomic) NSMutableArray *capturedPieces;

@property (strong, nonatomic) NSArray *positions;
@property (strong, nonatomic) NSArray *squares;

@end

@implementation JMABoardModel

- (id)init
{
    self = [super init];
    if (self) {
        
        
        _whitePawns = [[NSMutableArray alloc] init];
        _whiteKnights = [[NSMutableArray alloc] init];
        _whiteRooks = [[NSMutableArray alloc] init];
        _whiteBishops = [[NSMutableArray alloc] init];
        _whiteQueens = [[NSMutableArray alloc] init];
        _blackPawns = [[NSMutableArray alloc] init];
        _blackRooks = [[NSMutableArray alloc] init];
        _blackKnights = [[NSMutableArray alloc] init];
        _blackBishops = [[NSMutableArray alloc] init];
        _blackQueens = [[NSMutableArray alloc] init];
        _halfMoveIndex = ZERO;
        
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
            
            squareColor = [self switchSquareColor:squareColor];
            
            [squares setObject:aSquare forKey:aSquare.coordinate];
            
        }
        
        squareColor = [self switchSquareColor:squareColor];

    }
    
    self.squaresDictionary = [[NSDictionary alloc] initWithDictionary:squares];
    self.squares = [[NSArray alloc] initWithArray:[squares allValues]];
    
}

- (NSString *)switchSquareColor:(NSString *)squareColor
{
    if ([squareColor isEqualToString:LIGHT]) {
        squareColor = DARK;
    } else {
        squareColor = LIGHT;
    }
    
    return squareColor;
}

/*
 This method creates the chess piece objects
*/
- (void)createPieces
{
    self.pieces = [[NSMutableArray alloc] init];
    
    JMAPiece *a8Rook = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[A8] type:ROOK forColor:BLACK];
    [self.pieces addObject:a8Rook];
    [self.blackRooks addObject:a8Rook];
    
    JMAPiece *b8Knight = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[B8] type:KNIGHT forColor:BLACK];
    [self.pieces addObject:b8Knight];
    [self.blackKnights addObject:b8Knight];
    
    JMAPiece *c8Bishop = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[C8] type:BISHOP forColor:BLACK];
    [self.pieces addObject:c8Bishop];
    [self.blackBishops addObject:c8Bishop];
    
    JMAPiece *d8Queen = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[D8] type:QUEEN forColor:BLACK];
    [self.pieces addObject:d8Queen];
    [self.blackQueens addObject:d8Queen];
    
    JMAPiece *e8King = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[E8] type:KING forColor:BLACK];
    [self.pieces addObject:e8King];
    self.blackKing = e8King;
    
    JMAPiece *f8Bishop = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[F8] type:BISHOP forColor:BLACK];
    [self.pieces addObject:f8Bishop];
    [self.blackBishops addObject:f8Bishop];
    
    JMAPiece *g8Knight = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[G8] type:KNIGHT forColor:BLACK];
    [self.pieces addObject:g8Knight];
    [self.blackKnights addObject:g8Knight];
    
    JMAPiece *h8Rook = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[H8] type:ROOK forColor:BLACK];
    [self.pieces addObject:h8Rook];
    [self.blackRooks addObject:h8Rook];
    
    JMAPiece *a7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[A7] type:PAWN forColor:BLACK];
    [self.pieces addObject:a7Pawn];
    [self.blackPawns addObject:a7Pawn];
    
    JMAPiece *b7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[B7] type:PAWN forColor:BLACK];
    [self.pieces addObject:b7Pawn];
    [self.blackPawns addObject:b7Pawn];
    
    JMAPiece *c7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[C7] type:PAWN forColor:BLACK];
    [self.pieces addObject:c7Pawn];
    [self.blackPawns addObject:c7Pawn];
    
    JMAPiece *d7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[D7] type:PAWN forColor:BLACK];
    [self.pieces addObject:d7Pawn];
    [self.blackPawns addObject:d7Pawn];
    
    JMAPiece *e7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[E7] type:PAWN forColor:BLACK];
    [self.pieces addObject:e7Pawn];
    [self.blackPawns addObject:e7Pawn];
    
    JMAPiece *f7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[F7] type:PAWN forColor:BLACK];
    [self.pieces addObject:f7Pawn];
    [self.blackPawns addObject:f7Pawn];
    
    JMAPiece *g7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[G7] type:PAWN forColor:BLACK];
    [self.pieces addObject:g7Pawn];
    [self.blackPawns addObject:g7Pawn];
    
    JMAPiece *h7Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[H7] type:PAWN forColor:BLACK];
    [self.pieces addObject:h7Pawn];
    [self.blackPawns addObject:h7Pawn];
    
    JMAPiece *a2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[A2] type:PAWN forColor:WHITE];
    [self.pieces addObject:a2Pawn];
    [self.whitePawns addObject:a2Pawn];
    
    JMAPiece *b2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[B2] type:PAWN forColor:WHITE];
    [self.pieces addObject:b2Pawn];
    [self.whitePawns addObject:b2Pawn];
    
    JMAPiece *c2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[C2] type:PAWN forColor:WHITE];
    [self.pieces addObject:c2Pawn];
    [self.whitePawns addObject:c2Pawn];
    
    JMAPiece *d2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[D2] type:PAWN forColor:WHITE];
    [self.pieces addObject:d2Pawn];
    [self.whitePawns addObject:d2Pawn];
    
    JMAPiece *e2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[E2] type:PAWN forColor:WHITE];
    [self.pieces addObject:e2Pawn];
    [self.whitePawns addObject:e2Pawn];
    
    JMAPiece *f2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[F2] type:PAWN forColor:WHITE];
    [self.pieces addObject:f2Pawn];
    [self.whitePawns addObject:f2Pawn];
    
    JMAPiece *g2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[G2] type:PAWN forColor:WHITE];
    [self.pieces addObject:g2Pawn];
    [self.whitePawns addObject:g2Pawn];
    
    JMAPiece *h2Pawn = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[H2] type:PAWN forColor:WHITE];
    [self.pieces addObject:h2Pawn];
    [self.whitePawns addObject:h2Pawn];
    
    JMAPiece *a1Rook = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[A1] type:ROOK forColor:WHITE];
    [self.pieces addObject:a1Rook];
    [self.whiteRooks addObject:a1Rook];
    
    JMAPiece *b1Knight = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[B1] type:KNIGHT forColor:WHITE];
    [self.pieces addObject:b1Knight];
    [self.whiteKnights addObject:b1Knight];
    
    JMAPiece *c1Bishop = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[C1] type:BISHOP forColor:WHITE];
    [self.pieces addObject:c1Bishop];
    [self.whiteBishops addObject:c1Bishop];
    
    JMAPiece *d1Queen = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[D1] type:QUEEN forColor:WHITE];
    [self.pieces addObject:d1Queen];
    [self.whiteQueens addObject:d1Queen];
    
    JMAPiece *e1King = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[E1] type:KING forColor:WHITE];
    [self.pieces addObject:e1King];
    self.whiteKing = e1King;
    
    JMAPiece *f1Bishop = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[F1] type:BISHOP forColor:WHITE];
    [self.pieces addObject:f1Bishop];
    [self.whiteBishops addObject:f1Bishop];
    
    JMAPiece *g1Knight = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[G1] type:KNIGHT forColor:WHITE];
    [self.pieces addObject:g1Knight];
    [self.whiteKnights addObject:g1Knight];
    
    JMAPiece *h1Rook = [[JMAPiece alloc] initWithSquare:self.squaresDictionary[H1] type:ROOK forColor:WHITE];
    [self.pieces addObject:h1Rook];
    [self.whiteRooks addObject:h1Rook];
}

/*
 This method returns the square from the squares dictionary for the incoming 
 coordinate parameter
*/
- (JMASquare *)squareforCoordinate:(NSString *)coordinate
{
    return [self.squaresDictionary objectForKey:coordinate];
}

/*
 This method returns the dictionary of squares
*/
- (NSDictionary *)squaresDictionary
{
    return _squaresDictionary;
}

- (NSArray *)piecesForGame
{
    return self.pieces;
}


/*
 If the half move index is even, the sideToMove property = White
 otherwise sideToMove = Black
*/
- (NSString *)sideToMove
{
    if (self.halfMoveIndex % TWO == ZERO) {
        return WHITE;
    } else {
        return BLACK;
    }
}

/*
 This method sets the moves array to the incoming moves parameter
*/
- (void)movesForGame:(NSArray *)moves
{
    self.moves = moves;
}

/*
 The method returns the count of the moves array property
*/
- (NSUInteger)halfMoveCount
{
    return [self.moves count];
}

/*
 This method returns the move object for the current halfMoveIndex from the 
 moves array
*/
- (JMAMove *)currentMove
{
    return self.moves[self.halfMoveIndex];
}

/*
 This method moves the piece on the first square object in the squares array
 to the second square object for the incoming square object.
*/
- (void)makeMove:(JMAMove *)move withSquares:(NSArray *)squares
{
    // check if move.isCastling
    // if isCastling call makeCastlingMove method
    if (move.isCastling) {
        [self makeCastlingMove:move withSquares:squares];
    }
    
    // grab reference to piece
    JMASquare *originSquare = squares[ZERO];
    JMASquare *destinationSquare = squares[ONE];
    
    JMAPiece *pieceToMove = originSquare.piece;
    
    // remove piece from origin square
    originSquare.piece = nil;
    
    if (move.isPromotion) {
        [self capturedPiece:pieceToMove forMove:move];
        return;
    }
    
    // if Move.isCapture remove square.piece reference
    if (move.isEnPassant) {
        JMASquare *square = [self squareforCoordinate:move.capturedPieceSquareCoordinate];
        [self capturedPiece:square.piece forMove:move];
        move.capturedPiece = square.piece;
        square.piece = nil;
    } else if (move.isCapture) {
        [self capturedPiece:destinationSquare.piece forMove:move];
        move.capturedPiece = destinationSquare.piece;
        destinationSquare.piece = nil;
    }
    
    pieceToMove.square = destinationSquare;
    destinationSquare.piece = pieceToMove;
    
    
    // add piece to destination square
   
}

/*
 This method will process a move if the isCastling Boolean is set to YES
*/
- (void)makeCastlingMove:(JMAMove *)move withSquares:(NSArray *)squares
{
    JMASquare *kingOriginSquare = squares[ZERO];
    JMASquare *kingDestinationSquare = squares[ONE];
    JMASquare *rookOriginSquare = squares[TWO];
    JMASquare *rookDestinationSquare = squares[THREE];
    
    JMAPiece *rook = rookOriginSquare.piece;
    JMAPiece *king = kingOriginSquare.piece;
    
    rookOriginSquare.piece = nil;
    kingOriginSquare.piece = nil;
    
    kingDestinationSquare.piece = king;
    rookDestinationSquare.piece = rook;
    
    rook.square = rookDestinationSquare;
    king.square = kingDestinationSquare;
    
}

/*
 This method adds the incoming piece parameter to the captured pieces array
 and calls a method to remove the piece from its piece type array.
*/
- (void)capturedPiece:(JMAPiece *)piece forMove:(JMAMove *)move
{
    // save piece in capturedPieces
    if (!self.capturedPieces) {
        self.capturedPieces = [[NSMutableArray alloc] init];
    }
    
    [self.capturedPieces addObject:piece];
    [self.pieces removeObject:piece];
    
    // remove piece from pieceArray
    if ([piece.color isEqualToString:WHITE]) {
        [self removeWhitePiece:piece];
    } else {
        [self removeBlackPiece:piece];
    }
    
}

/*
 This method removes the piece parameter from the white piece arrays for the 
 array of the piece type
*/
- (void)removeWhitePiece:(JMAPiece *)piece
{
    if ([piece.type isEqualToString:PAWN]) {
        
        [self.whitePawns removeObject:piece];
        
    } else if ([piece.type isEqualToString:KNIGHT]) {
        
        [self.whiteKnights removeObject:piece];
        
    } else if ([piece.type isEqualToString:BISHOP]) {
        
        [self.whiteBishops removeObject:piece];
        
    }  else if ([piece.type isEqualToString:ROOK]) {
        
        [self.whiteRooks removeObject:piece];
        
    } else {
        
        [self.whiteQueens removeObject:piece];
    }
}

/*
 This method removes the piece parameter from the black piece arrays for the
 array of the piece type
*/
- (void)removeBlackPiece:(JMAPiece *)piece
{
    if ([piece.type isEqualToString:PAWN]) {
        
        [self.blackPawns removeObject:piece];
        
    } else if ([piece.type isEqualToString:KNIGHT]) {
        
        [self.blackKnights removeObject:piece];
        
    } else if ([piece.type isEqualToString:BISHOP]) {
        
        [self.blackBishops removeObject:piece];
        
    }  else if ([piece.type isEqualToString:ROOK]) {
        
        [self.blackRooks removeObject:piece];
        
    } else {
        
        [self.blackQueens removeObject:piece];
    }

}

/*
 This method adds the incoming piece parameter to the corresponding White Piece
 array
*/
- (void)addWhitePiece:(JMAPiece *)piece
{
    if ([piece.type isEqualToString:PAWN]) {
        
        [self.whitePawns addObject:piece];
        
    } else if ([piece.type isEqualToString:KNIGHT]) {
        
        [self.whiteKnights addObject:piece];
        
    } else if ([piece.type isEqualToString:BISHOP]) {
        
        [self.whiteBishops addObject:piece];
        
    }  else if ([piece.type isEqualToString:ROOK]) {
        
        [self.whiteRooks addObject:piece];
        
    } else {
        
        [self.whiteQueens addObject:piece];
    }
}

/*
 This method adds the incoming piece parameter to the corresponding Black Piece
 array
*/
- (void)addBlackPiece:(JMAPiece *)piece
{
    if ([piece.type isEqualToString:PAWN]) {
        
        [self.blackPawns addObject:piece];
        
    } else if ([piece.type isEqualToString:KNIGHT]) {
        
        [self.blackKnights addObject:piece];
        
    } else if ([piece.type isEqualToString:BISHOP]) {
        
        [self.blackBishops addObject:piece];
        
    }  else if ([piece.type isEqualToString:ROOK]) {
        
        [self.blackRooks addObject:piece];
        
    } else {
        
        [self.blackQueens addObject:piece];
    }

}

/*
 This method creates a piece in the case of a promotion move and returns it.  
 In the process it is added to the piece arrays.
*/
- (JMAPiece *)createPieceForPromotionOnSquare:(JMASquare *)square forMove:(JMAMove *)move
{
    if (square.piece) {
        [self capturedPiece:square.piece forMove:move];
    }
    
    JMAPiece *newPiece = [[JMAPiece alloc] initWithSquare:square type:move.promotionPieceType forColor:move.sideToMove];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        [self addWhitePiece:newPiece];
    } else {
        [self addBlackPiece:newPiece];
    }

    [self.pieces addObject:newPiece];
    
    return newPiece;
    
}

/*
 This move resets the pieces and square to their state before the incoming
 move parameter.  First, if the move isCastling it is sent to the 
 makeCastlingMove method.  Then the originSquare and destinationSquare are 
 grabbed from the incoming squares array.  Then if the move isPromotion flag is 
 set it is sent to takebackPromotionMoveWithOriginSquare: method.  If the move 
 is not a Capture.  The piece on the origin square is set to the destination 
 square.  If the move is a capture the takebackCaptureMove: method is called.
*/
- (void)takebackMove:(JMAMove *)move withSquares:(NSArray *)squares;
{
    if (move.isCastling) {
        [self makeCastlingMove:move withSquares:squares];
        return;
    }
    
    JMASquare *originSquare = squares[ZERO];
    JMASquare *destinationSquare = squares[ONE];
    
    if (move.isPromotion) {
        [self takebackPromotionMoveWithOriginSquare:originSquare
                                  destinationSquare:destinationSquare];
    }
    
    if (!move.isCapture) {
        JMAPiece *piece = originSquare.piece;
        originSquare.piece = nil;
        destinationSquare.piece = piece;
        piece.square = destinationSquare;
    } else {
        [self takebackCaptureMove:move withOriginSquare:originSquare destinationSquare:destinationSquare];
    }
}

/*
 This method takes back the promotion portion of a move and replaces the 
 promoted piece with the pawn it was before promoting
*/
- (void)takebackPromotionMoveWithOriginSquare:(JMASquare *)originSquare
            destinationSquare:(JMASquare *)destinationSquare
{
    JMAPiece *pieceToRemove = originSquare.piece;
    JMAPiece *pieceToMove = [self.capturedPieces lastObject];
    
    if ([pieceToRemove.color isEqualToString:WHITE]) {
        [self removeWhitePiece:pieceToRemove];
        [self addWhitePiece:pieceToMove];
    } else {
        [self removeBlackPiece:pieceToRemove];
        [self addBlackPiece:pieceToMove];
    }
    
    [self.pieces addObject:pieceToMove];
    
    [self.pieces removeObject:pieceToRemove];
    [self.capturedPieces removeLastObject];
    
    pieceToMove.square = originSquare;
    originSquare.piece = pieceToMove;

}

/*
 This method processes the move if it is a capture move for a takeback.  First 
 the pieceon the originSquare is moved to the destination square.  Then the last
 captured piece is grabbed from the capturedPieces MutableArray and removed from
 that array.  Then if the capturedPiece is added back to the pieces' arrays.
 Finally, if the capture is not an en passant the origin square's piece property
 is set to the captured piece and vice versa.  If the capture is an en passant
 the captured piece's squareCoordinate property is used to grab the square to 
 put the captured piece on.
*/
- (void)takebackCaptureMove:(JMAMove *)move withOriginSquare:(JMASquare *)originSquare
                          destinationSquare:(JMASquare *)destinationSquare
{
    JMAPiece *pieceToMove = originSquare.piece;
    destinationSquare.piece = pieceToMove;
    pieceToMove.square = destinationSquare;
    
    JMAPiece *capturedPiece = [self.capturedPieces lastObject];
    [self.capturedPieces removeLastObject];
    
    if ([capturedPiece.color isEqualToString:WHITE]) {
        [self addWhitePiece:capturedPiece];
    } else {
        [self addBlackPiece:capturedPiece];
    }
    
    [self.pieces addObject:capturedPiece];
    
    if (!move.isEnPassant) {
        originSquare.piece = capturedPiece;
        capturedPiece.square = originSquare;
    } else {
        JMASquare *square = [self squareforCoordinate:move.capturedPieceSquareCoordinate];
        square.piece = capturedPiece;
        capturedPiece.square = square;
        originSquare.piece = nil;
    }
    
    
}
@end
