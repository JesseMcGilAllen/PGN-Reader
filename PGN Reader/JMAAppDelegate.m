//
//  JMAAppDelegate.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/17/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAAppDelegate.h"
#import "JMAConstants.h"
#import "JMAParser.h"
#import "JMADatabasesTableViewController.h"
#import "SSZipArchive.h"

@interface JMAAppDelegate ()

@property (strong, nonatomic) JMADatabasesTableViewController *databasesTableViewController;
@end

@implementation JMAAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
     NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *documentDirectory = paths[ZERO];
    
    NSArray *documentContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:&error];
    
    NSLog(@"%@", documentContents);
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    self.databasesTableViewController = (JMADatabasesTableViewController *)navigationController.topViewController;

    self.databasesTableViewController.managedObjectContext = self.managedObjectContext;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PGN_Reader" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PGN_Reader.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// Returns the
- (NSString *)applicationPrivateDocumentsDirectory {
    static NSString *path;
    if (!path) {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        path = [libraryPath stringByAppendingPathComponent:@"Private Documents"];
        BOOL isDirectory;
        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
            NSError *error = nil;
            if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"Can't create directory %@ [%@]", path, error);
                abort(); // replace with proper error handling
            }
        }
        else if (!isDirectory) {
            NSLog(@"Path %@ exists but is no directory", path);
            abort(); // replace with error handling
        }
    }
    return path;
}

/* 
 Handles pgn files as they enter the app
 An operation queue is created to move the file processing to a secondary thread
 If the incoming file is a zip file the pathForZippedFileUrlPgnFile method that 
 returns the path String to the unzipped file.
 The parserQueue add a operation that allocates space the parser object.
 The parseFileWithUrl method from the parser class is called to process the file
 located at the url.  The persistentStoreCoordinator is sent to the parser 
 instance.  Once the parseFileWithUrl method is done, the main thread is told to
 reload the databasesTableViewController if present.
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSURL *pgnURL;
    NSURL *oldURL;
    NSOperationQueue *parserQueue = [[NSOperationQueue alloc] init];
    
    if ([url.pathExtension isEqualToString:@"zip"]) {
        
        NSString *pgnFilePath = [self pathForZippedFileUrlPgnFile:url];
        
        pgnURL = [NSURL fileURLWithPath:pgnFilePath];
        oldURL = url;
        url = pgnURL;
        
        NSLog(@"Start Time: %@", [NSDate date]);
        
    }
    
    [parserQueue addOperationWithBlock:^{
        JMAParser *parser = [[JMAParser alloc] init];
      
        
        BOOL finished = [parser parseFileWithUrl:url
                  withPersistentStoreCoordinator:self.persistentStoreCoordinator];
        
        if (finished) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"in Completion Block");
                NSError *error = nil;
                
                if (self.databasesTableViewController.view.window) {
                    [self.databasesTableViewController reload];
                }
                
                if (pgnURL) {
                    [[NSFileManager defaultManager] removeItemAtPath:oldURL.path error:&error];
                } else {
                    [[NSFileManager defaultManager] removeItemAtPath:url.path error:&error];
                }
                
                
                NSLog(@"End Time: %@", [NSDate date]);
            }];
        }
    }];
    
    
    
    return YES;
}

/*
 This method unzips the contents of an compressed file and returns the file path
 of the unzipped file.
*/
- (NSString *)pathForZippedFileUrlPgnFile:(NSURL *)url
{
    
    NSError *error = nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = pathArray[ZERO];
    
    NSString *destinationPath = [[NSString alloc] initWithFormat:@"%@/%@", documentDirectory, url.lastPathComponent];
    
    [SSZipArchive unzipFileAtPath:url.path toDestination:destinationPath];
    
    NSArray *zippedContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destinationPath error:&error];
    
    NSString *pgnFilePath = [[NSString alloc] initWithFormat:@"%@/%@", destinationPath, zippedContents[ZERO]];
    
    return pgnFilePath;
}

@end
