//
//  PostList.m
//  TrosKit
//
//  Created by Alex Boulton on 2/16/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "PostList.h"
#import "Post.h"
#import "User.h"

@implementation PostList

@synthesize postList;

-(PostList *)init{
    postList=[[NSMutableArray alloc]init];
    return [super init];
}

-(void)addPost:(Post *)post{
    [postList addObject:post];
}

-(NSMutableArray *)postsForUser:(User *)user{
    NSMutableArray *returnArray=[[NSMutableArray alloc]init];
    for(Post *p in postList){
        NSLog(@"Next post:");
        User *u=[p getPoster];
        if(u==NULL){
            NSLog(@"well it's null");
        }
        NSLog(@"Poster name: %@",u.firstName);
        NSLog(@"poster email address: %@",u.emailAddress);
        NSLog(@"user email address: %@",user.emailAddress);
        if([u.emailAddress isEqualToString:user.emailAddress]){
            [returnArray addObject:p];
        }
    }
    
    return returnArray;
}

-(void)updatePost:(Post *)post{
    for(int x=0;x<postList.count;x++){
        Post *p=[postList objectAtIndex:x];
        if([p.poster.emailAddress isEqualToString:post.poster.emailAddress]){
            [postList setObject:postList atIndexedSubscript:x];
        }
    }
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.postList forKey:@"postList"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.postList = [decoder decodeObjectForKey:@"postList"];
    }
    return self;
}


@end
