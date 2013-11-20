// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Game.m instead.

#import "_Game.h"

const struct GameAttributes GameAttributes = {
	.black = @"black",
	.blackElo = @"blackElo",
	.completed = @"completed",
	.date = @"date",
	.eco = @"eco",
	.event = @"event",
	.gameString = @"gameString",
	.moves = @"moves",
	.orderingValue = @"orderingValue",
	.result = @"result",
	.site = @"site",
	.white = @"white",
	.whiteElo = @"whiteElo",
};

const struct GameRelationships GameRelationships = {
	.database = @"database",
};

const struct GameFetchedProperties GameFetchedProperties = {
};

@implementation GameID
@end

@implementation _Game

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Game";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Game" inManagedObjectContext:moc_];
}

- (GameID*)objectID {
	return (GameID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"blackEloValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"blackElo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"completedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"completed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"orderingValueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"orderingValue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"whiteEloValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"whiteElo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic black;






@dynamic blackElo;



- (int32_t)blackEloValue {
	NSNumber *result = [self blackElo];
	return [result intValue];
}

- (void)setBlackEloValue:(int32_t)value_ {
	[self setBlackElo:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveBlackEloValue {
	NSNumber *result = [self primitiveBlackElo];
	return [result intValue];
}

- (void)setPrimitiveBlackEloValue:(int32_t)value_ {
	[self setPrimitiveBlackElo:[NSNumber numberWithInt:value_]];
}





@dynamic completed;



- (BOOL)completedValue {
	NSNumber *result = [self completed];
	return [result boolValue];
}

- (void)setCompletedValue:(BOOL)value_ {
	[self setCompleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompletedValue {
	NSNumber *result = [self primitiveCompleted];
	return [result boolValue];
}

- (void)setPrimitiveCompletedValue:(BOOL)value_ {
	[self setPrimitiveCompleted:[NSNumber numberWithBool:value_]];
}





@dynamic date;






@dynamic eco;






@dynamic event;






@dynamic gameString;






@dynamic moves;






@dynamic orderingValue;



- (int32_t)orderingValueValue {
	NSNumber *result = [self orderingValue];
	return [result intValue];
}

- (void)setOrderingValueValue:(int32_t)value_ {
	[self setOrderingValue:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveOrderingValueValue {
	NSNumber *result = [self primitiveOrderingValue];
	return [result intValue];
}

- (void)setPrimitiveOrderingValueValue:(int32_t)value_ {
	[self setPrimitiveOrderingValue:[NSNumber numberWithInt:value_]];
}





@dynamic result;






@dynamic site;






@dynamic white;






@dynamic whiteElo;



- (int32_t)whiteEloValue {
	NSNumber *result = [self whiteElo];
	return [result intValue];
}

- (void)setWhiteEloValue:(int32_t)value_ {
	[self setWhiteElo:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveWhiteEloValue {
	NSNumber *result = [self primitiveWhiteElo];
	return [result intValue];
}

- (void)setPrimitiveWhiteEloValue:(int32_t)value_ {
	[self setPrimitiveWhiteElo:[NSNumber numberWithInt:value_]];
}





@dynamic database;

	






@end
