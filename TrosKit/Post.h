//
//  Post.h
//  TrosKit
//
//  Created by Alex Boulton on 2/16/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bid.h"

@class User;
@interface Post : NSObject

@property(strong,nonatomic) User* poster;
@property(strong,nonatomic) NSString *startAddress;
@property(strong,nonatomic) NSString *endAddress;
@property(strong,nonatomic) NSDate *latestDelivery;
@property(strong,nonatomic) NSString *description;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSMutableArray *bids;

-(void)addBid:(Bid *)bid;

@end
