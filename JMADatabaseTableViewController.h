//
//  JMADatabaseTableViewController.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/24/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Database;

@interface JMADatabaseTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Database *database;


@end
