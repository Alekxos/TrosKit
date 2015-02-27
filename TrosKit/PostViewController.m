//
//  PostViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/9/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "PostViewController.h"
#import "User.h"
#import "PostList.h"

@interface PostViewController ()

@end


@implementation PostViewController

@synthesize nameLabel;
@synthesize postTableView;

NSMutableArray *userPosts;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedObject=[defaults valueForKey:@"current user"];
    User *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];

    nameLabel.text=[NSString stringWithFormat:@"Welcome, %@",currentUser.firstName];
    
    NSData *encodedPostList = [defaults objectForKey:@"postlist"];
    PostList *postlist = [NSKeyedUnarchiver unarchiveObjectWithData:encodedPostList];
    
    NSLog(@"current name: %@",currentUser.firstName);
    userPosts=[postlist postsForUser:currentUser];
    /*[base addUser:newUser];
    NSData *encodedUserBase2 = [NSKeyedArchiver archivedDataWithRootObject:base];
    [defaults setObject:encodedUserBase2 forKey:@"cache"];
    [defaults synchronize];*/
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Set the data for this cell:
    NSLog(@"Row: %li",(long)indexPath.row);
    NSLog(@"Post at row %li: %@",(long)indexPath.row,((Post *)[userPosts objectAtIndex:indexPath.row]).name);
    cell.textLabel.text = ((Post *)[userPosts objectAtIndex:indexPath.row]).name;
    cell.detailTextLabel.text = ((Post *)[userPosts objectAtIndex:indexPath.row]).description;
    
    // set the accessory view:
    //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *temp=[defaults objectForKey:@"postlist"];
    PostList *p=[NSKeyedUnarchiver unarchiveObjectWithData:temp];
    NSMutableArray *allPosts=p.postList;
    NSLog(@"postView allPosts: %@",allPosts);
    for(Post *p in allPosts){
        NSLog(@"POST desc: %@",p.description);
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return userPosts.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    Post *selected=[userPosts objectAtIndex:row];
    NSLog(@"NOW NOW NOW %f",((Bid *)[selected.bids objectAtIndex:0]).amount);
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:selected] forKey:@"selectedPost"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"PostToBidListSegue" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
