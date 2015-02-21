//
//  UserBase.m
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "UserBase.h"

@interface UserBase()

@property (strong,nonatomic)NSMutableDictionary *users;

@end

@implementation UserBase

@synthesize users;


-(UserBase *)init{
    return self;
}
-(void)addUser:(User *)user{
    if(users==NULL){
        users=[[NSMutableDictionary alloc]init];
    }
    [users setValue:user forKey:user.emailAddress];
}
-(User *)getUserForEmail:(NSString *)email{
    return [users valueForKey:email];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.users forKey:@"users"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.users = [decoder decodeObjectForKey:@"users"];
    }
    return self;
}
@end
