//
//  UserBase.h
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserBase : NSObject

-(UserBase *)init;
-(void)addUser:(User *)user;
-(User *)getUserForEmail:(NSString *)email;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
