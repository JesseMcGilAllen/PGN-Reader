//
//  JMABoardModel.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/21/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMASquare;

@interface JMABoardModel : NSObject

- (NSDictionary *)squares;

- (JMASquare *)squareforCoordinate:(NSString *)coordinate;


@end
