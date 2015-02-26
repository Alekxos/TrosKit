//
//  BidListViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "BidListViewController.h"
#import "Bid.h"
#import "Post.h"

@interface BidListViewController ()

@end

@implementation BidListViewController

@synthesize selectedShipmentName;
@synthesize startAddressLabel;
@synthesize endAddressLabel;
@synthesize latestDeliveryLabel;
@synthesize descriptionTextView;


NSMutableArray *bids;
Post *selectedPost;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedPost=[defaults objectForKey:@"selectedPost"];
    selectedPost=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPost];
    selectedShipmentName.text=selectedPost.name;
    startAddressLabel.text=selectedPost.startAddress;
    endAddressLabel.text=selectedPost.endAddress;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd:"];
    
    //Optionally for time zone conversions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:selectedPost.latestDelivery];
    latestDeliveryLabel.text=stringFromDate;
    
    descriptionTextView.text=selectedPost.description;
    NSLog(@"selected post bid count: %ld",selectedPost.bids.count);
    
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
    bids=selectedPost.bids;
    cell.textLabel.text = [NSString stringWithFormat:@"%f",((Bid *)[bids objectAtIndex:indexPath.row]).amount];
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
    NSLog(@"row: %ld",(long)row);
    [defaults setObject:[NSNumber numberWithLong:row] forKey:@"bidNumber"];
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
