//
//  PreviewView.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-06-27.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "PreviewView.h"

@interface PreviewView ()

@property (nonatomic) UILabel *nextNumberLabel;
@property (nonatomic) UILabel *secondNumberLabel;
@property (nonatomic) UILabel *thirdNumberLabel;
@property (nonatomic) CGRect secondFrame;
@property (nonatomic) CGRect thirdFrame;
@property (nonatomic) NSMutableArray *previousNumbers;
@end

@implementation PreviewView

- (instancetype)initWithNumbers:(NSArray *)numbers {
    self = [super init];
    if (self) {
        self.finishedAnimating = true;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor defaultDarkColor].CGColor;
        self.layer.borderWidth = 4;
        self.previousNumbers = [NSMutableArray new];
        
        self.nextNumberLabel = [UILabel new];
        self.nextNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
        self.nextNumberLabel.textColor = [UIColor blackColor];
        self.nextNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:0]];
        self.nextNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        self.secondNumberLabel = [UILabel new];
        self.secondNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.secondNumberLabel.textColor = [UIColor colorWithWhite:0.5f alpha:1];
        self.secondNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:1]];
        self.secondNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        self.thirdNumberLabel = [UILabel new];
        self.thirdNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.thirdNumberLabel.textColor = [UIColor colorWithWhite:0.8f alpha:1];
        self.thirdNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:2]];
        self.thirdNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.nextNumberLabel];
        [self addSubview:self.secondNumberLabel];
        [self addSubview:self.thirdNumberLabel];
    }
    return self;
}

- (void)playFadeAnimation {
    [self.nextNumberLabel.layer removeAllAnimations];
    self.nextNumberLabel.alpha = 1;
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut) animations:^{
        self.nextNumberLabel.alpha = 0.15;
    } completion:nil];
}

- (void)layoutSubviews {
    self.nextNumberLabel.frame = SKRectSetSize(self.nextNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.nextNumberLabel.frame = SKRectSetX(self.nextNumberLabel.frame, self.frame.size.width*0.66);
    
    self.secondNumberLabel.frame = SKRectSetSize(self.secondNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.secondNumberLabel.frame = SKRectSetX(self.secondNumberLabel.frame, self.frame.size.width*0.30);
    
    self.thirdNumberLabel.frame = SKRectSetSize(self.thirdNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.thirdNumberLabel.frame = SKRectSetX(self.thirdNumberLabel.frame, self.frame.size.width*0.04);
    
    self.secondFrame = self.secondNumberLabel.frame;
    self.thirdFrame = self.thirdNumberLabel.frame;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cx, 4);
    CGContextSetStrokeColorWithColor(cx, [UIColor defaultDarkColor].CGColor);
    
    CGFloat pattern[] = {4,4};
    CGContextSetLineDash(cx, 4.0, pattern, 2);
    
    CGContextMoveToPoint(cx, self.bounds.size.width*0.66, 0);
    CGContextAddLineToPoint(cx, self.bounds.size.width*0.66, self.bounds.size.height);
    CGContextStrokePath(cx);
}

- (int)nextNumber {
    return [self.nextNumberLabel.text intValue];
}

- (void)replaceNumber:(int)number {
    self.nextNumberLabel.text = [NSString stringWithFormat:@"%i", number];
}

- (void)newNumbers:(NSArray *)numbers {
    self.nextNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:0]];
    self.secondNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:1]];
    self.thirdNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:2]];
}

- (void)newNumber:(int)number {
    self.finishedAnimating = false;
    self.nextNumberLabel.text = @"";
    
    [UIView animateWithDuration:0.15 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.secondNumberLabel.frame = self.nextNumberLabel.frame;
        self.thirdNumberLabel.frame = self.secondFrame;
    } completion:^(BOOL finished){
        self.secondNumberLabel.frame = self.secondFrame;
        self.thirdNumberLabel.frame = self.thirdFrame;
        self.nextNumberLabel.text = self.secondNumberLabel.text;
        self.secondNumberLabel.text = self.thirdNumberLabel.text;
        self.thirdNumberLabel.text = [NSString stringWithFormat:@"%i", number];
        self.finishedAnimating = true;
    }];
}

- (void)storeCurrentValues {
    int a = [self.nextNumberLabel.text intValue];
    int b = [self.secondNumberLabel.text intValue];
    int c = [self.thirdNumberLabel.text intValue];

    [self.previousNumbers addObject:@[[NSNumber numberWithInt:a], [NSNumber numberWithInt:b],[NSNumber numberWithInt:c]]];
}

- (void)undo {
    if (self.previousNumbers.count > 0) {
        [self newNumbers:[self.previousNumbers lastObject]];
        [self.previousNumbers removeLastObject];
    }
}

-(void)lastStorageUndo:(NSString *)number {
    self.thirdNumberLabel.text = self.secondNumberLabel.text;
    self.secondNumberLabel.text = self.nextNumberLabel.text;
    self.nextNumberLabel.text = number;
}

- (void)resetValues {
    [self.previousNumbers removeAllObjects];
}

@end
