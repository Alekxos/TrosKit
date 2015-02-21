//
//  Bid.h
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Bid : NSObject

@property float amount;
@property(strong,nonatomic) User *bidder;


@end
