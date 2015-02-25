//
//  Bid.m
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "Bid.h"

@implementation Bid

@synthesize amount;
@synthesize bidder;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.bidder forKey:@"bidder"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.bidder = [decoder decodeObjectForKey:@"bidder"];
    }
    return self;
}


@end
