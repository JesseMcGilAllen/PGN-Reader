//
//  JMAGameViewController.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 11/8/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAGameViewController.h"
#import "Game.h"
#import "JMABoardView.h"
#import "JMAConstants.h"

@interface JMAGameViewController ()
@property (weak, nonatomic) IBOutlet JMABoardView *boardView;
@property (weak, nonatomic) IBOutlet UITextView *movesListView;

@end

@implementation JMAGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *titleString = [[NSString alloc] initWithFormat:@"%@ - %@", self.game.white, self.game.black];
    
    self.title = titleString;
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self determineInterfaceOrientation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 This method determines the Interface Orientation of the Device and calls the 
 corresponding method to configure the view controller's elements
*/
- (void)determineInterfaceOrientation
{
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        NSLog(@"Landscape");
        [self configureViewForLandscapeOrientation];
    } else {
        NSLog(@"Portrait");
        [self configureViewForPortraitOrientation];
    }
    
    //[self.view setNeedsDisplay];

}


/*
 This method handles when the device rotates
 First resetBoard is called from the BoardView class to remove the squares
 Then the configure method is called for the orientation the app is rotating to
*/
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    //NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    
    [self.boardView resetBoard];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        [self configureViewForLandscapeOrientationForRotation];
        
    } else {
        
        [self configureViewForPortraitOrientationForRotation];
    }
    
     [self.boardView setNeedsDisplay];
    //[self.view setNeedsDisplay];
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Landscape Orientation
 and sets those elements
 */
- (void)configureViewForLandscapeOrientationForRotation
{
    CGFloat viewHeight = self.view.frame.size.width;
    
    NSLog(@"View Height: %f", viewHeight);
    CGFloat boardWidth = self.view.frame.size.height * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.height - boardWidth;
    
    //NSLog(@"Board Width: %f", boardWidth);
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, boardWidth, viewHeight);
    CGRect movesListRect = CGRectMake(boardWidth, ZERO, listWidth, viewHeight);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
    //NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Portrait Orientation
 and sets those elements
 */
- (void)configureViewForPortraitOrientationForRotation
{
    CGFloat viewWidth = self.view.frame.size.height;
    NSLog(@"View Width: %f", viewWidth);
    CGFloat boardLength = self.view.frame.size.width * (double)FOUR/FIVE;
    
    //NSLog(@"4/5: %f", (double)FOUR/FIVE);
    //NSLog(@"Board Length: %f", boardLength);
    CGFloat listLength = self.view.frame.size.width - boardLength;
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, viewWidth, boardLength);
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
    // NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Landscape Orientation
 and sets those elements
*/
- (void)configureViewForLandscapeOrientation
{
    CGFloat viewHeight = self.view.frame.size.height;
    
    NSLog(@"View Height: %f", viewHeight);
    CGFloat boardWidth = self.view.frame.size.width * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.width - boardWidth;
    
    //NSLog(@"Board Width: %f", boardWidth);
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, boardWidth, viewHeight);
    CGRect movesListRect = CGRectMake(boardWidth, ZERO, listWidth, viewHeight);
        
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;

    //NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Portrait Orientation
 and sets those elements
 */
- (void)configureViewForPortraitOrientation
{
    CGFloat viewWidth = self.view.frame.size.width;
    NSLog(@"View Width: %f", viewWidth);
    CGFloat boardLength = self.view.frame.size.height * (double)FOUR/FIVE;
    
    //NSLog(@"4/5: %f", (double)FOUR/FIVE);
    //NSLog(@"Board Length: %f", boardLength);
    CGFloat listLength = self.view.frame.size.height - boardLength;
    
    NSLog(@"List Length: %f", listLength);
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, viewWidth, boardLength);
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
    // NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    
}

- (void)removeFromSuperview:(UIView *)view
{
    [view removeFromSuperview];
}


@end
