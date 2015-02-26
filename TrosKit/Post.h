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
@class Bid;

@interface Post : NSObject

@property(strong,nonatomic) User* poster;
@property(strong,nonatomic) NSString *startAddress;
@property(strong,nonatomic) NSString *endAddress;
@property(strong,nonatomic) NSDate *latestDelivery;
@property(strong,nonatomic) NSString *description;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSMutableArray *bids;
@property float finalPrice;

-(void)addBid:(Bid *)bid;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

-(User *)getPoster;

@end
