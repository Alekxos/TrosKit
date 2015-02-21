//
//  Post.m
//  TrosKit
//
//  Created by Alex Boulton on 2/16/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "Post.h"
#import "User.h"
#import "Bid.h"

@implementation Post

@synthesize poster;
@synthesize startAddress;
@synthesize endAddress;
@synthesize latestDelivery;
@synthesize description;
@synthesize name;
@synthesize bids;

-(void)addBid:(Bid *)bid{
    if(![bid.bidder.emailAddress isEqualToString:poster.emailAddress]) [bids addObject:bid];
}

@end
