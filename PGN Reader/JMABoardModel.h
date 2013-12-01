//
//  JMABoardModel.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/21/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMASquare;
@class JMAPiece;
@class JMAMove;

@interface JMABoardModel : NSObject

// White Pieces
@property (strong, nonatomic, readonly) NSMutableArray *whitePawns;
@property (strong, nonatomic, readonly) NSMutableArray *whiteRooks;
@property (strong, nonatomic, readonly) NSMutableArray *whiteKnights;
@property (strong, nonatomic, readonly) NSMutableArray *whiteBishops;
@property (strong, nonatomic, readonly) NSMutableArray *whiteQueens;
@property (strong, nonatomic, readonly) JMAPiece *whiteKing;

//Black Pieces
@property (strong, nonatomic, readonly) NSMutableArray *blackPawns;
@property (strong, nonatomic, readonly) NSMutableArray *blackRooks;
@property (strong, nonatomic, readonly) NSMutableArray *blackKnights;
@property (strong, nonatomic, readonly) NSMutableArray *blackBishops;
@property (strong, nonatomic, readonly) NSMutableArray *blackQueens;
@property (strong, nonatomic, readonly) JMAPiece *blackKing;

@property (assign, nonatomic) NSUInteger halfMoveIndex;

- (NSString *)sideToMove;
- (NSDictionary *)squaresDictionary;
- (JMASquare *)squareforCoordinate:(NSString *)coordinate;

- (void)movesForGame:(NSArray *)moves;
- (JMAMove *)currentMove;

@end
