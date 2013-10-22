// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Database.h instead.

#import <CoreData/CoreData.h>


extern const struct DatabaseAttributes {
	__unsafe_unretained NSString *name;
} DatabaseAttributes;

extern const struct DatabaseRelationships {
	__unsafe_unretained NSString *games;
} DatabaseRelationships;

extern const struct DatabaseFetchedProperties {
} DatabaseFetchedProperties;

@class Game;



@interface DatabaseID : NSManagedObjectID {}
@end

@interface _Database : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DatabaseID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* games;

- (NSMutableSet*)gamesSet;





@end

@interface _Database (CoreDataGeneratedAccessors)

- (void)addGames:(NSSet*)value_;
- (void)removeGames:(NSSet*)value_;
- (void)addGamesObject:(Game*)value_;
- (void)removeGamesObject:(Game*)value_;

@end

@interface _Database (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveGames;
- (void)setPrimitiveGames:(NSMutableSet*)value;


@end
