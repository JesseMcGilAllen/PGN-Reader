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
#import "JMAChessConstants.h"
#import "JMAConstants.h"
#import "JMAMovesListParser.h"
#import "JMAGameEngine.h"
#import "JMABoardModel.h"
#import "JMASquare.h"
#import "JMAMove.h"
#import "JMAGameInformationTableViewController.h"

@interface JMAGameViewController ()
@property (weak, nonatomic) IBOutlet JMABoardView *boardView;
@property (weak, nonatomic) IBOutlet UITextView *movesListView;

@property (strong, nonatomic) JMAMovesListParser *movesListParser;
@property (strong, nonatomic) JMAGameEngine *gameEngine;
@property (strong, nonatomic) JMABoardModel *boardModel;

@property (assign, nonatomic) UIEdgeInsets portraitInsets;
@property (assign, nonatomic) UIEdgeInsets landscapeInsets;
@property (assign, nonatomic) NSUInteger contentOffsetMultiplier;
@property (assign, nonatomic) CGFloat contentOffsetY;

@property (weak, nonatomic) NSTimer *repeatingTimer;

@property (weak, nonatomic) UIFont *textViewFont;




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
    
    self.textViewFont = [UIFont systemFontOfSize:EIGHTEEN];
    
    [self setupBoard];
    [self setupGame];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureToolbar];
    
    [self configureInsets];
    
    [self determineInterfaceOrientation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Warning!!!");
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
    
    CGFloat boardLength = availableLength * (double)THREE/FOUR;
    
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
     NSLog(@"ContentOffset: %f", self.movesListView.contentOffset.y);
    
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
    
    [self updateMovesListScrollForMove:nil withDirection:nil];
    
    if (self.movesListView.contentOffset.y == -(SIXTY_FOUR)) {

        self.movesListView.textContainerInset = UIEdgeInsetsZero;
    }

}

/*
 This method calculates the size and location of
 boardView and movesList elements when the device is in Portrait Orientation
 and sets those elements
*/
- (void)configureViewForPortraitOrientationForRotation
{
   
    self.movesListView.textContainerInset = self.portraitInsets;
    
    CGFloat navigationControllerHeight = [self navigationControllerHeight];
    CGFloat toolbarHeight = [self toolbarHeight];
    
    CGFloat occupiedHeight = navigationControllerHeight + toolbarHeight;
    CGFloat availableLength = self.view.frame.size.width - occupiedHeight;
    
    CGFloat viewWidth = self.view.frame.size.height;
    
    CGFloat boardLength = availableLength * (double)THREE/FOUR;
    
    CGFloat listLength = self.view.frame.size.width - (boardLength);
    
    CGRect boardViewRect = CGRectMake(ZERO, navigationControllerHeight, viewWidth, boardLength);
    
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    self.boardView.frame = boardViewRect;
    
    self.movesListView.frame = movesListRect;
    
    NSLog(@"top Inset: %f", self.movesListView.textContainerInset.top);
    
    
    [self updateMovesListScrollForMove:nil withDirection:nil];
    NSLog(@"ContentOffset: %f", self.movesListView.contentOffset.y);
    
    
//    CGPoint contentOffset = self.movesListView.contentOffset;
//    
//    self.movesListView.contentOffset = CGPointZero;
//    self.movesListView.contentOffset = contentOffset;

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

# pragma mark - Toolbar

/*
 This method returns the toolbar's height
 */
- (CGFloat)toolbarHeight
{
    
    return self.navigationController.toolbar.frame.size.height;
}

/*
 This method adds the buttons require for playing through the chess game.
*/
- (void)configureToolbar
{
    
    if (!self.repeatingTimer) {
        [self configureToolbarWithPlayButton];

    } else {
        [self configureToolBarWithPauseButton];
    }
    
    
    
}

/*
 This method adds three buttons to the toolbar, a previousMove button, 
 playGameButton, and nextMoveButton.
*/
- (void)configureToolbarWithPlayButton
{
    NSArray *toolbarItems;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    UIBarButtonItem *flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];

    UIBarButtonItem *nextMoveButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"next_arrow"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(makeMoveButtonTapped:)];
    
    UIBarButtonItem *previousMoveButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"previous_arrow"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(takebackMoveButtonTapped:)];
    
    UIBarButtonItem *playGameButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                    target:self
                                                                                    action:@selector(playGameButtonTapped:)];
    
    toolbarItems = @[previousMoveButton,
                     flexibleSpaceButton,
                     playGameButton,
                     flexibleSpaceButton,
                     nextMoveButton];
    
    [self setToolbarItems:toolbarItems animated:YES];
}

