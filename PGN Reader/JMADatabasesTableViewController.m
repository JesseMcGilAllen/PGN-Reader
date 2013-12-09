//
//  JMADatabasesTableViewController.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/18/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMADatabasesTableViewController.h"
#import "JMADatabasesCell.h"
#import "JMADatabaseTableViewController.h"
#import "JMAConstants.h"
#import "Database.h"

@interface JMADatabasesTableViewController ()

@property (strong, nonatomic) NSArray *databases;
@end

@implementation JMADatabasesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
     self.title = @"Databases";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.databases = self.fetchedResultsController.fetchedObjects;
     self.navigationController.toolbarHidden = YES;
//    
//    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[ONE];
//    
//    if ([self.tableView numberOfRowsInSection:ONE] == [sectionInfo numberOfObjects]) {
//        
//        [self.tableView reloadData];
//    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.fetchedResultsController.sections count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

  
    
    // Return the number of rows in the section.
    return [self.databases count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMADatabasesCell *cell = (JMADatabasesCell *)[tableView dequeueReusableCellWithIdentifier:DATABASES_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(JMADatabasesCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    
    cell.databasesNameLabel.text = [self databaseNameAtIndexPath:indexPath];
    
    cell.gameCountLabel.text =
            [self databaseGameCountStringAtIndexPath:indexPath];
}

/*
 This method returns the database name from the Core Data Store 
 for the indexPath parameter
*/
- (NSString *)databaseNameAtIndexPath:(NSIndexPath *)indexPath
{
    Database *database = [self databaseAtIndexPath:indexPath];
   
    NSString *databaseName = database.name;
    
    return databaseName;
}


/*
 This method returns a string that represents the number of games in the 
 database located at the indexPath.
*/
- (NSString *)databaseGameCountStringAtIndexPath:(NSIndexPath *)indexPath
{
    Database *database = [self databaseAtIndexPath:indexPath];
    
    NSString *gameCountString = [[NSString alloc] initWithFormat:@"%lu Games", (unsigned long)[database.games count]];
    
    return gameCountString;
}

- (Database *)databaseAtIndexPath:(NSIndexPath *)indexPath
{
    Database *database = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return database;
}

# pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:DATABASE_CD_ENTITY inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:TWENTY];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:NAME_CD ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        [self deleteDatabaseWithIndexPath:indexPath];
        [self resetDatabasesArray];
        
        
        // Delete row from table view
        [self.tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        [self.tableView reloadData];
        
       
    }   
    
}

/*
 This method gets the database corresponding to the indexpath and deletes it
 from the Managed Object Context
*/
- (void)deleteDatabaseWithIndexPath:(NSIndexPath *)indexPath
{
    Database *databaseToDelete = [self databaseAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:databaseToDelete];
    [self save];

}


/*
 This method resets the FetchedResultsController and saves the new array
 of fetched objects into the databases property
*/
- (void)resetDatabasesArray
{
    [self resetFetchedResultsController];
    self.databases = self.fetchedResultsController.fetchedObjects;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_DATABASE_SEGUE_IDENTIFIER]) {
        
        [self prepareForToDatabaseSegue:segue sender:sender];
    }
}

/*
 This method handles the toDatabase Segue
*/
- (void)prepareForToDatabaseSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    JMADatabaseTableViewController *databaseTableViewController = segue.destinationViewController;
    databaseTableViewController.managedObjectContext = self.managedObjectContext;
    databaseTableViewController.database = [self databaseAtIndexPath:indexPath];
    
}

/*
 This method sets the FetchedResultsController to nil so it can be reloaded 
 with updated data from the managedObjectContext
*/
- (void)resetFetchedResultsController
{
    self.fetchedResultsController = nil;
}


/*
 This method reloads the TableView and calls the resetFetchedResultsController
*/
- (void)reload
{
    [self resetDatabasesArray];
    [self.tableView reloadData];
 
}

/*
 This method saves the managedObjectContext
 */
- (void)save
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"FAIL!!!: %@", [error localizedDescription]);
    }
}

@end
