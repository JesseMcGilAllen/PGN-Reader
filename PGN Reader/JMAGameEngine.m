//
//  JMAGameEngine.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/15/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAGameEngine.h"
#import "JMAConstants.h"
#import "JMAChessConstants.h"
#import "JMABoardModel.h"
#import "JMASquare.h"
#import "JMAPiece.h"
#import "JMAMove.h"

@interface JMAGameEngine ()

@property NSArray *validDiagonals;
@property NSDictionary *files;
@property NSDictionary *ranks;
@property NSDictionary *pieceTypeDictionary;

@property NSString *sideToMove;

@end

@implementation JMAGameEngine

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    [self loadValidDiagonals];
    [self loadFiles];
    [self loadRanks];
    
    return self;
}


/*
 This method loads the validDiagonals Array with arrays of square coordinates
 representing all the diagonals on a chess board.
*/
- (void)loadValidDiagonals
{
    NSArray *a1H8Diagonal = @[A1, B2, C3, D4, E5, F6, G7, H8];
    NSArray *a2G8Diagonal = @[A2, B3, C4, D5, E6, F7, G8];
    NSArray *a3F8Diagonal = @[A3, B4, C5, D6, E7, F8];
    NSArray *a4E8Diagonal = @[A4, B5, C6, D7, E8];
    NSArray *a5D8Diagonal = @[A5, B6, C7, D8];
    NSArray *a6C8Diagonal = @[A6, B7, C8];
    NSArray *a7B8Diagonal = @[A7, B8];
    NSArray *h1A8Diagonal = @[H1, G2, F3, E4, D5, C6, B7, A8];
    NSArray *h2B8Diagonal = @[H2, G3, F4, E5, D6, C7, B8];
    NSArray *h3C8Diagonal = @[H3, G4, F5, E6, D7, C8];
    NSArray *h4D8Diagonal = @[H4, G5, F6, E7, D8];
    NSArray *h5E8Diagonal = @[H5, G6, F7, E8];
    NSArray *h6F8Diagonal = @[H6, G7, F8];
    NSArray *h7G8Diagonal = @[H7, G8];
    NSArray *b1A2Diagonal = @[B1, A2];
    NSArray *c1A3Diagonal = @[C1, B2, A3];
    NSArray *d1A4Diagonal = @[D1, C2, B3, A4];
    NSArray *e1A5Diagonal = @[E1, D2, C3, B4, A5];
    NSArray *f1A6Diagonal = @[F1, E2, D3, C4, B5, A6];
    NSArray *g1A7Diagonal = @[G1, F2, E3, D4, C5, B6, A7];
    NSArray *g1H2Diagonal = @[G1, H2];
    NSArray *f1H3Diagonal = @[F1, G2, H3];
    NSArray *e1H4Diagonal = @[E1, F2, G3, H4];
    NSArray *d1H5Diagonal = @[D1, E2, F3, G4, H5];
    NSArray *c1H6Diagonal = @[C1, D2, E3, F4, G5, H6];
    NSArray *b1H7Diagonal = @[B1, C2, D3, E4, F5, G6, H7];
    
    self.validDiagonals = @[a1H8Diagonal, a2G8Diagonal, a3F8Diagonal,
                            a4E8Diagonal, a5D8Diagonal, a6C8Diagonal,
                            a7B8Diagonal, b1A2Diagonal, b1H7Diagonal,
                            c1A3Diagonal, c1H6Diagonal, d1A4Diagonal,
                            d1H5Diagonal, e1A5Diagonal, e1H4Diagonal,
                            f1A6Diagonal, f1H3Diagonal, g1A7Diagonal,
                            g1H2Diagonal, h1A8Diagonal, h2B8Diagonal,
                            h3C8Diagonal, h4D8Diagonal, h5E8Diagonal,
                            h6F8Diagonal, h7G8Diagonal];
}


