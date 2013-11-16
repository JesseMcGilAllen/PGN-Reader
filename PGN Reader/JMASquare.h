//
//  JMASquare.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMAPiece;

@interface JMASquare : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *coordinate;
@property (strong, nonatomic) JMAPiece *piece;

- (NSString *)file;
- (NSString *)rank;


@end
