//
//  JMAMove.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/25/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAMove : NSObject

@property (strong, nonatomic) NSString *moveString;

- (NSString *)pieceType;
- (NSString *)destinationSquareCoordinate;

- (BOOL)isCapture;
- (BOOL)isCastling;
- (BOOL)isCheck;




@end