/*
 This method loads the files dictionary property with a square coordinate array
 for each file.
*/
- (void)loadFiles
{
    NSArray *aFile = @[A1, A2, A3, A4, A5, A6, A7, A8];
    NSArray *bFile = @[B1, B2, B3, B4, B5, B6, B7, B8];
    NSArray *cFile = @[C1, C2, C3, C4, C5, C6, C7, C8];
    NSArray *dFile = @[D1, D2, D3, D4, D5, D6, D7, D8];
    NSArray *eFile = @[E1, E2, E3, E4, E5, E6, E7, E8];
    NSArray *fFile = @[F1, F2, F3, F4, F5, F6, F7, F8];
    NSArray *gFile = @[G1, G2, G3, G4, G5, G6, G7, G8];
    NSArray *hFile = @[H1, H2, H3, H4, H5, H6, H7, H8];
    
    self.files = @{@"a" : aFile, @"b" : bFile, @"c" : cFile, @"d" : dFile,
                   @"e" : eFile, @"f" : fFile, @"g" : gFile, @"h" : hFile};
}

/*
 This method loads the ranks dictionary property with arrays for the string rank
 key.  The arrays contain the square coordinates of the squares on each rank.
*/
- (void)loadRanks
{
    NSArray *firstRank = @[A1, B1, C1, D1, E1, F1, G1, H1];
    NSArray *secondRank = @[A2, B2, C2, D2, E2, F2, G2, H2];
    NSArray *thirdRank = @[A3, B3, C3, D3, E3, F3, G3, H3];
    NSArray *fourthRank = @[A4, B4, C4, D4, E4, F4, G4, H4];
    NSArray *fifthRank = @[A5, B5, C5, D5, E5, F5, G5, H5];
    NSArray *sixthRank = @[A6, B6, C6, D6, E6, F6, G6, H6];
    NSArray *seventhRank = @[A7, B7, C7, D7, E7, F7, G7, H7];
    NSArray *eighthRank = @[A8, B8, C8, D8, E8, F8, G8, H8];
    
    self.ranks = @{@"1" : firstRank, @"2" : secondRank, @"3" : thirdRank,
                   @"4" : fourthRank, @"5" : fifthRank, @"6" : sixthRank,
                   @"7" : seventhRank, @"8" : eighthRank};
}


/*
 This method returns the squares involved for the incoming move parameter
 the first element in the array is the origin square of the piece that moves
 the second element in the array is the destination square of the move.
*/
- (NSArray *)squaresInvolvedInMove:(JMAMove *)move
{
    self.sideToMove = [self.model sideToMove];
    NSArray *squaresInvolved;
    
    
    if ([move.pieceType isEqualToString:CASTLE]) {
        
        squaresInvolved = [self squaresInvolvedForCastlingMove:move.moveString];
        
    } else if ([move.pieceType isEqualToString:KING]) {
        
        JMAPiece *king = [self kingForSideToMove:self.sideToMove];
        squaresInvolved = [self squaresInvolvedforKing:king withMove:move];
        
    } else {
        
        NSArray *pieces;
        pieces = [self piecesForPieceType:move.pieceType];
        squaresInvolved = [self squaresInvolvedWithPieceInPieces:pieces forMove:move];
        
    }
    
    [move originSquareCoordinateFromSquare:squaresInvolved[ZERO]];
    
    return squaresInvolved;
}

/*
 This method returns an array of the squares involved for a castling move
*/
- (NSArray *)squaresInvolvedForCastlingMove:(NSString *)move
{
    NSMutableArray *squaresInvolved = [[NSMutableArray alloc] init];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        [squaresInvolved addObject:[self.model squareforCoordinate:E1]];
        
        if ([move isEqualToString:KINGSIDE_CASTLING]) {
            
            [squaresInvolved addObject:[self.model squareforCoordinate:G1]];
            [squaresInvolved addObject:[self.model squareforCoordinate:H1]];
            [squaresInvolved addObject:[self.model squareforCoordinate:F1]];
            
        } else {
            
            [squaresInvolved addObject:[self.model squareforCoordinate:C1]];
            [squaresInvolved addObject:[self.model squareforCoordinate:A1]];
            [squaresInvolved addObject:[self.model squareforCoordinate:D1]];
        }
        
    } else {
        [squaresInvolved addObject:[self.model squareforCoordinate:E8]];
        
        if ([move isEqualToString:KINGSIDE_CASTLING]) {
            
            [squaresInvolved addObject:[self.model squareforCoordinate:G8]];
            [squaresInvolved addObject:[self.model squareforCoordinate:H8]];
            [squaresInvolved addObject:[self.model squareforCoordinate:F8]];
            
        } else {
            
            [squaresInvolved addObject:[self.model squareforCoordinate:C8]];
            [squaresInvolved addObject:[self.model squareforCoordinate:A8]];
            [squaresInvolved addObject:[self.model squareforCoordinate:D8]];
        }
    }
    
    return squaresInvolved;
}

