//
//  JMAMove.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/25/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMASquare;

@interface JMAMove : NSObject

- (id)initWithMoveString:(NSString *)moveString;

@property (strong, nonatomic) NSString *moveString;
@property (strong, nonatomic) NSString *capturedPieceSquareCoordinate;
@property (assign, nonatomic) BOOL isEnPassant;


- (NSString *)pieceType;
- (NSString *)destinationSquareCoordinate;
- (NSString *)originSquareCoordinate;

- (void)originSquareCoordinateFromSquare:(JMASquare *)square;

- (BOOL)isCapture;
- (BOOL)isCastling;
- (BOOL)isCheck;
- (BOOL)isPromotion;




@end