/*
 This method adds three buttons to the toolbar, a previousMove button,
 playGameButton, and nextMoveButton.
*/
- (void)configureToolBarWithPauseButton
{
    NSArray *toolbarItems;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    UIBarButtonItem *flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
 
    UIBarButtonItem *nextMoveButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next_arrow"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(makeMoveButtonTapped:)];
    
    UIBarButtonItem *previousMoveButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"previous_arrow"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(takebackMoveButtonTapped:)];
    
    UIBarButtonItem *pauseGameButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                                                    target:self
                                                                                    action:@selector(playGameButtonTapped:)];
    
    toolbarItems = @[previousMoveButton,
                     flexibleSpaceButton,
                     pauseGameButton,
                     flexibleSpaceButton,
                     nextMoveButton];
    
    [self setToolbarItems:toolbarItems animated:YES];

}
#pragma mark - Button Taps


- (IBAction)takebackMoveButtonTapped:(id)sender
{
    if (![self isStartOfGame]) {
        [self undoMove];
    }
    
}

/*
 This method uses a timer to play through the entire game until the end or the 
 user taps the pause button.
*/

- (IBAction)playGameButtonTapped:(id)sender
{
    if (!self.repeatingTimer) {
        
        [self startTimer];
        
                
    } else {
        
        [self stopTimer];
        
        
    }
}

/*
 Currently this method advances the game one half move.
 */
- (IBAction)makeMoveButtonTapped:(id)sender
{

    
    if (![self isEndOfGame]) {
        [self makeMove];
    }
    
}


#pragma mark - Timer Methods

/*
 This method create a timer object that calls the timerFireMethod: method every 
 second and sets it to the repeating timer property
*/
- (void)startTimer
{
    NSTimer *timer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:ONE
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:nil
                                            repeats:YES];
    
    self.repeatingTimer = timer;
    
    [self configureToolBarWithPauseButton];

}

/*
 This method checks if the Game has reached its end.  If it hasn't the makeMove
 method is called.  If the game has ended the stopTimer method is called.
*/
- (void)timerFireMethod:(NSTimer *)timer
{
    if (![self isEndOfGame]) {
        [self makeMove];
        
    
        
        
    } else {
        [self stopTimer];
        [self configureToolbar];

    }
}

/*
 This method stops the repeatingTimer method
*/
- (void)stopTimer
{
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
    
    [self configureToolbarWithPlayButton];
}

/*
 This method checks if a move has been played
*/
-(BOOL)isStartOfGame
{
    BOOL isStartOfGame = self.boardModel.halfMoveIndex == ZERO;
    
    return isStartOfGame;
}

/*
 This method checks if the game has reached its end.
*/
- (BOOL)isEndOfGame
{
    BOOL isEndOfGame = self.boardModel.halfMoveIndex == [self.boardModel halfMoveCount];
    
    return isEndOfGame;
}

/*
 This method gets the current move from the board model.  Then it gets the 
 squares needed to make that move. After that the view and model are updated 
 using those squares.  Finally, the board model's halfMoveIndex is incremented.
*/
- (void)makeMove
{
    JMAMove *move = [self.boardModel currentMove];
    
    NSArray *squaresForMove = [self.gameEngine squaresInvolvedInMove:move];
    
    [self.boardView updateBoardWithMove:move squares:squaresForMove];
    [self.boardModel makeMove:move withSquares:squaresForMove];

    [self highlightMove:move forMoveIndex:self.boardModel.halfMoveIndex];
    
    self.boardModel.halfMoveIndex++;
    
    if ([self isEndOfGame]) {
        UIAlertView *alert = [self alertForEndOfGame];
        
        [alert show];
    }
    
     [self updateMovesListScrollForMove:move withDirection:FORWARD];

}


/*
 This method takes back a previously played move
*/
- (void)undoMove
{

    
    if ([self isStartOfGame]) {
        return;
    }
    
    
    self.boardModel.halfMoveIndex--;
    JMAMove *move = [self.boardModel currentMove];
    
    // squares involved from gameEngine
    NSArray *squaresForTakingBackMove = [self.gameEngine squaresInvolvedTakingBackMove:move];
    
    // update BoardView
    [self.boardView updateBoardWithTakebackMove:move squares:squaresForTakingBackMove];
    // update BoardModel
    [self.boardModel takebackMove:move withSquares:squaresForTakingBackMove];
    
    JMAMove *previousMove = [self.boardModel previousMove];

    [self highlightMove:previousMove forMoveIndex:self.boardModel.halfMoveIndex - ONE];
        
    
    [self updateMovesListScrollForMove:move withDirection:BACKWARD];
    

}
# pragma mark - Move List

/*
 This method sets the inset properties to set the textView contentInset
 properties.
 */
