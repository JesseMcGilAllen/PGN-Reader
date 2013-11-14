//
//  JMAMovesListParser.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/14/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAMovesListParser : NSObject

- (id)initWithMoves:(NSString *)moves;

- (NSString *)movesForTextView;

- (NSArray *)movesForGame;

@end
