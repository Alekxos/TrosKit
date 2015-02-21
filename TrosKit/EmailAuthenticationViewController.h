//
//  EmailAuthenticationViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailAuthenticationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmEmailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *retypeTextField;
@property (strong, nonatomic) IBOutlet UILabel *emailCheckLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordCheckLabel;
@property (strong, nonatomic) IBOutlet UILabel *helpLabel;
- (IBAction)createAccount:(UIButton *)sender;

@end
