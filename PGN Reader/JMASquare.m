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
@property (assign, nonatomic) int rank;

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
    self.rank = [[coordinate substringFromIndex:ONE] intValue];
    
    _coordinate = coordinate;
    
    
    
}

- (int)rank
{
    return self.rank;
}

- (NSString *)file
{
    return self.file;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    UIColor *textColor;
    
    if ([self.color isEqualToString:WHITE]) {
        textColor = [UIColor blueColor];
    } else {
        textColor = [UIColor whiteColor];
    }
    
    [self.coordinate drawInRect:CGRectMake(ZERO, ZERO, rect.size.width, rect.size.height)
                 withAttributes:@{ NSForegroundColorAttributeName : textColor }];
    
}


@end
