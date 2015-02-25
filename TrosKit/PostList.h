//
//  PostList.h
//  TrosKit
//
//  Created by Alex Boulton on 2/16/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface PostList : NSObject

@property (strong,nonatomic)NSMutableArray *postList;

-(NSMutableArray *)postsForUser:(User *)user;
-(void)addPost:(Post *)post;
-(void)updatePost:(Post *)post;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