/*
 This method returns the squares for a King move
*/
- (NSArray *)squaresInvolvedforKing:(JMAPiece *)king withMove:(JMAMove *)move
{
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    NSArray *squaresInvolved = @[king.square, destinationSquare];
    
    return squaresInvolved;
}


/*
 This method returns the king for sideToMove parameter
*/
- (JMAPiece *)kingForSideToMove:(NSString *)sideToMove
{
    if ([sideToMove isEqualToString:WHITE]) {
        return self.model.whiteKing;
    } else {
        return self.model.blackKing;
    }
}

/*
 This method calls the squaresInvolved method for the piece type that the array 
 of pieces contain.
*/
- (NSArray *)squaresInvolvedWithPieceInPieces:(NSArray *)pieces forMove:(JMAMove *)move
{
    NSArray *squaresInvolved;
    JMAPiece *piece;
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    
    if ([move.pieceType isEqualToString:PAWN]) {
        piece = [self pawnInvolvedInMove:move];
    } else if ([move.pieceType isEqualToString:KNIGHT]) {
        piece = [self knightInvolvedInMove:move];
    } else if ([move.pieceType isEqualToString:BISHOP]) {
        piece = [self bishopInvolvedInMove:move];
    } else if ([move.pieceType isEqualToString:ROOK]) {
        piece = [self rookInvolvedInMove:move];
    } else if ([move.pieceType isEqualToString:QUEEN]) {
        piece = [self queenInvolvedInMove:move];
    }
    
    squaresInvolved = @[piece.square, destinationSquare];
    
    return squaresInvolved;
}

/*
 This method returns the array of piece that could suit the move
*/
- (NSArray *)piecesForPieceType:(NSString *)pieceType
{
    if ([self.sideToMove isEqualToString:WHITE]) {
        
        if ([pieceType isEqualToString:PAWN]) {
            return [self.model whitePawns];
        } else if ([pieceType isEqualToString:KNIGHT]) {
            return [self.model whiteKnights];
        } else if ([pieceType isEqualToString:BISHOP]) {
            return [self.model whiteBishops];
        } else if ([pieceType isEqualToString:ROOK]) {
            return [self.model whiteRooks];
        } else if ([pieceType isEqualToString:QUEEN]) {
            return [self.model whiteQueens];
        }
    } else {
        
        if ([pieceType isEqualToString:PAWN]) {
            return [self.model blackPawns];
        } else if ([pieceType isEqualToString:KNIGHT]) {
            return [self.model blackKnights];
        } else if ([pieceType isEqualToString:BISHOP]) {
            return [self.model blackBishops];
        } else if ([pieceType isEqualToString:ROOK]) {
            return [self.model blackRooks];
        } else if ([pieceType isEqualToString:QUEEN]) {
            return [self.model blackQueens];
        }
    }
    
    return @[];
}

#pragma mark - Pawn Move Methods
/*
 This method returns an array of squares involved for a pawn move
*/
- (JMAPiece *)pawnInvolvedInMove:(JMAMove *)move
{
    JMAPiece *pawn;
    NSArray *pawns;
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        pawns = self.model.whitePawns;
    } else {
        pawns = self.model.blackPawns;
    }
    
    if (![move isCapture]) {
        pawn = [self pawnFromPawns:pawns forNormalMove:move];
    } else {
        pawn = [self pawnFromPawns:pawns forMoveInvolvingCapture:move];
    }
    
    return pawn;
}

/*
 This method returns the proper pawn for an non-capture move.
Otherwise an empty pawn object is returned to satisfy xCode.
*/
- (JMAPiece *)pawnFromPawns:(NSArray *)pawns forNormalMove:(JMAMove *)move
{
    
    
    for (JMAPiece *pawn in pawns) {
        if ([self isPawn:pawn rightForNonCaptureMove:move]) {
            return pawn;
        }
    }
    
    return nil;
}

