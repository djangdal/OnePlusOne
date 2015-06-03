//
//  GridView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-04-24.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "GridView.h"
#import "GameState.h"
#import "GridCellView.h"

@interface GridView ()

@property (nonatomic) CGFloat gridSize;
@property (nonatomic) CGFloat cellSize;
//@property (nonatomic) NSArray *grid;
@property (nonatomic) GameState *gameState;

@end

CGFloat const kLineSize = 5;

@implementation GridView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor defaultWhiteColor];
    }
    return self;
}

- (void)setUpForGameState:(GameState *)gameState {
    [self removeCells];
    self.gameState = gameState;
    self.gridSize = self.gameState.grid.count;
    [self addCells];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)removeCells {
    for (NSArray *inner in self.gameState.grid) {
        for (GridCellView *cell in inner) {
            [cell removeFromSuperview];
        }
    }
}

- (void)addCells {
    for (NSArray *inner in self.gameState.grid) {
        for (GridCellView *cell in inner) {
            [self addSubview:cell];
        }
    }
}

- (void)layoutSubviews {
    self.cellSize = (self.bounds.size.width/self.gridSize) - kLineSize/self.gridSize;
    for (int x = 0; x<self.gameState.grid.count; x++) {
        NSArray *inner = [self.gameState.grid objectAtIndex:x];
        for (int y = 0; y<inner.count; y++) {
            GridCellView *gridCellView = [inner objectAtIndex:y];
            gridCellView.userInteractionEnabled = NO;
            gridCellView.frame = CGRectMake(x*self.cellSize+kLineSize, y*self.cellSize+kLineSize, self.cellSize-kLineSize, self.cellSize-kLineSize);
        }
    }
}

- (GridCellView *)gridCellViewForTouchPoint:(CGPoint)touchPoint {
    int cellX = touchPoint.x / (self.frame.size.width/self.gridSize);
    int cellY = touchPoint.y / (self.frame.size.height/self.gridSize);
    return [[self.gameState.grid objectAtIndex:cellX] objectAtIndex:cellY];
}

- (NSArray *)neighboursForCell:(GridCellView *)gridCellView {
    NSMutableArray *neighbours = [NSMutableArray new];
    if (gridCellView.x > 0) {
        [neighbours addObject:[[self.gameState.grid objectAtIndex:gridCellView.x-1] objectAtIndex:gridCellView.y]];
    }
    if (gridCellView.x < self.gridSize-1) {
        [neighbours addObject:[[self.gameState.grid objectAtIndex:gridCellView.x+1] objectAtIndex:gridCellView.y]];
    }
    if (gridCellView.y > 0) {
        [neighbours addObject:[[self.gameState.grid objectAtIndex:gridCellView.x] objectAtIndex:gridCellView.y-1]];
    }
    if (gridCellView.y < self.gridSize-1) {
        [neighbours addObject:[[self.gameState.grid objectAtIndex:gridCellView.x] objectAtIndex:gridCellView.y+1]];
    }
    return neighbours;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor defaultDarkColor].CGColor);
    CGContextSetLineWidth(context, kLineSize);
    
    for (int i = 0; i<=self.gridSize; i++) {
        CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds) + self.cellSize*i + kLineSize/2);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds) + self.cellSize*i + kLineSize/2);
        
        CGContextMoveToPoint(context, CGRectGetMinX(self.bounds) + self.cellSize*i + kLineSize/2, CGRectGetMinY(self.bounds));
        CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds) + self.cellSize*i + kLineSize/2, CGRectGetMaxY(self.bounds));
    }
    
    CGContextStrokePath(context);
}

@end
