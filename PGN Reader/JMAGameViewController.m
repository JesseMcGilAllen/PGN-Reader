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
#import "JMAMovesListParser.h"

@interface JMAGameViewController ()
@property (weak, nonatomic) IBOutlet JMABoardView *boardView;
@property (weak, nonatomic) IBOutlet UITextView *movesListView;
@property (strong, nonatomic) JMAMovesListParser *movesListParser;

@property (assign, nonatomic) UIEdgeInsets portraitInsets;
@property (assign, nonatomic) UIEdgeInsets landscapeInsets;

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
    
    self.movesListView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleRightMargin;
    
    self.navigationController.toolbarHidden = NO;
    
    [self configureMovesList];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self configureInsets];
    
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
        
        [self configureViewForLandscapeOrientation];
    } else {
        
        [self configureViewForPortraitOrientation];
    }
}

/*
 This method handles when the device rotates
 First resetBoard is called from the BoardView class to remove the squares
 Then the configure method is called for the orientation the app is rotating to
*/
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    [self.boardView resetBoard];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            
            [self configureViewForLandscapeOrientation];
            
        } else {
            [self configureViewForLandscapeOrientationForRotation];
        }
        
        
    } else {
        
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait||
            self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            
            [self configureViewForPortraitOrientation];
            
        } else {
            [self configureViewForPortraitOrientationForRotation];
        }

        
        
    }
    
    [self.boardView setNeedsDisplay];
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Landscape Orientation
 and sets those elements
*/
- (void)configureViewForLandscapeOrientationForRotation
{
    self.movesListView.textContainerInset = self.landscapeInsets;
    
    CGFloat navigationControllerHeight = [self navigationControllerHeight];
    
    CGFloat viewHeight = self.view.frame.size.width;
    
    CGFloat boardWidth = self.view.frame.size.height * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.height - boardWidth;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, boardWidth, viewHeight - navigationControllerHeight);
    CGRect movesListRect = CGRectMake(boardWidth, navigationControllerHeight, listWidth, viewHeight);
    
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Portrait Orientation
 and sets those elements
*/
- (void)configureViewForPortraitOrientationForRotation
{
    
    self.movesListView.textContainerInset = self.portraitInsets;
    [self.movesListView setNeedsDisplay];
    
    CGFloat navigationControllerHeight = [self navigationControllerHeight];
    
    CGFloat viewWidth = self.view.frame.size.height;
    
    CGFloat boardLength = self.view.frame.size.width * (double)FOUR/FIVE;
    
    CGFloat listLength = self.view.frame.size.width - boardLength;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, viewWidth, boardLength);
    
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    self.boardView.frame = boardViewRect;
    
    self.movesListView.frame = movesListRect;

}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Landscape Orientation
 and sets those elements
*/
- (void)configureViewForLandscapeOrientation
{
    self.movesListView.textContainerInset = self.landscapeInsets;
    
    CGFloat navigationControllerHeight = [self navigationControllerHeight];
    
    CGFloat viewHeight = self.view.frame.size.height;
    
    CGFloat boardWidth = self.view.frame.size.width * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.width - boardWidth;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, boardWidth, viewHeight - navigationControllerHeight);
    CGRect movesListRect = CGRectMake(boardWidth, navigationControllerHeight, listWidth, viewHeight);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Portrait Orientation
 and sets those elements
*/
- (void)configureViewForPortraitOrientation
{
    self.movesListView.textContainerInset = self.portraitInsets;
    
    CGFloat navigationControllerHeight = [self navigationControllerHeight];
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    CGFloat availableLength = self.view.frame.size.height - navigationControllerHeight;

    CGFloat boardLength = availableLength * (double)FOUR/FIVE;
    
    CGFloat listLength = self.view.frame.size.height - boardLength;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, viewWidth, boardLength);
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
   
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
}

/*
 This method returns the navigation controller height
*/
- (CGFloat)navigationControllerHeight
{
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat navBarYLocation = self.navigationController.navigationBar.frame.origin.y;
    CGFloat navigationControllerHeight = navBarHeight + navBarYLocation;
    
    return navigationControllerHeight;
    
}

/*
 This method sets the inset properties to set the textView contentInset 
 properties.
*/
- (void)configureInsets
{
    UIEdgeInsets defaultInsets = self.movesListView.textContainerInset;
    
    CGFloat topPortraitInset = defaultInsets.top * EIGHT;
    
    self.landscapeInsets = defaultInsets;
    self.portraitInsets = UIEdgeInsetsMake(topPortraitInset, defaultInsets.left, defaultInsets.bottom, defaultInsets.right);

}


/*
 This method configures the movesListView text view.  
 The background color is set to white.  An operation queue is created to create
 an JMAMovesListParser object to process the moves property of the game object.
 When the JMAMovesListParser is done the movesListTextView is updated.
*/
- (void)configureMovesList
{
    self.movesListView.backgroundColor = [UIColor whiteColor];
    
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    
    [aQueue addOperationWithBlock:^{
        self.movesListParser = [[JMAMovesListParser alloc] initWithMoves:self.game.moves];
        
        if (self.movesListParser.finished) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.movesListView.text = [self.movesListParser movesForTextView];
            [self.movesListView setNeedsDisplay];
            }];
        }
    }];
    
}

@end
