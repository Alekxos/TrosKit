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
    NSData *encodedPosts=[defaults objectForKey:@"postlist"];
    
    User *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    PostList *postList=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPosts];
    allPosts=postList.postList;
    
    nameLabel.text=[NSString stringWithFormat:@"Welcome, %@",currentUser.firstName];
    
    NSLog(@"all post count: %ld",allPosts.count);
    for(id i in allPosts){
        Post *p=(Post *)i;
        NSLog(@"?????? %@",p.description);
        if(p==NULL){
            
        }
        else{
            
        }
    }
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
    //cell.textLabel.text=@"Title";
    //cell.detailTextLabel.text=@"details";
    cell.textLabel.text = ((Post *)[allPosts objectAtIndex:indexPath.row]).name;
    cell.detailTextLabel.text = ((Post *)[allPosts objectAtIndex:indexPath.row]).description;
    
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
