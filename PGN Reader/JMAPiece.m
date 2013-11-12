//
//  JMAPiece.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/11/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAPiece.h"
#import "JMASquare.h"
#import "JMAChessConstants.h"
#import "JMAConstants.h"

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

- (id)initWithSquare:(JMASquare *)square type:(NSString *)type forColor:(NSString *)color
{
    self = [super initWithFrame:square.frame];
    
    if (self) {
        _color = color;
        _type = type;
        _square = square;
        
        _unicodeDictionary = @{WHITE_KING: @"\u2654",
                               WHITE_QUEEN: @"\u2655",
                               WHITE_ROOK: @"\u2656",
                               WHITE_BISHOP: @"\u2657",
                               WHITE_KNIGHT: @"\u2658",
                               WHITE_PAWN: @"\u2659",
                               BLACK_KING: @"\u265A",
                               BLACK_QUEEN: @"\u265B",
                               BLACK_ROOK: @"\u265C",
                               BLACK_BISHOP: @"\u265D",
                               BLACK_KNIGHT: @"\u265E",
                               BLACK_PAWN: @"\u265F"
                               };
        
    }
    
    self.opaque = NO;
    
    [square addSubview:self];
    
    return self;
    
    
}

/*
 This method returns a UIColor object representing the piece's color
*/
- (UIColor *)determinePieceColor
{
    if ([self.color isEqualToString:WHITE]) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSString *pieceToDraw = [[NSString alloc] initWithFormat:@"%@%@%@", self.color, SPACE, self.type];
    
    NSString *piece = self.unicodeDictionary[pieceToDraw];
    
    CGFloat rectLength = rect.size.height;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:rectLength];
   
    UIColor *pieceColor = [self determinePieceColor];
    UIColor *backgroundColor = [UIColor clearColor];
    
    
    
    
    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : pieceColor,
                                  NSBackgroundColorAttributeName : backgroundColor};
    
    [piece drawInRect:rect withAttributes:attributes];
    
    
    
    
    
    
}


@end
