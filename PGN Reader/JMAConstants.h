//
//  JMAConstants.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/20/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAConstants : NSObject


// Integers
extern NSInteger const NEGATIVE_FOURTY;
extern NSInteger const NEGATIVE_EIGHT;
extern NSUInteger const ZERO;
extern NSUInteger const ONE;
extern NSUInteger const TWO;
extern NSUInteger const THREE;
extern NSUInteger const FOUR;
extern NSUInteger const FIVE;
extern NSUInteger const SEVEN;
extern NSUInteger const EIGHT;
extern NSUInteger const NINE;
extern NSUInteger const FIFTEEN;
extern NSUInteger const EIGHTEEN;
extern NSUInteger const TWENTY;
extern NSUInteger const TWENTY_FIVE;
extern NSUInteger const FORTY;
extern NSUInteger const SIXTY_FOUR;
extern NSUInteger const EIGHTY;

// Core Data
// Attribute Names as saved in Core Data entities
// Game Attributes
extern NSString *const BLACK_CD;
extern NSString *const BLACK_ELO_CD;
extern NSString *const DATE_CD;
extern NSString *const ECO_CD;
extern NSString *const EVENT_CD;
extern NSString *const RESULT_CD;
extern NSString *const SITE_CD;
extern NSString *const WHITE_CD;
extern NSString *const WHITE_ELO_CD;
extern NSString *const MOVES_CD;
// Database
extern NSString *const NAME_CD;

//Entity Names
extern NSString *const DATABASE_CD_ENTITY;
extern NSString *const GAME_CD_ENTITY;

// Identifiers
extern NSString *const DATABASES_CELL_IDENTIFIER;
extern NSString *const DATABASE_CELL_IDENTIFIER;
extern NSString *const TO_DATABASE_SEGUE_IDENTIFIER;
extern NSString *const TO_GAME_SEGUE_IDENTIFIER;


extern NSString *const SPACE;
extern NSString *const NEW_LINE;
extern NSString *const EMPTY_STRING;
extern NSString *const PERIOD;

extern NSString *const FORWARD;
extern NSString *const BACKWARD;

@end
