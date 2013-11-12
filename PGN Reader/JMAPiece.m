//
//  JMAPiece.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/11/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAPiece.h"
#import "JMASquare.h"

@interface JMAPiece ()


@property (strong, nonatomic) NSDictionary *unicodeDictionary;

@end

@implementation JMAPiece

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithSquare:(JMASquare *)square forColor:(NSString *)color
{
    self = [super initWithFrame:square.frame];
    
    if (self) {
        _color = color;
    }
    
    return self;
    
    
}

/*
 This method returns the piece type for the coordinate parameter
*/
- (NSString *)typeForCoordinate:(NSString *)coordinate
{
    return @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
