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
    
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    
    
    
    return self;
}

- (void)drawBoard
{
    NSArray *ranks = @[@8, @7, @6, @5, @4, @3, @2, @1];
    NSArray *files = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    CGRect rect = self.frame;
    NSString *color = WHITE;
    
    double squareWidth = rect.size.width / EIGHT;
    double squareHeight = rect.size.height / EIGHT;
    int widthIndex = ZERO;
    int heightIndex = ZERO;
    
    for (double squareOriginX = 0.0; squareOriginX < rect.size.width; squareOriginX += squareWidth) {
        JMASquare *square;
        
        for (double squareOriginY = 0.0; squareOriginY < rect.size.height; squareOriginY += squareHeight) {
            
            
            square = [[JMASquare alloc] initWithFrame:CGRectMake(squareOriginX, squareOriginY, squareWidth, squareHeight)];
            NSString *coordinate = [[NSString alloc] initWithFormat:@"%@%@", files[widthIndex], ranks[heightIndex]];
            square.coordinate = coordinate;
            
            square.color = color;
            
            
            if ([color isEqualToString:WHITE]) {
                square.backgroundColor = [UIColor whiteColor];
                color = BLACK;
            } else {
                square.backgroundColor = [UIColor blueColor];
                color = WHITE;
            }
            
            
            [self addSubview:square];
            NSLog(@"Square color: %@, Square coordinate: %@", square.color, square.coordinate);
            NSLog(@"Origin Y: %f", squareOriginY);
            NSLog(@"Origin X: %f", squareOriginX);
           
            if (heightIndex == SEVEN) {
                heightIndex = ZERO;
            } else {
                heightIndex++;
            }
            
        }
        
        if (widthIndex == SEVEN) {
            widthIndex = ZERO;
        } else {
            widthIndex++;
        }
       
        if ([color isEqualToString:WHITE]) {
            square.backgroundColor = [UIColor whiteColor];
            color = BLACK;
        } else {
            square.backgroundColor = [UIColor blueColor];
            color = WHITE;
        }

        
    }
    
    

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    [self drawBoard];

}


@end
