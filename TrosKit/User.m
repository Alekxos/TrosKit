//
//  User.m
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize firstName;
@synthesize lastName;
@synthesize emailAddress;
@synthesize posts;

-(User *)initWithFirstName:(NSString *)fn lastName:(NSString *)ln emailAddress:(NSString *)email{
    firstName=fn;
    lastName=ln;
    emailAddress=email;
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.emailAddress forKey:@"emailAddress"];
    [encoder encodeObject:self.posts forKey:@"posts"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.emailAddress = [decoder decodeObjectForKey:@"emailAddress"];
        self.posts = [decoder decodeObjectForKey:@"posts"];
    }
    return self;
}

@end
