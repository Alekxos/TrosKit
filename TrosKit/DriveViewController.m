//
//  DriveViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "DriveViewController.h"
#import "User.h"
#import "PostList.h"
#import "Post.h"

@interface DriveViewController ()

@end

@implementation DriveViewController

@synthesize nameLabel;
@synthesize driveTableView;

NSMutableArray *allPosts;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedObject=[defaults valueForKey:@"current user"];
    //NSData *encodedPosts=[defaults objectForKey:@"postlist"];
    
    User *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    //PostList *postList=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPosts];
    
    
    NSData *temp=[defaults objectForKey:@"postlist"];
    PostList *p=[NSKeyedUnarchiver unarchiveObjectWithData:temp];
    allPosts=p.postList;
    
    nameLabel.text=[NSString stringWithFormat:@"Welcome, %@",currentUser.firstName];
    NSLog(@"name: %@",((Post *)[allPosts objectAtIndex:0]).name);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Drive Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Set the data for this cell:
    //cell.textLabel.text=@"Title";
    //cell.detailTextLabel.text=@"details";
    cell.textLabel.text = ((Post *)[allPosts objectAtIndex:indexPath.row]).name;
    
    cell.detailTextLabel.text = ((Post *)[allPosts objectAtIndex:indexPath.row]).description;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *temp=[defaults objectForKey:@"postlist"];
    PostList *p=[NSKeyedUnarchiver unarchiveObjectWithData:temp];

    NSData *encodedObject=[defaults valueForKey:@"current user"];
    User *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    NSMutableArray *allPosts=[p postsForUser:currentUser];
    NSLog(@"in tableview allPosts: %@",allPosts);
    for(Post *p in allPosts){
        NSLog(@"desc: %@",p.description);
    }
    
    /*static NSString *CellIdentifier = @"Cell";
     
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
     return cell;*/
    
    // set the accessory view:
    //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return allPosts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"row: %ld",(long)row);
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"bidNumber"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"DriveToBiddingSegue" sender:self];
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
