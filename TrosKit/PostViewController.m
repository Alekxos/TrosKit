//
//  PostViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/9/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end


@implementation PostViewController

@synthesize nameLabel;
@synthesize emailLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *userFullName=[defaults objectForKey:@"User Full Name"];
    NSString *userEmail=[defaults objectForKey:@"User Email"];
    
    emailLabel.text=userEmail;
    nameLabel.text=userFullName;
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

@end
