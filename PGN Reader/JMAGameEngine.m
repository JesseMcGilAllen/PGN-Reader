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

@interface JMAGameEngine ()

@property NSArray *validDiagonals;
@property NSDictionary *files;
@property NSDictionary *ranks;
@property NSDictionary *pieceTypeDictionary;

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
    [self configurePieceTypeDictionary];
    
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
 This method sets the pieceType Dictionary
*/
- (void)configurePieceTypeDictionary
{
    self.pieceTypeDictionary = @{@"K" : KING,
                                 @"Q" : QUEEN,
                                 @"B" : BISHOP,
                                 @"N" : KNIGHT,
                                 @"O" : @"Castle"};
}

/*
 This method returns the squares involved for the incoming move parameter
 the first element in the array is the origin square of the piece that moves
 the second element in the array is the destination square of the move.
*/
- (NSArray *)squaresInvolvedInMove:(NSString *)move
{
    //NSMutableArray *squaresInvolved = [[NSMutableArray alloc] init];
    
    NSString *pieceType = [self determinePieceTypeForMove:move];
    
    NSArray *squaresInvolved = [self squaresInvolvedforMove:move
                                              withPieceType:pieceType];
    return squaresInvolved;
}

/*
 This method returns the squares involved for the move and piece type parameter
*/
- (NSArray *)squaresInvolvedforMove:(NSString *)move withPieceType:(NSString *)pieceType
{
    NSArray *squaresInvolved;
    
    if ([pieceType isEqualToString:CASTLE]) {
        squaresInvolved = [self squaresInvolvedForCastlingMove:move];
    }
    
    return squaresInvolved;
}
/*
 This method returns the proper piece array from the board model for the 
 incoming piece type string
*/
- (NSArray *)piecesForPieceType:(NSString *)pieceType
{
    return @[];
}
/*
 This method checks the first letter of the incoming string for a match in the 
 piece type dictionary.
 if a match is found the value of the key is returned otherwise the value
 "Pawn" is returned.
*/
- (NSString *)determinePieceTypeForMove:(NSString *)move
{
    NSString *type = self.pieceTypeDictionary[[move substringToIndex:ONE]];
    
    if (type) {
        return type;
    } else {
        return PAWN;
    }
    
}


/*
 This method returns an array of the squares involved for a castling move
*/
- (NSArray *)squaresInvolvedForCastlingMove:(NSString *)move
{
    NSMutableArray *squaresInvolved = [[NSMutableArray alloc] init];
    
    if ([self.model.sideToMove isEqualToString:WHITE]) {
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
 This method checks the king for the side to move's color to make sure that is 
 not attacked by pieces of the opposite color after the potential move
*/
- (BOOL)isKingSafe
{
    
    // - (BOOL) check diagonals
    // - (BOOL) check files
    // - (BOOL) check ranks
    
    /* 
       if files, ranks, and diagonals are clear
        return YES
       else
         return NO
    */
    
    return NO;
}

@end
