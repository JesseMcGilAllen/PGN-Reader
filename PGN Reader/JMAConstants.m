//
//  JMAConstants.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/20/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAConstants.h"

@implementation JMAConstants

// Integers
NSInteger const NEGATIVE_FOURTY = -40;
NSInteger const NEGATIVE_EIGHT = -8;
NSUInteger const ZERO = 0;
NSUInteger const ONE = 1;
NSUInteger const TWO = 2;
NSUInteger const THREE = 3;
NSUInteger const FOUR = 4;
NSUInteger const FIVE = 5;
NSUInteger const SEVEN = 7;
NSUInteger const EIGHT = 8;
NSUInteger const NINE = 9;
NSUInteger const FIFTEEN = 15;
NSUInteger const EIGHTEEN = 18;
NSUInteger const TWENTY = 20;
NSUInteger const TWENTY_FIVE = 25;
NSUInteger const FORTY = 40;
NSUInteger const SIXTY_FOUR = 64;
NSUInteger const EIGHTY = 80;

// Core Data
// Attribute names
NSString *const BLACK_CD = @"black";
NSString *const BLACK_ELO_CD = @"blackElo";
NSString *const DATE_CD = @"date";
NSString *const ECO_CD = @"eco";
NSString *const EVENT_CD = @"event";
NSString *const RESULT_CD = @"result";
NSString *const SITE_CD = @"site";
NSString *const WHITE_CD = @"white";
NSString *const WHITE_ELO_CD = @"whiteElo";
NSString *const MOVES_CD = @"moves";
NSString *const NAME_CD = @"name";

// Entity Names
NSString *const DATABASE_CD_ENTITY = @"Database";
NSString *const GAME_CD_ENTITY = @"Game";

// Identifiers
NSString *const DATABASES_CELL_IDENTIFIER = @"databasesCell";
NSString *const DATABASE_CELL_IDENTIFIER = @"databaseCell";
NSString *const TO_DATABASE_SEGUE_IDENTIFIER = @"toDatabase";
NSString *const TO_GAME_SEGUE_IDENTIFIER = @"toGame";
NSString *const TO_INFORMATION_SEGUE_IDENTIFIER = @"toInformation";
NSString *const GAME_INFORMATION_CELL_IDENTIFIER = @"gameInformationCell";

NSString *const SPACE = @" ";
NSString *const NEW_LINE = @"\n";
NSString *const EMPTY_STRING = @"";
NSString *const PERIOD = @".";

NSString *const FORWARD = @"Forward";
NSString *const BACKWARD = @"Backward";

@end
