//
//  BidListViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "BidListViewController.h"
#import "Bid.h"

@interface BidListViewController ()

@end

@implementation BidListViewController

NSMutableArray *bids;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedPost=[defaults objectForKey:@"selectedPost"];
    Post *selected=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPost];
    bids=selected.bids;
    cell.textLabel.text = [NSString stringWithFormat:@"%F",((Bid *)[bids objectAtIndex:indexPath.row]).amount];
    cell.detailTextLabel.text = ((Bid *)[bids objectAtIndex:indexPath.row]).bidder.firstName;
    
    // set the accessory view:
    //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return bids.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithLong:row] forKey:@"bidNumber"];
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