/*
 First the square object from the move's coordinate is fetched.
 Then the file property from the square is compared to the each pawn's square
 file property.  If they match then the rank properties are check if they are
 within one of each other or two if the pawn sits on its original square.
 if a pawn matches the criteria, YES is returned.
*/
- (BOOL)isPawn:(JMAPiece *)pawn rightForNonCaptureMove:(JMAMove *)move
{
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    
    if ([pawn.square.file isEqualToString:destinationSquare.file]) {

        NSUInteger pawnRankValue = [pawn.square.rank integerValue];
        NSUInteger squareRankValue = [destinationSquare.rank integerValue];
        
        if ([self.sideToMove isEqualToString:WHITE]) {
            
            if ((pawnRankValue + ONE) == squareRankValue) {
                return YES;
                
            } else if ([pawn onOriginalSquare] &&
                       (pawnRankValue + TWO) == squareRankValue) {
                
                return YES;
            }
        } else  {
            
            if ((pawnRankValue - ONE) == squareRankValue) {
                return YES;
                
            } else if ([pawn onOriginalSquare] &&
                       (pawnRankValue - TWO) == squareRankValue) {
                
                return YES;
            }
        }
    }
    
    return NO;

}

/*
 This method returns a pawn object for a move involving a capture.
 The destinationSquare is gotten from the move's
 destinationSquareCoordinate property.  The piece property is gotten from the 
 destinationSquare.  A logic check is used to see if a piece currently resides
 on the square.  If not, the isEnPassant property of the move object is set to 
 YES.  Each pawn in the pawns array is sent to isPawn:rightForCapture move.  
 If YES is returned the pawn is returned.
*/
- (JMAPiece *)pawnFromPawns:(NSArray *)pawns
    forMoveInvolvingCapture:(JMAMove *)move
{
    
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    JMAPiece *destinationSquarePiece = destinationSquare.piece;
    
    if (!destinationSquarePiece) {
        move.isEnPassant = YES;
    }
    
    for (JMAPiece *pawn in pawns) {
        if ([self isPawn:pawn rightForCaptureMove:move]) {
            return pawn;
        }
    }
    
    return nil;
}


/*
 First the first character of the move String is saved in a String object called
 pawnFile. The destinationSquare's file property is  checked to see if matches 
 the pawnFile.  If it matches the rank is checked to see if it is one rank apart.
 If so, then Yes is returned.
*/
- (BOOL)isPawn:(JMAPiece *)pawn rightForCaptureMove:(JMAMove *)move
{
    NSString *pawnFile = [move.moveString substringToIndex:ONE];
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    
    if ([pawn.square.file isEqualToString:pawnFile]) {
        
        NSUInteger pawnRankValue = [pawn.square.rank integerValue];
        NSUInteger squareRankValue = [destinationSquare.rank integerValue];
        
        if ([self.sideToMove isEqualToString:WHITE]) {
            
            if (pawnRankValue + ONE == squareRankValue) {
                return YES;
                
            }
        } else {
            
            if (pawnRankValue - ONE == squareRankValue ) {
                return YES;
                
            }
        }
        
    }
    
    return NO;

}

#pragma mark - Knight Move Methods
/*
 This method returns an array of squares involved for a knights move
*/
- (JMAPiece *)knightInvolvedInMove:(JMAMove *)move
{
    JMAPiece *knight;
    NSArray *knights;
    NSUInteger moveLength = [move.moveString length];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        knights = self.model.whiteKnights;
    } else {
        knights = self.model.blackKnights;
    }
    
    if (moveLength == THREE || (moveLength == FOUR && move.isCapture)) {
        knight = [self knightFromKnights:knights forMove:move];
    } else {
        NSString *rankOrFile = [move.moveString substringWithRange:NSMakeRange(ONE, ONE)];
        knight = [self pieceFromPieces:knights withRankOrFile:rankOrFile];
    }
    
    
    
    return knight;
}


/*
 This method returns the proper knight from the knights array for the move 
 object.
*/
- (JMAPiece *)knightFromKnights:(NSArray *)knights forMove:(JMAMove *)move
{
    if ([knights count] == ONE) {
        return knights[ZERO];
    }
    
    for (JMAPiece *knight in knights) {
        if ([self isKnight:knight rightForMove:move]) {
            return knight;
        }
    }
    
    return nil;
}

/*
 This method gets integer value for the rank and an index value from an
 array in the filesDictionary of the file for both the destination square and
 the square the knight sits on.  The method then gets the absolute
 value of the difference between the ranks of the two squares and the files of
 the squares.  If the difference of the ranks is One while the difference of the
 files is Two, or the difference of the files is two and the ranks one
 the isKingSafe Method is called.  If that method returns YES then YES is 
 returned, Otherwise NO is returned.
*/

