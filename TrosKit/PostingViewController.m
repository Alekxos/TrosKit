//
//  PostingViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/16/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "PostingViewController.h"
#import "Post.h"
#import "PostList.h"

@interface PostingViewController ()

@end

@implementation PostingViewController

@synthesize nameTextField;
@synthesize startingAddressTextField;
@synthesize endingAddressTextField;
@synthesize descriptionTextView;
@synthesize latestDatePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)postShipment:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedObject=[defaults valueForKey:@"current user"];
    User *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    NSData *encodedPostList = [defaults objectForKey:@"postlist"];
    PostList *postlist = [NSKeyedUnarchiver unarchiveObjectWithData:encodedPostList];
    
    Post *newPost=[[Post alloc]init];
    newPost.poster=currentUser;
    newPost.name=nameTextField.text;
    newPost.startAddress=startingAddressTextField.text;
    newPost.endAddress=endingAddressTextField.text;
    newPost.latestDelivery=latestDatePicker.date;
    newPost.description=descriptionTextView.text;
    
    [postlist addPost:newPost];
    
    NSData *encoded=[NSKeyedArchiver archivedDataWithRootObject:postlist];
    [defaults setObject:encoded forKey:@"postlist"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"PostingToPostSegue" sender:self];
}
@end
