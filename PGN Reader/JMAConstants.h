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
extern NSInteger const ZERO;
extern NSInteger const ONE;
extern NSInteger const TWO;
extern NSInteger const THREE;
extern NSInteger const FOUR;
extern NSInteger const FIVE;
extern NSInteger const SEVEN;
extern NSInteger const EIGHT;
extern NSInteger const TWENTY;
extern NSInteger const TWENTY_FIVE;
extern NSInteger const EIGHTY;

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

@end