- (BOOL)isKnight:(JMAPiece *)knight rightForMove:(JMAMove *)move
{
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    
    int squareRank = [destinationSquare.rank intValue];
    int squareFileIndex = [self indexOfFileforSquare:destinationSquare];
    
    int knightRank = [knight.square.rank intValue];
    int knightFileIndex = [self indexOfFileforSquare:knight.square];
    
    int rankDifference = abs(squareRank - knightRank);
    int fileDifference = abs(knightFileIndex - squareFileIndex);
    
    if ((rankDifference == ONE && fileDifference == TWO) ||
        (rankDifference == TWO && fileDifference == ONE)) {
        
        if ([self isKingSafeWithMoveFromSquare:knight.square toSquare:destinationSquare]) {
            return YES;
        }
    }
        return NO;
}
/*
 This method returns the index of the file from the pertinent file array in the
 files dictionary property for the incoming square parameter.
 First an array of keys from the files property is gotten.  Then that array is 
 sorted alphabetically. The index of the incoming square's object in the files
 array is returned.
*/
- (int)indexOfFileforSquare:(JMASquare *)square
{
    NSArray *files = [self.files allKeys];
    
    files = [files sortedArrayUsingSelector:@selector(localizedCompare:)];
   
    int fileIndex = [files indexOfObject:square.file];
    
    return fileIndex;
}


- (JMAPiece *)pieceFromPieces:(NSArray *)pieces withRankOrFile:(NSString *)rankOrFile
{
    for (JMAPiece *piece in pieces) {
        if ([piece.square.rank isEqualToString:rankOrFile]) {
            return piece;
        } else if ([piece.square.file isEqualToString:rankOrFile]) {
            return piece;
        }
    }
    
    return nil;
}

#pragma mark - Bishop Move Methods
/*
 This method returns an array of squares involved for a bishops move
 */
- (JMAPiece *)bishopInvolvedInMove:(JMAMove *)move
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    JMAPiece *bishop;
    NSArray *bishops;
    NSUInteger moveLength = [move.moveString length];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        bishops = self.model.whiteBishops;
    } else {
        bishops = self.model.blackBishops;
    }
    
    if (moveLength == THREE || (moveLength == FOUR && move.isCapture)) {
        bishop = [self bishopFromBishops:bishops forMove:move];
    } else {
        NSString *rankOrFile = [move.moveString substringWithRange:NSMakeRange(ONE, ONE)];
        bishop = [self pieceFromPieces:bishops withRankOrFile:rankOrFile];
    }
    
    return bishop;
}

/*
 This method returns the proper bishop from the bishops array for the move 
 object
*/
- (JMAPiece *)bishopFromBishops:(NSArray *)bishops forMove:(JMAMove *)move
{
   NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    if ([bishops count] == ONE) {
        return bishops[ZERO];
    }
 NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    for (JMAPiece *bishop in bishops) {
        if ([self isBishop:bishop rightForMove:move]) {
            return bishop;
        }
    }
    
    return nil;
}

/*
 This method gets the diagonals that contain both the coordinate of the square
 the piece sits on and the coordinate of the destination square.
*/
- (BOOL)isBishop:(JMAPiece *)bishop rightForMove:(JMAMove *)move
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    BOOL isBishopRightForMove = NO;
    NSString *pieceCoordinate = bishop.square.coordinate;
    NSString *squareCoordinate = move.destinationSquareCoordinate;
    
    NSArray *diagonal = [self diagonalContainingPieceCoordinate:pieceCoordinate
                                                 SquareCoordinate:squareCoordinate];
    
    
    if ([diagonal count] > ZERO) {
        BOOL isPathClear = [self isPathClearBetweenPieceCoordinate:pieceCoordinate
                                                  squareCoordinate:squareCoordinate
                                              onRankFileOrDiagonal:diagonal];
        
        if (isPathClear) {
            
            isBishopRightForMove = [self isKingSafeWithMoveFromSquare:bishop.square
                                                             toSquare:[self.model squareforCoordinate:squareCoordinate]];
        }
        
    }
    return isBishopRightForMove;
}
/*
 This method check each square on the incoming rankFileOrDiagonal array to make 
 sure no squares are occupied by pieces in between the piece and destination 
 square.
 
*/
- (BOOL)isPathClearBetweenPieceCoordinate:(NSString *)pieceCoordinate squareCoordinate:(NSString *)squareCoordinate onRankFileOrDiagonal:(NSArray *)rankFileOrDiagonal
{
    BOOL isPathClear = NO;
    BOOL isInBetween = NO;
    
    for (NSString *coordinate in rankFileOrDiagonal) {
        
        if ([coordinate isEqualToString:pieceCoordinate] || [coordinate isEqualToString:squareCoordinate]) {
            
            if (isInBetween) {
                if (isPathClear) {
                    return isPathClear;
                }
            }
            
            isPathClear = YES;
            isInBetween = YES;
            
        } else if (isInBetween) {
            JMASquare *square = [self.model squareforCoordinate:coordinate];
            
            if (square.piece) {
                isPathClear = NO;
                return isPathClear;
            }
        }
    }
    
    
    return isPathClear;
}

