//
//  InAppManager.h
//  OnePlusOne
//
//  Created by David Jangdal on 2016-02-13.
//  Copyright © 2016 David Jangdal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol InAppManagerDelegate <NSObject>

- (void)finishedTransaction:(SKPaymentTransaction *)transaction;
- (void)loadedProducts:(NSArray *)products;
@end

@interface InAppManager : NSObject

@property (nonatomic, readonly) NSArray *products;
@property id<InAppManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)removeTransactionObserver;
- (void)purchaseProduct:(SKProduct *)product;

@end