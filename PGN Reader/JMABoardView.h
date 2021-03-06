//
//  JMABoardView.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMABoardModel;
@class JMAMove;

@interface JMABoardView : UIView

@property (strong, nonatomic) JMABoardModel *model;

- (void)resetBoard;
- (void)drawBoard;

- (void)updateBoardWithMove:(JMAMove *)move squares:(NSArray *)squares;
- (void)updateBoardWithTakebackMove:(JMAMove *)move squares:(NSArray *)squares;
@end
