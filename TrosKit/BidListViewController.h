//
//  BidListViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidListViewController : UIViewController <UITableViewDataSource,UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *bidListTableView;
@property (strong, nonatomic) IBOutlet UILabel *selectedShipmentName;
@property (strong, nonatomic) IBOutlet UILabel *startAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *endAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *latestDeliveryLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
