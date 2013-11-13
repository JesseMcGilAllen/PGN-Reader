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
@property (strong, nonatomic) NSDictionary *imageDictionary;
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
    CGFloat yOffset = square.frame.size.height / SEVEN;
    CGFloat xOffset = square.frame.size.width / EIGHT;
    
    CGFloat xOrigin = square.frame.origin.x + xOffset;
    CGFloat yOrigin = square.frame.origin.y - yOffset;
    
    CGRect pieceFrame = CGRectMake(xOrigin, yOrigin, square.frame.size.width, square.frame.size.height);
    
    self = [super initWithFrame:pieceFrame];
    
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
        
        _imageDictionary = @{WHITE_KING : @"white_king",
                             WHITE_QUEEN : @"white_queen",
                             WHITE_ROOK : @"white_rook",
                             WHITE_BISHOP : @"white_bishop",
                             WHITE_KNIGHT : @"white_knight",
                             WHITE_PAWN : @"white_pawn",
                             BLACK_KING : @"black_king",
                             BLACK_QUEEN : @"black_queen",
                             BLACK_ROOK : @"black_rook",
                             BLACK_BISHOP : @"black_bishop",
                             BLACK_KNIGHT : @"black_knight",
                             BLACK_PAWN : @"black_pawn"};
        
    }
    
    self.opaque = NO;
    
    //[square addSubview:self];
    
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

- (UIColor *)determineOutlineColor
{
    if ([self.color isEqualToString:WHITE]) {
        return [UIColor blackColor];
    } else {
        return [UIColor whiteColor];
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
    
    UIFont *font = [UIFont fontWithName:@"Tahoma" size:rectLength];
   
    //UIColor *pieceColor = [self determinePieceColor];
    //UIColor *outlineColor = [ self determineOutlineColor];
    
    UIColor *pieceColor = [UIColor blackColor];
    UIColor *backgroundColor = [UIColor clearColor];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : pieceColor,
                                  NSBackgroundColorAttributeName : backgroundColor};
    
    [piece drawInRect:rect withAttributes:attributes];
}


@end
