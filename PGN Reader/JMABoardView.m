//
//  JMABoardView.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMABoardView.h"
#import "JMASquare.h"
#import "JMAConstants.h"

@implementation JMABoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSArray *ranks = @[@8, @7, @6, @5, @4, @3, @2, @1];
    NSArray *files = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    
    double squareWidth = rect.size.width / EIGHT;
    double squareHeight = rect.size.height / EIGHT;
    
    for (double squareOriginX = 0.0; squareOriginX < rect.size.width; squareOriginX += squareWidth) {
        int widthIndex = ZERO;
        
        for (double squareOriginY = 0.0; squareOriginY < rect.size.height; squareOriginY += squareHeight) {
            int heightIndex = ZERO;
            
            JMASquare *square = [[JMASquare alloc] initWithFrame:CGRectMake(squareOriginX, squareOriginY, squareWidth, squareHeight)];
            NSString *coordinate = [[NSString alloc] initWithFormat:@"%@%@", files[heightIndex], ranks[widthIndex]];
            square.coordinate = coordinate;
            
            
            
        }
    }
    

}


@end
