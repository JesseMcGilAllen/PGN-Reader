//
//  JMABoardView.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMABoardModel;

@interface JMABoardView : UIView

@property (strong, nonatomic) JMABoardModel *model;

- (void)resetBoard;

@end
