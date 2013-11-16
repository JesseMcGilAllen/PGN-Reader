//
//  JMAGameEngine.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/15/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAGameEngine.h"
#import "JMAChessConstants.h"

@interface JMAGameEngine ()

@property NSArray *validDiagonals;


@end

@implementation JMAGameEngine

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    [self loadValidDiagonals];
    
    return self;
}

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

@end
