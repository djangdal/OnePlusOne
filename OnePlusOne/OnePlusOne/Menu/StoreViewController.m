//
//  StoreViewController.m
//  OnePlusOne
//
//  Created by David Jangdal on 2016-02-14.
//  Copyright © 2016 David Jangdal. All rights reserved.
//

#import "StoreViewController.h"
#import "InAppManager.h"

@interface StoreViewController () <InAppManagerDelegate>

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *closeButton;
@property (nonatomic) UIButton *purchaseButton;
@property (nonatomic) NSArray *perksLabels;
@property (nonatomic) UIActivityIndicatorView *activityView;
@property (nonatomic) SKProduct *fullGameProduct;

@end

@implementation StoreViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.minimumScaleFactor = 0.5;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.text = @"Unlock Full Game";
        self.titleLabel.textColor = [UIColor defaultDarkColor];
        
        [InAppManager sharedManager].delegate = self;
        
        self.messageLabel = [UILabel new];
        self.messageLabel.font = [UIFont fontWithName:@"Helvetica" size:21];
        self.messageLabel.textColor = [UIColor defaultDarkColor];
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.text = @"Purchase the Full Game and unlock the following";
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    
        NSMutableArray *array = [NSMutableArray new];
        for (NSString *s in @[@"All levels", @"Undo action", @"No ads"]) {
            UILabel *label = [UILabel new];
            label.font = [UIFont fontWithName:@"Helvetica" size:21];
            label.text = s;
            label.textColor = [UIColor defaultDarkColor];
            [array addObject:label];
        }
        self.perksLabels = [NSArray arrayWithArray:array];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView.hidesWhenStopped = true;
        [self.activityView stopAnimating];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeButton.backgroundColor = [UIColor defaultDarkColor];
        [self.closeButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
        
        self.purchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.purchaseButton.backgroundColor = [UIColor defaultDarkColor];
        [self.purchaseButton setTitleColor:[UIColor defaultWhiteColor] forState:UIControlStateNormal];
        [self.purchaseButton addTarget:self action:@selector(purchasePressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor defaultLightColor];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.purchaseButton];
    [self.purchaseButton addSubview:self.activityView];
    
    for (UILabel *label in self.perksLabels) {
        [self.view addSubview:label];
    }
    
    if ([InAppManager sharedManager].products != nil && [InAppManager sharedManager].products.count > 0) {
        self.fullGameProduct = [InAppManager sharedManager].products.firstObject;
        [self setPriceLabel];
    } else {
        [self.activityView startAnimating];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutViews];
}

- (void)layoutViews {
    CGSize size = self.view.bounds.size;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = SKRectCenterInRect(self.titleLabel.frame, self.view.frame);
    self.titleLabel.frame = SKRectSetY(self.titleLabel.frame, size.height*0.1f);
    
    static CGFloat messageMargins = 0.1;
    self.messageLabel.frame = SKRectSetY(self.messageLabel.frame, CGRectGetMaxY(self.titleLabel.frame));
    self.messageLabel.frame = SKRectSetX(self.messageLabel.frame, size.width*messageMargins);
    self.messageLabel.frame = SKRectSetRight(self.messageLabel.frame, size.width - size.width*messageMargins, YES);
    self.messageLabel.frame = SKRectSetHeight(self.messageLabel.frame, size.height*0.2);
    
    float labelY = CGRectGetMaxY(self.messageLabel.frame);
    for (UILabel *label in self.perksLabels) {
        [label sizeToFit];
        label.frame = SKRectCenterInRect(label.frame, self.view.frame);
        label.frame = SKRectSetY(label.frame, labelY);
        labelY += size.height*0.05;
    }
    
    static CGFloat buttonBottom = 0.08;
    static CGFloat buttonHeight = 0.15;
    static CGFloat buttonWidth = 0.75;
    
    self.closeButton.frame = SKRectSetHeight(self.closeButton.frame, size.width*buttonHeight);
    self.closeButton.frame = SKRectSetWidth(self.closeButton.frame, size.width*buttonWidth);
    self.closeButton.frame = SKRectCenterHorizontallyInRect(self.closeButton.frame, self.view.frame);
    self.closeButton.frame = SKRectSetBottom(self.closeButton.frame, size.height - size.height*buttonBottom, NO);
    
    self.purchaseButton.frame = SKRectSetHeight(self.purchaseButton.frame, size.width*buttonHeight);
    self.purchaseButton.frame = SKRectSetWidth(self.purchaseButton.frame, size.width*buttonWidth);
    self.purchaseButton.frame = SKRectCenterHorizontallyInRect(self.purchaseButton.frame, self.view.frame);
    self.purchaseButton.frame = SKRectSetBottom(self.purchaseButton.frame, CGRectGetMinY(self.closeButton.frame) - size.height*buttonBottom, NO);
    
    self.activityView.frame = SKRectCenterInRect(self.activityView.frame, self.purchaseButton.frame);
}

- (void)setPriceLabel {
    [self.activityView stopAnimating];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.fullGameProduct.priceLocale];
    [self.purchaseButton setTitle:[NSString stringWithFormat:@"Purchase for: %@", [numberFormatter stringFromNumber:self.fullGameProduct.price]] forState:UIControlStateNormal];

}

- (void)closePressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)purchasePressed {
    [self.activityView startAnimating];
    [self.purchaseButton setTitle:@"" forState:UIControlStateNormal];
    [[InAppManager sharedManager] purchaseProduct:self.fullGameProduct];
}

- (void)loadedProducts:(NSArray *)products {
    if (products != nil && products.count > 0) {
        self.fullGameProduct = products.firstObject;
        [self setPriceLabel];
    }
}

-(void)finishedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"finished transaction in storeview");
    if (transaction.transactionState == SKPaymentTransactionStatePurchased || transaction.transactionState == SKPaymentTransactionStateRestored) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self setPriceLabel];
    }
}

@end
