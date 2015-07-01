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

@end

@implementation PreviewView

- (instancetype)initWithNumbers:(NSArray *)numbers {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor defaultDarkColor].CGColor;
        self.layer.borderWidth = 4;
        
        self.nextNumberLabel = [UILabel new];
        self.nextNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
        self.nextNumberLabel.textColor = [UIColor blackColor];
        self.nextNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:0]];
        self.nextNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        self.secondNumberLabel = [UILabel new];
        self.secondNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.secondNumberLabel.textColor = [UIColor blackColor];
        self.secondNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:1]];
        self.secondNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        self.thirdNumberLabel = [UILabel new];
        self.thirdNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.thirdNumberLabel.textColor = [UIColor blackColor];
        self.thirdNumberLabel.text = [NSString stringWithFormat:@"%@", [numbers objectAtIndex:2]];
        self.thirdNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.nextNumberLabel];
        [self addSubview:self.secondNumberLabel];
        [self addSubview:self.thirdNumberLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut) animations:^{
        self.nextNumberLabel.alpha = 0.15;
    } completion:nil];
    self.nextNumberLabel.frame = SKRectSetSize(self.nextNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.nextNumberLabel.frame = SKRectSetX(self.nextNumberLabel.frame, self.frame.size.width*0.66);
    
    self.secondNumberLabel.frame = SKRectSetSize(self.secondNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.secondNumberLabel.frame = SKRectSetX(self.secondNumberLabel.frame, self.frame.size.width*0.30);
    
    self.thirdNumberLabel.frame = SKRectSetSize(self.thirdNumberLabel.frame, CGSizeMake(self.frame.size.width*0.33, self.frame.size.height));
    self.thirdNumberLabel.frame = SKRectSetX(self.thirdNumberLabel.frame, self.frame.size.width*0.04);
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
    self.nextNumberLabel.text = self.secondNumberLabel.text;
    self.secondNumberLabel.text = self.thirdNumberLabel.text;
    self.thirdNumberLabel.text = [NSString stringWithFormat:@"%i", number];
}

@end
