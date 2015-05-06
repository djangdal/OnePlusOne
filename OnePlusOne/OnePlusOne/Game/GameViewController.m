//
//  GameViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GameViewController.h"
#import "GridView.h"

@interface GameViewController ()

@property (nonatomic) int totalScore;
@property (nonatomic) int nextNumber;
@property (nonatomic) BOOL allowTouch;
@property (nonatomic) BOOL gameOngoing;

@property (nonatomic) NSArray *grid;

@property (nonatomic) GridView *gridView;
@property (nonatomic) StatusView *statusView;

@end

CGFloat const kGridMargin = 10;
CGFloat const kGridSize = 4;

@implementation GameViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpGrid];
        self.gridView = [[GridView alloc] initWithGrid:self.grid];
        self.statusView  = [[StatusView alloc] initWithDelegate:self];
    }
    return self;
}

- (void)startNewGame {
    self.gameOngoing = YES;
    self.allowTouch = YES;
    self.totalScore = 0;
    self.nextNumber = 1;
    [self.statusView updateScoreTo:self.totalScore];
    [self.statusView showNextNumber:self.nextNumber];
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            [cell resetCell];
        }
    }
}

- (void)setUpGrid{
    NSMutableArray *outer = [NSMutableArray new];
    for (int x=0; x<kGridSize; x++) {
        NSMutableArray *inner = [NSMutableArray new];
        for (int y=0; y<kGridSize; y++) {
            [inner addObject:[[GridCellView alloc] initWithX:x withY:y delegate:self]];
        }
        [outer addObject:inner];
    }
    self.grid = [[NSArray alloc] initWithArray:outer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.allowTouch) return;
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.gridView];
    if ([touch view] == self.gridView) {
        [self userSelectedCell:[self.gridView gridCellViewForTouchPoint:touchPoint]];
        
    }
}

- (void)userSelectedCell:(GridCellView *)gridCellView{
    if (gridCellView.cellValue == 0) {
        self.allowTouch = NO;
        [gridCellView startCellWithNumber:self.nextNumber];
        self.totalScore += self.nextNumber;
        [self.statusView updateScoreTo:self.totalScore];
        NSArray *neighbours = [self.gridView neighboursForCell:gridCellView];
        [gridCellView mergeWithNeighbours:neighbours];
    }
}

- (void)generateNextNumber {
    self.nextNumber = arc4random_uniform(4)+1;
    [self.statusView showNextNumber:self.nextNumber];
}

- (BOOL)isItGameOver{
    for (NSArray *inner in self.grid) {
        for (GridCellView *cell in inner) {
            if (cell.cellValue == 0) {
                return false;
            }
        }
    }
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gridView.frame = CGRectMake(kGridMargin,
                                     self.view.frame.size.height-self.view.frame.size.width+kGridMargin,
                                     self.view.frame.size.width-kGridMargin*2,
                                     self.view.frame.size.width-kGridMargin*2);
    self.statusView.frame = CGRectMake(kGridMargin,
                                       20,
                                       self.view.frame.size.width-kGridMargin*2,
                                       CGRectGetMinY(self.gridView.frame)-kGridMargin*3);
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.statusView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma GridCellViewProtocoll

- (void)mergedCellsWithScore:(int)score {
    self.totalScore += score;
    [self.statusView updateScoreTo:self.totalScore];
}

- (void)finishedMergingCells {
    [self generateNextNumber];
    self.allowTouch = YES;
    if ([self isItGameOver]) {
        NSLog(@"ITS GAME OVER");
        self.gameOngoing = NO;
    }
}
#pragma StatusViewProtocoll

- (void)quitButtonPressed{
    NSLog(@"quit");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)resetButtonPressed{
    NSLog(@"reset");
    [self startNewGame];
}
@end
