//
//  JMAPiece.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/11/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMASquare;

@interface JMAPiece : UIView

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) JMASquare *square;
@property (strong, nonatomic) NSString *color;

- (id)initWithSquare:(JMASquare *)square type:(NSString *)type forColor:(NSString *)color;

@end
