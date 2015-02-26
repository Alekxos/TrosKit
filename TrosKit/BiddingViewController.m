//
//  BiddingViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "BiddingViewController.h"
#import "Post.h"
#import "PostList.h"
#import "Bid.h"
#import "User.h"

@interface BiddingViewController ()

@end

@implementation BiddingViewController

@synthesize nameLabel;
@synthesize bidBox;
@synthesize descriptionTextView;

Post *selectedPost;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedPostList=[defaults objectForKey:@"postlist"];
    PostList *postlist = [NSKeyedUnarchiver unarchiveObjectWithData:encodedPostList];
    int bn=(int)[defaults integerForKey:@"bidNumber"];
    NSLog(@"bid number: %i",bn);
    selectedPost=[postlist.postList objectAtIndex:bn];
    nameLabel.text=selectedPost.name;
    descriptionTextView.text=selectedPost.description;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bid:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    Bid *bid=[[Bid alloc]init];
    NSData *encodedUser=[defaults objectForKey:@"current user"];
    NSData *encodedPostList=[defaults objectForKey:@"postlist"];
    User *currentUser=[NSKeyedUnarchiver unarchiveObjectWithData:encodedUser];
    PostList *postlist=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPostList];
    bid.amount=[bidBox.text floatValue];
    bid.bidder=currentUser;
    [selectedPost addBid:bid];
    NSLog(@"SPBC: %ld",selectedPost.bids.count);
    [postlist updatePost:selectedPost];
    NSData *encodedPostList2=[NSKeyedArchiver archivedDataWithRootObject:postlist];
    [defaults setObject:encodedPostList2 forKey:@"postlist"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"BiddingToDriveSegue" sender:self];
}
@end
