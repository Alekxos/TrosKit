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
@synthesize finalPrice;

-(void)addBid:(Bid *)bid{
    if(![bid.bidder.emailAddress isEqualToString:poster.emailAddress]) [bids addObject:bid];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.poster forKey:@"poster"];
    [encoder encodeObject:self.startAddress forKey:@"startAddress"];
    [encoder encodeObject:self.endAddress forKey:@"endAddress"];
    [encoder encodeObject:self.latestDelivery forKey:@"latestDelivery"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.bids forKey:@"bids"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.poster = [decoder decodeObjectForKey:@"poster"];
        self.startAddress = [decoder decodeObjectForKey:@"startAddress"];
        self.endAddress = [decoder decodeObjectForKey:@"endAddress"];
        self.latestDelivery = [decoder decodeObjectForKey:@"latestDelivery"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.bids = [decoder decodeObjectForKey:@"bids"];
    }
    return self;
}
-(User *)getPoster{
    return self.poster;
}

@end
