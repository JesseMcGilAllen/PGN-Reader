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

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.boardView setContentMode:UIViewContentModeRedraw];
}

- (void)configureViewForLandscapeOrientation
{
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat boardWidth = self.view.frame.size.width * (double)FOUR/FIVE;
    CGFloat listWidth = self.view.frame.size.width - boardWidth;
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, boardWidth, viewHeight);
    CGRect movesListRect = CGRectMake(boardWidth, ZERO, listWidth, viewHeight);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;

    NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    [self.view setNeedsDisplay];
    
    
}

- (void)configureViewForPortraitOrientation
{
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat boardLength = self.view.frame.size.height * (double)FOUR/FIVE;
    
    NSLog(@"4/5: %f", (double)FOUR/FIVE);
    NSLog(@"board length: ");
    
    NSLog(@"Board Length: %f", boardLength);
    CGFloat listLength = self.view.frame.size.height - boardLength;
    
    CGRect boardViewRect = CGRectMake(ZERO, ZERO, viewWidth, boardLength);
    CGRect movesListRect = CGRectMake(ZERO, boardLength, viewWidth, listLength);
    
    self.boardView.frame = boardViewRect;
    self.movesListView.frame = movesListRect;
    
     NSLog(@"Board View Frame: %f, %f, %f, %f", self.boardView.frame.origin.x, self.boardView.frame.origin.y, self.boardView.frame.size.width, self.boardView.frame.size.height);
    
    [self.view setNeedsDisplay];
}
@end
