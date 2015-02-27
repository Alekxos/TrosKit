//
//  CompletionViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/26/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "CompletionViewController.h"
#import "Post.h"

@implementation CompletionViewController

@synthesize shipmentNameLabel;
@synthesize startAddressLabel;
@synthesize endAddressLabel;
@synthesize descriptionLabel;
@synthesize priceLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedPost=[defaults objectForKey:@"selectedPost"];
    Post *selectedPost=[NSKeyedUnarchiver unarchiveObjectWithData:encodedPost];
    shipmentNameLabel.text=selectedPost.name;
    startAddressLabel.text=selectedPost.startAddress;
    endAddressLabel.text=selectedPost.endAddress;
    priceLabel.text=[NSString stringWithFormat:@"%f",[defaults floatForKey:@"bidAmount"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
