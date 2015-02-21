//
//  SelectBidViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/20/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBidViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shipperLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
- (IBAction)confirm:(UIButton *)sender;

@end