/*
 This method checks the validDiagonals property for a diagonal array that 
 contains both parameters.  If a diagonal contains both parameters it is returned.
*/
- (NSArray *)diagonalContainingPieceCoordinate:(NSString *)pieceCoordinate SquareCoordinate:(NSString *)squareCoordinate
{
    for (NSArray *diagonal in self.validDiagonals) {
        if ([diagonal containsObject:pieceCoordinate] &&
            [diagonal containsObject:squareCoordinate]) {
            
            return diagonal;
        }
    }
    
    return @[];
}

#pragma mark - Rook Move Methods

/*
 This method returns an array of squares involved for a rook move
*/
- (JMAPiece *)rookInvolvedInMove:(JMAMove *)move
{
    NSArray *rooks;
    JMAPiece *rook;
    NSUInteger moveLength = [move.moveString length];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        rooks = self.model.whiteRooks;
    } else {
        rooks = self.model.blackRooks;
    }
    
    if (moveLength == THREE || (moveLength == FOUR && move.isCapture)) {
        rook = [self rookFromRooks:rooks forMove:move];
    } else {
        NSString *rankOrFile = [move.moveString substringWithRange:NSMakeRange(ONE, ONE)];
        rook = [self pieceFromPieces:rooks withRankOrFile:rankOrFile];
    }
    
    
    return nil;
}


/*
 This method calls the isRookRightForMove method for each rook.  If YES is 
 returned the rook is returned.
*/
- (JMAPiece *)rookFromRooks:(NSArray *)rooks forMove:(JMAMove *)move
{
    if ([rooks count] == ONE) {
        return rooks[ZERO];
    }
    
    for (JMAPiece *rook in rooks) {
        
        if ([self isRook:rook rightForMove:move]) {
            return rook;
        }
        
    }
    return nil;
}

/*
 This method determines whether the rook shares the file or rank with the 
 destination square.  The isPathClearBetweenPieceCoordinate: method is called, 
 passing in the destinationSquare coordinate, the piece's square coordinate and 
 an array of square coordinates for the shared file/rank.  If YES is returned 
 from the isPathClearBetweenPieceCoordinate: method, then the Rook's square is 
 sent to the isKingSafeWithMoveFromSquare: method.  The result of that method is
 returned.
*/
- (BOOL)isRook:(JMAPiece *)rook rightForMove:(JMAMove *)move
{
    JMASquare *destinationSquare = [self.model squareforCoordinate:move.destinationSquareCoordinate];
    BOOL isRookRightForMove = NO;
    BOOL isPathClear = NO;
    
    if ([rook.square.file isEqualToString:destinationSquare.file]) {
       NSArray *squaresForFile = self.files[destinationSquare.file];
        
        isPathClear = [self isPathClearBetweenPieceCoordinate:rook.square.coordinate
                                             squareCoordinate:destinationSquare.coordinate
                                         onRankFileOrDiagonal:squaresForFile];
        
    } else if ([rook.square.rank isEqualToString:destinationSquare.rank]) {
        NSArray *squaresForRank = self.ranks[destinationSquare.rank];
        
        isPathClear = [self isPathClearBetweenPieceCoordinate:rook.square.coordinate
                                             squareCoordinate:destinationSquare.coordinate
                                         onRankFileOrDiagonal:squaresForRank];
    }
    
    if (isPathClear) {
        isRookRightForMove = [self isKingSafeWithMoveFromSquare:rook.square
                                                       toSquare:destinationSquare];
    }
    
    return isRookRightForMove;
}

#pragma mark - Queen Move Methods

