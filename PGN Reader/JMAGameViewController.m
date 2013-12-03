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
#import "JMAGameEngine.h"
#import "JMABoardModel.h"
#import "JMASquare.h"
#import "JMAMove.h"

@interface JMAGameViewController ()
@property (weak, nonatomic) IBOutlet JMABoardView *boardView;
@property (weak, nonatomic) IBOutlet UITextView *movesListView;

@property (strong, nonatomic) JMAMovesListParser *movesListParser;
@property (strong, nonatomic) JMAGameEngine *gameEngine;
@property (strong, nonatomic) JMABoardModel *boardModel;

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
    
    [self configureMovesList];
    
    
    
    [self setupBoard];
    [self setupGame];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configureToolbar];
    
    [self configureInsets];
    
    [self determineInterfaceOrientation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 This method creates a BoardModel object and sets it to the BoardView's board
 model property
*/
- (void)setupBoard
{
    self.boardModel = [[JMABoardModel alloc] init];
    
    if (!self.boardView.model) {
        self.boardView.model = self.boardModel;
    }
}

- (void)setupGame
{
    self.gameEngine = [[JMAGameEngine alloc] init];
    
    self.gameEngine.model = self.boardModel;
}

# pragma mark - Configure Interface for Orientation
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
    
    [self.boardView drawBoard];
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
    CGFloat toolbarHeight = [self toolbarHeight];
    
    CGFloat occupiedHeight = navigationControllerHeight + toolbarHeight;
    
    
    CGFloat viewHeight = self.view.frame.size.height;
    
    CGFloat availableLength = viewHeight - occupiedHeight;
    
    
    CGFloat boardWidth = self.view.frame.size.width * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.width - boardWidth;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, boardWidth, availableLength);
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
    CGFloat toolbarHeight = [self toolbarHeight];
    
    CGFloat occupiedHeight = navigationControllerHeight + toolbarHeight;
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    CGFloat availableLength = self.view.frame.size.height - occupiedHeight;
    
    CGFloat boardLength = availableLength * (double)FOUR/FIVE;
    
    CGFloat listLength = self.view.frame.size.height - boardLength;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, viewWidth, boardLength);
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
}


# pragma mark - Handle Interface Orientations
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
    [self.boardView drawBoard];
    
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
    CGFloat toolbarHeight = [self toolbarHeight];
    
    CGFloat occupiedHeight = navigationControllerHeight + toolbarHeight;

    CGFloat viewHeight = self.view.frame.size.width;
    
    CGFloat availableLength = viewHeight - occupiedHeight;
    
    CGFloat boardWidth = self.view.frame.size.height * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.height - boardWidth;
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, boardWidth, availableLength);
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
    
    CGFloat listLength = self.view.frame.size.width - (boardLength);
    
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
 This method returns the toolbar's height
 */
- (CGFloat)toolbarHeight
{
    return self.navigationController.toolbar.frame.size.height;
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


# pragma mark - Toolbar
/*
 This method adds the buttons require for playing through the chess game.
*/
- (void)configureToolbar
{
    NSArray *toolbarItems;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    UIBarButtonItem *gameEndButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                                       target:self
                                                                                       action:@selector(gameEndButtonTapped:)];

    
    UIBarButtonItem *playGameButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                    target:self
                                                                                    action:@selector(playGameButtonTapped:)];
    
    UIBarButtonItem *gameStartButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                                     target:self
                                                                                     action:@selector(gameStartButtonTapped:)];
    toolbarItems = @[gameStartButton, playGameButton, gameEndButton];
    
    [self setToolbarItems:toolbarItems animated:YES];
    
    
}

#pragma mark - Button Taps
- (IBAction)gameStartButtonTapped:(id)sender
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
}

- (IBAction)playGameButtonTapped:(id)sender
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    
    if ((self.boardModel.halfMoveIndex) == [self.boardModel halfMoveCount]) {
        return;
    }
    
    JMAMove *move = [self.boardModel currentMove];
    
    NSLog(@"Move: %@", move.moveString);
    
    NSArray *squaresForMove = [self.gameEngine squaresInvolvedInMove:move];
    

    
    for (JMASquare *square in squaresForMove) {
        NSLog(@"Coordinate: %@", square.coordinate);
    }
    
    [self.boardView updateBoardWithMove:move squares:squaresForMove];
    [self.boardModel makeMove:move withSquares:squaresForMove];
    
    // update BoardView
    
    self.boardModel.halfMoveIndex++;
    
}

- (IBAction)gameEndButtonTapped:(id)sender
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
}

# pragma mark - Move List
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
                [self.boardModel movesForGame:[self.movesListParser movesForGame]];
                [self.movesListView setNeedsDisplay];
            }];
        }
    }];
}

@end
