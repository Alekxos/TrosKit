//
//  EmailAuthenticationViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/13/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "EmailAuthenticationViewController.h"
#import "User.h"
#import "UserBase.h"

@interface EmailAuthenticationViewController ()

@end

@implementation EmailAuthenticationViewController

@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize emailAddressTextField;
@synthesize confirmEmailAddressTextField;
@synthesize passwordTextField;
@synthesize emailCheckLabel;
@synthesize retypeTextField;
@synthesize passwordCheckLabel;
@synthesize helpLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    [emailAddressTextField addTarget:self
                  action:@selector(updateEmailCheck:)
        forControlEvents:UIControlEventEditingChanged];
    [confirmEmailAddressTextField addTarget:self
                  action:@selector(updateEmailCheck:)
        forControlEvents:UIControlEventEditingChanged];
    [passwordTextField addTarget:self
                  action:@selector(updatePasswordCheck:)
        forControlEvents:UIControlEventEditingChanged];
    [retypeTextField addTarget:self
                  action:@selector(updatePasswordCheck:)
        forControlEvents:UIControlEventEditingChanged];
    
    
    // Do any additional setup after loading the view.
}

//Also check if email is taken already or not
-(void)updateEmailCheck{
    if([emailAddressTextField.text isEqualToString:@""]||[confirmEmailAddressTextField.text isEqualToString:@""]){
        emailCheckLabel.text=@"Blank";
    }
    else if(![emailAddressTextField.text isEqualToString:confirmEmailAddressTextField.text]){
        emailCheckLabel.text=@"Wrong (red x)";
    }
    else if([emailAddressTextField.text isEqualToString:confirmEmailAddressTextField.text]){
        emailCheckLabel.text=@"Check (green)";
    }
}

-(void)updatePasswordCheck{
    if([passwordTextField.text isEqualToString:@""]||[retypeTextField.text isEqualToString:@""]){
        passwordCheckLabel.text=@"Blank";
    }
    else if(![passwordTextField.text isEqualToString:retypeTextField.text]){
        passwordCheckLabel.text=@"Wrong (red x)";
    }
    else if([passwordTextField.text isEqualToString:retypeTextField.text]){
        passwordCheckLabel.text=@"Check (green)";
    }
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

- (IBAction)createAccount:(UIButton *)sender {
    if([firstNameTextField.text isEqualToString:@""]){
        helpLabel.text=@"Please enter a first name.";
    }
    else if([lastNameTextField.text isEqualToString:@""]){
        helpLabel.text=@"Please enter a last name.";
    }
    else if([emailAddressTextField.text isEqualToString:@""]){
        helpLabel.text=@"Please enter an email address.";
    }
    //Check if email address contains '@' and ends with '.com'
    else if([emailAddressTextField.text isEqualToString:@""]){
        helpLabel.text=@"Please enter an email address.";
    }
    else if(![emailAddressTextField.text isEqualToString:confirmEmailAddressTextField.text]){
        helpLabel.text=@"Email addresses do not match";
    }
    else if([passwordTextField.text isEqualToString:@""]){
        helpLabel.text=@"Please enter a password.";
    }
    else if(![passwordTextField.text isEqualToString:retypeTextField.text]){
        helpLabel.text=@"Passwords do not match";
    }
    else{
        User *newUser=[[User alloc]initWithFirstName:firstNameTextField.text lastName:lastNameTextField.text emailAddress:emailAddressTextField.text];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSData *encodedUser = [NSKeyedArchiver archivedDataWithRootObject:newUser];
        [defaults setObject:encodedUser forKey:@"current user"];
        //Add to user base
        NSData *encodedUserBase = [defaults objectForKey:@"cache"];
        UserBase *base = [NSKeyedUnarchiver unarchiveObjectWithData:encodedUserBase];
        [base addUser:newUser];
        NSData *encodedUserBase2 = [NSKeyedArchiver archivedDataWithRootObject:base];
        [defaults setObject:encodedUserBase2 forKey:@"cache"];
        //
        [defaults synchronize];
        if([[defaults objectForKey:@"post" ] isEqualToString:@"true"]){
            [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
        }
        else if([[defaults objectForKey:@"drive" ] isEqualToString:@"true"]){
            [self performSegueWithIdentifier:@"AuthenticationToDriveSegue" sender:self];
        }
    }
}
@end