/*
 This method returns an array of squares involved for a queen move
*/
- (JMAPiece *)queenInvolvedInMove:(JMAMove *)move
{
    JMAPiece *queen;
    NSArray *queens;
    NSUInteger moveLength = [move.moveString length];
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        queens = self.model.whiteQueens;
    } else {
        queens = self.model.blackQueens;
    }
    
    if (moveLength == THREE || (moveLength == FOUR && move.isCapture)) {
        
    } else {
        NSString *rankOrFile = [move.moveString substringWithRange:NSMakeRange(ONE, ONE)];
        queen = [self pieceFromPieces:queens withRankOrFile:rankOrFile];
    }
    
    
    return nil;
}

/*
 This method calls the isQueen:rightForMove: method for each queen in the 
 incoming queens array. if YES is returned the queen is returned.
*/
- (JMAPiece *)queenFromQueens:(NSArray *)queens forMove:(JMAMove *)move
{
    if ([queens count] == ONE) {
        return queens[ZERO];
    }
    
    for (JMAPiece *queen in queens) {
        if ([self isQueen:queen rightForMove:move]) {
            return queen;
        }
    }
    
    return nil;
}

/*
 This method checks if the queen shares a diagonal, file, or rank with the move
 The isPathClearBetweenPieceCoordinate: is called passing in the piece square's
 coordinate, the move's destination square coordinate and shared 
 diagonal/rank/file.  If YES is returned the isKingSafe: method is called.  The 
 result of that method call is returned.
*/
- (BOOL)isQueen:(JMAPiece *)queen rightForMove:(JMAMove *)move
{
    // Check for Shared Diagonal
    NSString *pieceCoordinate = queen.square.coordinate;
    NSString *squareCoordinate = move.destinationSquareCoordinate;
    JMASquare *destinationSquare = [self.model squareforCoordinate:squareCoordinate];
    
    NSArray *diagonal = [self diagonalContainingPieceCoordinate:pieceCoordinate
                                               SquareCoordinate:squareCoordinate];
    
    BOOL isPathClear;
    BOOL isQueenRightForMove = NO;
    NSArray *diagonalSquareOrFile;
    
    if ([diagonal count] > ZERO) {
        diagonalSquareOrFile = diagonal;
        
    } else {
        
        if ([queen.square.file isEqualToString:destinationSquare.file]) {
            diagonalSquareOrFile = self.files[destinationSquare.file];
            
        } else if ([queen.square.rank isEqualToString:destinationSquare.rank]) {
            diagonalSquareOrFile = self.ranks[destinationSquare.rank];
        }
    }
    
    isPathClear = [self isPathClearBetweenPieceCoordinate:pieceCoordinate squareCoordinate:squareCoordinate onRankFileOrDiagonal:diagonalSquareOrFile];
    
    if (isPathClear) {
        isQueenRightForMove = [self isKingSafeWithMoveFromSquare:queen.square toSquare:destinationSquare];
    }
    
    return isQueenRightForMove;

}

# pragma mark - King Safety Methods

/*
 This method checks the king for the side to move's color to make sure that is 
 not attacked by pieces of the opposite color after the potential move
*/
- (BOOL)isKingSafeWithMoveFromSquare:(JMASquare *)originSquare
                            toSquare:(JMASquare *)destinationSquare
{
    
     JMAPiece *destinationSquarePiece = [self pieceFromKingCheckSetupWithOriginSquare:originSquare
                                                                    destinationSquare:destinationSquare];
    
     JMASquare *squareOfKing = [self squareOfKing];
    
    BOOL isKingSafe;

    BOOL isKingSafeOnDiagonals = [self isSafeFromAttackOnDiagonalsWithKingOnSquare:squareOfKing];
    BOOL isKingSafeOnRankAndFile = [self isSafeFromAttackOnRanksAndFilesForKingSquare:squareOfKing];
    
    if (isKingSafeOnDiagonals && isKingSafeOnRankAndFile) {
        isKingSafe = YES;
    } else {
        isKingSafe = NO;
    }
    
    [self resetOriginSquare:originSquare
          destinationSquare:destinationSquare
 withDestinationSquarePiece:destinationSquarePiece];
    
    return isKingSafe;
}


