//
//  JMAAppDelegate.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/17/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
