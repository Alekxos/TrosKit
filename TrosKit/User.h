//
//  User.h
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface User : NSObject

@property(strong,nonatomic) NSString *firstName;
@property(strong,nonatomic) NSString *lastName;
@property(strong,nonatomic) NSString *emailAddress;
@property(strong,nonatomic) NSMutableArray *posts;


-(User *)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)email;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
