//
//  JMAGameEngine.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/15/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMABoardModel;
@class JMAMove;

@interface JMAGameEngine : NSObject

@property (strong, nonatomic) JMABoardModel *model;

- (NSArray *)squaresInvolvedInMove:(JMAMove *)move;

- (NSArray *)squaresInvolvedTakingBackMove:(JMAMove *)move;


@end
