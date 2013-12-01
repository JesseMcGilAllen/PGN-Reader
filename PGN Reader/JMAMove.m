//
//  JMAMove.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/25/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAMove.h"
#import "JMAChessConstants.h"
#import "JMAConstants.h"
#import "JMASquare.h"

@interface JMAMove ()

@property (strong, nonatomic) NSString *destinationSquareCoordinate;
@property (strong, nonatomic) NSString *originSquareCoordinate;

@property (strong, nonatomic) NSString *pieceType;

@property (assign, nonatomic) BOOL isCapture;
@property (assign, nonatomic) BOOL isCastling;
@property (assign, nonatomic) BOOL isCheck;
@property (assign, nonatomic) BOOL isPromotion;

@end

@implementation JMAMove

- (id)init
{
    return [self initWithMoveString:nil];
}


- (id)initWithMoveString:(NSString *)moveString
{
    self = [super init];
    
    if (self) {
        _moveString = moveString;
    }
    
    [self determinePieceType];
    [self extractDestinationSquare];
    [self determineWhetherMoveContainsACheck];
    [self determineWhetherMoveContainsACapture];
    [self configureIsCastling];
    
    
    
    return self;
}


- (NSString *)pieceType
{
    return self.pieceType;
}

- (NSString *)destinationSquareCoordinate
{
    return self.destinationSquareCoordinate;
}

- (NSString *)originSquareCoordinate
{
    return self.originSquareCoordinate;
}

- (BOOL)isCapture
{
    return self.isCapture;
}

- (BOOL)isCastling
{
    return self.isCastling;
}

- (BOOL)isCheck
{
    return self.isCheck;
}



/*
 This method compares the first Character of the moves String to a dictionary
 containing the non-pawn Characters that represent piece or castling moves
    if pieceTypes[firstCharacter] != nil 
        self.pieceType = pieceTypes[firstCharacter]
    else
        self.pieceType = Pawn
 
*/
- (void)determinePieceType
{
    NSDictionary *pieceTypes = @{@"K" : KING,
                                 @"Q" : QUEEN,
                                 @"R" : ROOK,
                                 @"B" : BISHOP,
                                 @"N" : KNIGHT,
                                 @"O" : CASTLE};
    
    NSString *firstCharacter = [self.moveString substringToIndex:ONE];
    self.pieceType = pieceTypes[firstCharacter];
    
    if (!self.pieceType) {
        self.pieceType = PAWN;
    }
    
}

/*
 This method uses a regular expression to find the range of the coordinate in 
 the string.  Then the range of the first match is used to set the 
 destinationSquareCoordinate Property
*/
- (void)extractDestinationSquare
{
    NSString *pattern = @"[a-h][1-8]";
    NSError *error = nil;
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                                  options:ZERO
                                                                                    error:&error];
    
    NSRange rangeOfFirstMatch = [regularExpression rangeOfFirstMatchInString:self.moveString
                                                                     options:ZERO
                                                                       range:NSMakeRange(ZERO, [self.moveString length])];
    
    self.destinationSquareCoordinate = [self.moveString substringWithRange:rangeOfFirstMatch];
    
}


/*
 This method determines whether the moveString contains a check
*/
- (void)determineWhetherMoveContainsACheck
{
    if ([self.moveString hasSuffix:@"+"]) {
        self.isCheck = YES;
    } else {
        self.isCheck = NO;
    }
}

/*
 This method looks in the moveString for an occurrence of an 'x'
 representing a piece capture if one exists the isCapture property is set to YES
 else it is set to NO
*/
- (void)determineWhetherMoveContainsACapture
{
    NSRange rangeOfX = [self.moveString rangeOfString:@"x"];
    
    if (rangeOfX.location == NSNotFound) {
        self.isCapture = NO;
    } else {
        self.isCapture = YES;
    }
}

/*
 This method looks in the moveString for an occurrence of an '=' representing a
 promotion has occurred.  If the '=' has been found the isPromotion property is
 set to YES otherwise it is set to NO.
*/
- (void)determineWhetherMoveContainsAPromotion
{
    NSRange rangeOfPromotion = [self.moveString rangeOfString:@"="];
    
    if (rangeOfPromotion.location == NSNotFound) {
        self.isPromotion = NO;
    } else {
        self.isPromotion = YES;
    }
}

- (void)configureIsCastling
{
    if ([self.pieceType isEqualToString:CASTLE]) {
        self.isCastling = YES;
    } else {
        self.isCastling = NO;
    }
}


- (BOOL)isPromotion
{
    return self.isPromotion;
}

/*
 This method sets the originSquareCoordinate using the coordinate property of 
 the incoming square parameter
*/
- (void)originSquareCoordinateFromSquare:(JMASquare *)square
{
    if (!self.isCastling) {
        self.originSquareCoordinate = square.coordinate;
    }
}
@end
