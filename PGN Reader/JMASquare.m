//
//  JMASquare.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMASquare.h"
#import "JMAConstants.h"
#import "JMAChessConstants.h"

@interface JMASquare ()

@property (strong, nonatomic) NSString *file;
@property (strong, nonatomic) NSString *rank;

@end

@implementation JMASquare

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCoordinate:(NSString *)coordinate
{
    self.file = [coordinate substringToIndex:ONE];
    self.rank = [coordinate substringFromIndex:ONE];
    
    
    _coordinate = coordinate;
    
}

- (void)setColor:(NSString *)color
{
    if ([color isEqualToString:LIGHT]) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor blueColor];
    }
    
    _color = color;
}

- (NSString *)rank
{
    return _rank;
}

- (NSString *)file
{
    return _file;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    UIColor *textColor;
    
    if ([self.color isEqualToString:LIGHT]) {
        textColor = [UIColor blueColor];
    } else {
        textColor = [UIColor whiteColor];
    }
    
    [self.coordinate drawInRect:CGRectMake(ZERO, ZERO, rect.size.width, rect.size.height)
                 withAttributes:@{ NSForegroundColorAttributeName : textColor }];
    
}


@end
