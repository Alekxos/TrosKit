//
//  AuthenticationViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/3/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2Authentication.h"
#import "KeychainItemWrapper.h"
#import "User.h"
#import "UserBase.h"

#define GoogleClientID    @"888201765523-3ckdo6hmd8qc6n4am6n99j9029l9iro1.apps.googleusercontent.com"
#define GoogleClientSecret @"wSSy7QnRUxATk8SQSt26sAUH"
#define GoogleAuthURL @"https://accounts.google.com/o/oauth2/auth"
#define GoogleTokenURL @"https://accounts.google.com/o/oauth2/token"

#define FacebookClientID @"599056916893893"
#define FacebookClientSecret @"01da67d985fe718849787559569a8efe"
#define FacebookAuthURL @"https://www.facebook.com/dialog/oauth?client_id=599056916893893&redirect_uri=https://www.facebook.com/connect/login_success.html"

NSString *urlEndpoint;
static NSString *const keychainItemNameFacebook = @"TrosKit OAuth Facebook";
static NSString *const keychainItemNameGoogle = @"TrosKit OAuth Google";
NSURL *tokenURL;
NSString * redirectURI;

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    /*if([[defaults objectForKey:@"post" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
    }
    else if([[defaults objectForKey:@"drive" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthenticationToDriveSegue" sender:self];
    }*/
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:keychainItemNameGoogle
                                                                 clientID:GoogleClientID
                                                             clientSecret:GoogleClientSecret];
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

