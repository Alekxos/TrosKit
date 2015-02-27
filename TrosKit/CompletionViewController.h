//
//  CompletionViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/26/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *shipmentNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *startAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *endAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end