- (void)configureInsets
{
    UIEdgeInsets defaultInsets = self.movesListView.textContainerInset;
    
    // CGFloat topPortraitInset = defaultInsets.top * TWO;
    
    self.landscapeInsets = UIEdgeInsetsMake(NEGATIVE_EIGHT, defaultInsets.left, defaultInsets.bottom, defaultInsets.right);
    self.portraitInsets = UIEdgeInsetsMake(FORTY, ZERO, FIFTEEN, ZERO);
    //self.landscapeInsets = defaultInsets;
    //self.portraitInsets = defaultInsets;
}

/*
 This method configures the movesListView text view.  
 The background color is set to white.  An operation queue is created to create
 an JMAMovesListParser object to process the moves property of the game object.
 When the JMAMovesListParser is done the movesListTextView is updated.
*/
- (void)configureMovesList
{
    self.contentOffsetMultiplier = ZERO;
    self.movesListView.backgroundColor = [UIColor whiteColor];
    
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    
    
    //[self.movesListView setNeedsDisplay];
    
    self.movesListView.contentSize = CGSizeMake(self.movesListView.frame.size.width * TWO, self.movesListView.frame.size.height * TWO);
    
    [aQueue addOperationWithBlock:^{
        self.movesListParser = [[JMAMovesListParser alloc] initWithMoves:self.game.moves];
        
        if (self.movesListParser.finished) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.movesListView.text = [self.movesListParser movesForTextView];
                self.movesListView.font = self.textViewFont;

                [self.boardModel movesForGame:[self.movesListParser movesForGame]];
                [self.movesListView setNeedsDisplay];
            }];
        }
    }];
    

}

/*
 This method highlights the move in the moves list Text View that has just been
 made on the board
*/
- (void)highlightMove:(JMAMove *)move forMoveIndex:(NSUInteger)moveIndex;
{
    
    if (!move) {
        [self unHighlightTextView];
        return;
    }
    
    NSUInteger currentMoveNumber = (moveIndex / TWO) + ONE;
    
    NSString *moveNumberString = [[NSString alloc] initWithFormat:@"%ld.", (unsigned long)currentMoveNumber];
    
    NSString *movesList = self.movesListView.text;
    NSRange rangeOfMoveNumber = [movesList rangeOfString:moveNumberString];

    NSRange rangeOfMove = [[movesList substringFromIndex:rangeOfMoveNumber.location] rangeOfString:move.moveString];
    
    rangeOfMove.location += rangeOfMoveNumber.location;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:movesList];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blueColor]
                             range:rangeOfMove];
    
    self.movesListView.attributedText = attributedString;
    self.movesListView.font = self.textViewFont;
}

/*
 This method removes the blue highlighting from the moves in the text view
*/
- (void)unHighlightTextView
{
    NSString *movesList = self.movesListView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:movesList];
    self.movesListView.attributedText = attributedString;
    self.movesListView.font = self.textViewFont;
}

/*
 This method calls the updateTextViewContentOffsetYForDirection method 
 and updates the ContentOffset accordingly.
*/
- (void)updateMovesListScrollForMove:(JMAMove *)move withDirection:(NSString *)direction
{
    NSUInteger currentMoveNumber = (self.boardModel.halfMoveIndex / TWO) + ONE;
    
    if (currentMoveNumber > NINE && [move.sideToMove isEqualToString:WHITE]) {
        
            [self updateTextViewContentOffsetYForDirection:direction];
            
        }
    
    self.movesListView.scrollEnabled = NO;
    [self.movesListView setContentOffset:CGPointMake(ZERO, self.contentOffsetY) animated:YES];
    self.movesListView.scrollEnabled = YES;
}

/*
 This method calculates the amount the scroll position should change for the
 move and adds it to the contentOffsetY property.
*/
- (void)updateTextViewContentOffsetYForDirection:(NSString *)direction
{

    // found through experimentation
    CGFloat offset = ((self.textViewFont.pointSize * FOUR) / THREE) - 2.55;
    
    if ([direction isEqualToString:FORWARD]) {
        self.contentOffsetY += offset;
    } else {
        self.contentOffsetY -= offset;
    }
    
    
    
}


/*
 This method creates an alert view to be displayed at the end of the game.
 The message of the alert is customized depending on the result of the game.
 The alertView is returned after created.  Replacing the title with the message 
 and eliminating the need for the message portion of the alert to be accordance
 with the HIG.
*/
- (UIAlertView *)alertForEndOfGame
{
    NSString *title;
    
    NSString *result = [self.game.result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([result isEqualToString:@"1-0"]) {
        title = @"White Wins";
    } else if ([result isEqualToString:@"0-1"]) {
        title = @"Black Wins";
    } else if ([result isEqualToString:@"1/2-1/2"]) {
        title = @"Game Drawn";
    } else {
        title = @"Line Ends";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    return alert;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_INFORMATION_SEGUE_IDENTIFIER]) {
        JMAGameInformationTableViewController *destinationViewController = segue.destinationViewController;
        
        destinationViewController.game = self.game;
    }
}

@end
