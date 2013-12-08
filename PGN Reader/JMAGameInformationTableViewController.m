//
//  JMAGameInformationTableViewController.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 12/7/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAGameInformationTableViewController.h"
#import "JMAGameInformationCell.h"
#import "JMAConstants.h"

@interface JMAGameInformationTableViewController ()

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *sectionTitles;

@end

@implementation JMAGameInformationTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*
     
     black;
     blackElo;
     date;
     eco;
     event;
     result;
     site;
     white;
     whiteElo;
     
     section 1: White Player
        white
        Elo
     
     section 2: Black Player
        black
        Elo
     
     section 3: Game
        result
        eco
     
     section 4: Event
        event
        site
     */
    
    [self loadSections];
    [self loadSectionTitles];
    
    
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
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSArray *attributes = self.sections[section];
    
    return [attributes count];
}

/*
 This method sets the header title for incoming section
*/
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"HeaderView"];
    
    header.textLabel.text = self.sectionTitles[section];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JMAGameInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:GAME_INFORMATION_CELL_IDENTIFIER forIndexPath:indexPath];
    
    // Configure the cell...
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

/*
 This method configure the cell for the indexpath variable
*/
- (void)configureCell:(JMAGameInformationCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArray = self.sections[indexPath.section];
    NSArray *rowArray = sectionArray[indexPath.row];
    
    cell.rowLabel = rowArray[ZERO];
    cell.rowValue = rowArray[ONE];
    
    
}

- (void)loadSectionTitles
{
    self.sectionTitles = @[@"White Player", @"Black Player",
                           @"Game Information", @"Event Information"];
}

# pragma mark - Load Sections Array

- (void)loadSections
{
    NSArray *sectionZero = [self sectionZero];
    NSArray *sectionOne = [self sectionOne];
    NSArray *sectionTwo = [self sectionTwo];
    NSArray *sectionThree = [self sectionThree];
    
    self.sections = @[sectionZero, sectionOne, sectionTwo, sectionThree];
}

- (NSArray *)sectionZero
{
    NSArray *whitePlayer = @[@"White", self.game.white];
    NSArray *whiteElo = @[@"ELO", self.game.whiteElo];
    
    return @[whitePlayer, whiteElo];
}

- (NSArray *)sectionOne
{
    NSArray *blackPlayer = @[@"Black", self.game.black];
    NSArray *blackElo = @[@"ELO", self.game.blackElo];
    
    return @[blackPlayer, blackElo];
}

- (NSArray *)sectionTwo
{
    NSArray *result = @[@"Black", self.game.result];
    NSArray *eco = @[@"ECO", self.game.eco];
    
    return @[result, eco];
}

- (NSArray *)sectionThree
{
    NSArray *event = @[@"Event", self.game.event];
    NSArray *site = @[@"Site", self.game.site];
    NSArray *date = @[@"Date", self.game.date];
    
    return @[event, site, date];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