/*
 This method moves the piece from the origin square to the destination square 
 and returns the piece on the destination square.
*/
- (JMAPiece *)pieceFromKingCheckSetupWithOriginSquare:(JMASquare *)originSquare
                                    destinationSquare:(JMASquare *)destinationSquare
{
    JMAPiece *pieceToMove = originSquare.piece;
    JMAPiece *pieceToRemove = destinationSquare.piece;
    
    originSquare.piece = nil;
    destinationSquare.piece = pieceToMove;
    
    return pieceToRemove;
}

/*
 This method moves the piece on the destination Square's property to the 
 origin square and sets that property to the destinationSquarePiece 
 parameter.
*/
- (void)resetOriginSquare:(JMASquare *)originSquare
        destinationSquare:(JMASquare *)destinationSquare
withDestinationSquarePiece:(JMAPiece *)destinationSquarePiece
{
    originSquare.piece = destinationSquare.piece;
    destinationSquare.piece = destinationSquarePiece;
}


/*
 This method gets the king for the board model for the sideToMove and returns
 the square it currently sits on
*/
- (JMASquare *)squareOfKing
{
    JMASquare *kingSquare;
    JMAPiece *king;
    
    if ([self.sideToMove isEqualToString:WHITE]) {
        king = [self.model whiteKing];
    } else {
        king = [self.model blackKing];
    }
    
    kingSquare = king.square;
    
    return kingSquare;
}

/*
 This method checks each array of diagonals in the validDiagonals property if the
 king is attacked.
*/
- (BOOL)isSafeFromAttackOnDiagonalsWithKingOnSquare:(JMASquare *)kingSquare
{
    BOOL isKingSafe = YES;
    
    for (NSArray *diagonal in self.validDiagonals) {
        isKingSafe = [self isSafeFromAttackFromPieceType:BISHOP
                                               PieceType:QUEEN
                                    onRankFileOrDiagonal:diagonal
                                                withKingSquare:kingSquare];
        
        if (!isKingSafe) {
            return isKingSafe;
        }
    }
    
    return isKingSafe;
}

/*
 This method checks the incoming rankFileOrDiagonal array for the existence of 
 the square the incoming king object sits on.  If the square exists each square 
 is checked for the existence of either pieceType parameter of the opposite color
 of the side to move.If an instance of the piece types have a clear path to the king, NO is returned.
 Otherwise, YES is returned.
*/
- (BOOL)isSafeFromAttackFromPieceType:(NSString *)pieceOne
                            PieceType:(NSString *)pieceTwo
                 onRankFileOrDiagonal:(NSArray *)rankFileOrDiagonal
                             withKingSquare:(JMASquare *)kingSquare
{
    BOOL isKingSafe = YES;
    
    if (![rankFileOrDiagonal containsObject:kingSquare.coordinate]) {
        return isKingSafe;
    }
    
    for (NSString *coordinate in rankFileOrDiagonal) {
        JMASquare *square = [self.model squareforCoordinate:coordinate];
        JMAPiece *piece = square.piece;
        
        if ([square isEqual:kingSquare]) {
            if (!isKingSafe) {
                return isKingSafe;
            }
        }
        
        if (piece) {
            if ([piece.color isEqualToString:self.sideToMove]) {
                isKingSafe = YES;
            } else {
                if ([piece.type isEqualToString:pieceOne] ||
                    [piece.type isEqualToString:pieceTwo]) {
                    
                    isKingSafe = NO;
                }
            }
        }
    }
    
    return isKingSafe;
}

/*
 This method gets the array corresponding to kingSquare's rank and the array
 corresponding to the kingSquare's file.  It calls the 
 isSafeFromAttackFromPieceType method for both and returns YES if the both 
 return YES or NO if one or more return NO.
*/
- (BOOL)isSafeFromAttackOnRanksAndFilesForKingSquare:(JMASquare *)kingSquare
{
    BOOL isKingSafe;
    NSArray *file = self.files[kingSquare.file];
    NSArray *rank = self.ranks[kingSquare.rank];
    
    isKingSafe = [self isSafeFromAttackFromPieceType:QUEEN
                                           PieceType:ROOK
                                onRankFileOrDiagonal:rank
                                      withKingSquare:kingSquare];
    
    if (isKingSafe) {
        isKingSafe = [self isSafeFromAttackFromPieceType:QUEEN
                                               PieceType:ROOK
                                    onRankFileOrDiagonal:file
                                          withKingSquare:kingSquare];
    }
    
    return isKingSafe;
}
@end
