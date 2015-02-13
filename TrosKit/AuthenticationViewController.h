//
//  AuthenticationViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/3/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController
- (IBAction)facebookAuthentication:(UIButton *)sender;
- (IBAction)googleAuthentication:(UIButton *)sender;
- (IBAction)emailAuthentication:(UIButton *)sender;

@end