- (IBAction)facebookAuthentication:(UIButton *)sender {
    redirectURI = @"https://www.facebook.com/connect/login_success.html";
    tokenURL=[NSURL URLWithString:FacebookAuthURL];

    GTMOAuth2Authentication *auth=[GTMOAuth2Authentication authenticationWithServiceProvider:@"TrosKit" tokenURL:tokenURL redirectURI:redirectURI clientID: FacebookClientID clientSecret:FacebookClientSecret];
    auth.scope=@"email";
    
    GTMOAuth2ViewControllerTouch *viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth authorizationURL:[NSURL URLWithString:FacebookAuthURL] keychainItemName:keychainItemNameFacebook delegate:self finishedSelector:@selector(viewController:finishedWithFacebookAuth:error:)];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)googleAuthentication:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    User *current=[defaults objectForKey:@"current user"];
    if(current==NULL){
    urlEndpoint=@"https://www.googleapis.com/oauth2/v2/userinfo";
    
    tokenURL=[NSURL URLWithString:GoogleTokenURL];
    redirectURI = @"urn:ietf:wg:oauth:2.0:oob";
    NSString *scope=@"https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile";
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                 clientID:GoogleClientID
                                                             clientSecret:GoogleClientSecret
                                                         keychainItemName:keychainItemNameGoogle
                                                                 delegate:self
                                                         finishedSelector:@selector(viewController:finishedWithGoogleAuth:error:)];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
    //Launch Google authentication screen
    }
    else{
        if([[defaults objectForKey:@"post" ] isEqualToString:@"true"]){
            [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
        }
        else if([[defaults objectForKey:@"drive" ] isEqualToString:@"true"]){
            [self performSegueWithIdentifier:@"AuthenticationToDriveSegue" sender:self];
        }
    }
}
- (void)awakeFromNib {
    // Get the saved authentication, if any, from the keychain.
}
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
finishedWithFacebookAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self.navigationController popToViewController:self animated:NO];
    if(!auth.accessToken){
    NSString *authorizationCode=auth.code;
    NSString *urlString=[NSString stringWithFormat:@"https://graph.facebook.com/oauth/access_token?client_id=%@&redirect_uri=%@&client_secret=%@&code=%@",FacebookClientID,@"https://www.facebook.com/connect/login_success.html",FacebookClientSecret,authorizationCode];
    
    NSURL *url1 = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    
    NSError *error2 = nil;
    NSURLResponse *response1 = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request1
                                         returningResponse:&response1
                                                     error:&error2];
        
    //Begin parsing received data to get authorization code
    NSString *decoded=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    int expireLocation=(int)[decoded rangeOfString:@"&expires="].location;
    
    NSRange accessRange=NSMakeRange(@"access_token=".length, decoded.length-@"access_token=".length-(decoded.length-expireLocation));
    
    NSString *accessToken=[decoded substringWithRange:accessRange];
    NSRange expirationRange=NSMakeRange(@"access_token=".length+accessToken.length+@"&expires=".length, decoded.length-(@"access_token=".length+accessToken.length+@"&expires=".length));
    NSString *expirationTime=[decoded substringWithRange:expirationRange];
        
    auth.accessToken=accessToken;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    auth.expiresIn = [f numberFromString:expirationTime];
    }
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",auth.accessToken]];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2];
    
    NSError *error3 = nil;
    NSURLResponse *response2 = nil;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request2
                                         returningResponse:&response2
                                                     error:&error3];
    
    
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:&myError];
    
    NSString *userEmail=@"";NSString *userFullName=@"";
    NSString *firstName=@"";NSString *lastName=@"";
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        if([keyAsString isEqualToString:@"name"]){
            userFullName=valueAsString;
        }
        else if([keyAsString isEqualToString:@"email"]){
            userEmail=valueAsString;
        }
        else if([keyAsString isEqualToString:@"first_name"]){
            firstName=valueAsString;
        }
        else if([keyAsString isEqualToString:@"last_name"]){
            lastName=valueAsString;
        }
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    //Track current user in app
    User *newUser=[[User alloc]initWithFirstName:firstName lastName:lastName emailAddress:userEmail];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedUser = [NSKeyedArchiver archivedDataWithRootObject:newUser];
    [defaults setObject:encodedUser forKey:@"current user"];
    
    //Add to user base on REST API
    NSData *encodedUserBase = [defaults objectForKey:@"cache"];
    UserBase *base = [NSKeyedUnarchiver unarchiveObjectWithData:encodedUserBase];
    [base addUser:newUser];
    NSData *encodedUserBase2 = [NSKeyedArchiver archivedDataWithRootObject:base];
    [defaults setObject:encodedUserBase2 forKey:@"cache"];
    [defaults synchronize];
    
    //Launch personalied Post screen
    if([[defaults objectForKey:@"post" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
    }
    else if([[defaults objectForKey:@"drive" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthenticationToDriveSegue" sender:self];
    }
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithGoogleAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self.navigationController popToViewController:self animated:NO];
    NSString *urlString = urlEndpoint;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    NSError *error2 = nil;
    NSURLResponse *response = nil;
    [auth authorizeRequest:request delegate:self didFinishSelector:@selector(googleAuthentication:request:finishedWithError:)];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error2];
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    NSString *userEmail=@"";NSString *userFullName=@"";
    NSString *firstName=@"";NSString *lastName=@"";
    
    for(id key in res) {
        id value = [res objectForKey:key];
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        if([keyAsString isEqualToString:@"name"]){
            userFullName=valueAsString;
        }
        else if([keyAsString isEqualToString:@"email"]){
            userEmail=valueAsString;
        }
        else if([keyAsString isEqualToString:@"given_name"]){
            firstName=valueAsString;
        }
        else if([keyAsString isEqualToString:@"family_name"]){
            lastName=valueAsString;
        }
        //NSLog(@"key: %@", keyAsString);
        //NSLog(@"value: %@", valueAsString);
    }

    User *newUser=[[User alloc]initWithFirstName:firstName lastName:lastName emailAddress:userEmail];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *encodedUser = [NSKeyedArchiver archivedDataWithRootObject:newUser];
    [defaults setObject:encodedUser forKey:@"current user"];
    
    //Add to user base
    NSData *encodedUserBase = [defaults objectForKey:@"cache"];
    UserBase *base = [NSKeyedUnarchiver unarchiveObjectWithData:encodedUserBase];
    [base addUser:newUser];
    NSData *encodedUserBase2 = [NSKeyedArchiver archivedDataWithRootObject:base];
    [defaults setObject:encodedUserBase2 forKey:@"cache"];
    [defaults synchronize];
    if([[defaults objectForKey:@"post" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
    }
    else if([[defaults objectForKey:@"drive" ] isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"AuthenticationToDriveSegue" sender:self];
    }
    
    //KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
    /*[keychainItem setObject:@"password you are saving" forKey:kSecValueData];
    [keychainItem setObject:@"username you are saving" forKey:kSecAttrAccount];
    NSString *password = [keychainItem objectForKey:kSecValueData];
    NSString *username = [keychainItem objectForKey:kSecAttrAccount];*/
}
- (void)googleAuthentication:(GTMOAuth2Authentication *)auth
               request:(NSMutableURLRequest *)request
     finishedWithError:(NSError *)error {
    if (error != nil) {
        NSLog(@"Error: %@",error);
    } else {
        //[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
}
- (IBAction)emailAuthentication:(UIButton *)sender {
}
@end
