//
//  JMADatabaseTableViewController.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/24/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMADatabaseTableViewController.h"
#import "JMAConstants.h"
#import "Database.h"
#import "Game.h"
#import "JMADatabaseCell.h"
#import "JMAGameViewController.h"

@interface JMADatabaseTableViewController ()

@property (strong, nonatomic) NSArray *games;
@end

@implementation JMADatabaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if (!_games) {
            _games = [[NSArray alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.database.name;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderingValue" ascending:YES];
    self.games = [[self.database.games allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return ONE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
      
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       JMADatabaseCell *cell = [tableView dequeueReusableCellWithIdentifier:DATABASE_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(JMADatabaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Game *game = self.games[indexPath.row];
    
    NSString *playersString = [NSString stringWithFormat:@"%@ - %@, %@", game.white, game.black, game.result];
    NSString *informationString = [NSString stringWithFormat:@"%@, %@.  Date: %@ ECO: %@", game.event, game.site, game.date, game.eco];

    cell.playersLabel.text = playersString;
    cell.indormationLabel.text = informationString;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Game *selectedGame = self.games[indexPath.row];
    
    JMAGameViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.game = selectedGame;
    
    
    
    
    
}


@end
