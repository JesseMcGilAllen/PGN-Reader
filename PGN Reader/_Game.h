// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Game.h instead.

#import <CoreData/CoreData.h>


extern const struct GameAttributes {
	__unsafe_unretained NSString *black;
	__unsafe_unretained NSString *blackElo;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *eco;
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *moves;
	__unsafe_unretained NSString *orderingValue;
	__unsafe_unretained NSString *result;
	__unsafe_unretained NSString *site;
	__unsafe_unretained NSString *white;
	__unsafe_unretained NSString *whiteElo;
} GameAttributes;

extern const struct GameRelationships {
	__unsafe_unretained NSString *database;
} GameRelationships;

extern const struct GameFetchedProperties {
} GameFetchedProperties;

@class Database;













@interface GameID : NSManagedObjectID {}
@end

@interface _Game : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameID*)objectID;




@property (nonatomic, strong) NSString* black;


//- (BOOL)validateBlack:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* blackElo;


@property int32_t blackEloValue;
- (int32_t)blackEloValue;
- (void)setBlackEloValue:(int32_t)value_;

//- (BOOL)validateBlackElo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* date;


//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* eco;


//- (BOOL)validateEco:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* event;


//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* moves;


//- (BOOL)validateMoves:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* orderingValue;


@property int32_t orderingValueValue;
- (int32_t)orderingValueValue;
- (void)setOrderingValueValue:(int32_t)value_;

//- (BOOL)validateOrderingValue:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* result;


//- (BOOL)validateResult:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* site;


//- (BOOL)validateSite:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* white;


//- (BOOL)validateWhite:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* whiteElo;


@property int32_t whiteEloValue;
- (int32_t)whiteEloValue;
- (void)setWhiteEloValue:(int32_t)value_;

//- (BOOL)validateWhiteElo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Database* database;

//- (BOOL)validateDatabase:(id*)value_ error:(NSError**)error_;





@end

@interface _Game (CoreDataGeneratedAccessors)

@end

@interface _Game (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBlack;
- (void)setPrimitiveBlack:(NSString*)value;




- (NSNumber*)primitiveBlackElo;
- (void)setPrimitiveBlackElo:(NSNumber*)value;

- (int32_t)primitiveBlackEloValue;
- (void)setPrimitiveBlackEloValue:(int32_t)value_;




- (NSString*)primitiveDate;
- (void)setPrimitiveDate:(NSString*)value;




- (NSString*)primitiveEco;
- (void)setPrimitiveEco:(NSString*)value;




- (NSString*)primitiveEvent;
- (void)setPrimitiveEvent:(NSString*)value;




- (NSString*)primitiveMoves;
- (void)setPrimitiveMoves:(NSString*)value;




- (NSNumber*)primitiveOrderingValue;
- (void)setPrimitiveOrderingValue:(NSNumber*)value;

- (int32_t)primitiveOrderingValueValue;
- (void)setPrimitiveOrderingValueValue:(int32_t)value_;




- (NSString*)primitiveResult;
- (void)setPrimitiveResult:(NSString*)value;




- (NSString*)primitiveSite;
- (void)setPrimitiveSite:(NSString*)value;




- (NSString*)primitiveWhite;
- (void)setPrimitiveWhite:(NSString*)value;




- (NSNumber*)primitiveWhiteElo;
- (void)setPrimitiveWhiteElo:(NSNumber*)value;

- (int32_t)primitiveWhiteEloValue;
- (void)setPrimitiveWhiteEloValue:(int32_t)value_;





- (Database*)primitiveDatabase;
- (void)setPrimitiveDatabase:(Database*)value;


@end
