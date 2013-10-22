// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Database.m instead.

#import "_Database.h"

const struct DatabaseAttributes DatabaseAttributes = {
	.name = @"name",
};

const struct DatabaseRelationships DatabaseRelationships = {
	.games = @"games",
};

const struct DatabaseFetchedProperties DatabaseFetchedProperties = {
};

@implementation DatabaseID
@end

@implementation _Database

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Database" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Database";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Database" inManagedObjectContext:moc_];
}

- (DatabaseID*)objectID {
	return (DatabaseID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic games;

	
- (NSMutableSet*)gamesSet {
	[self willAccessValueForKey:@"games"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"games"];
  
	[self didAccessValueForKey:@"games"];
	return result;
}
	






@end
