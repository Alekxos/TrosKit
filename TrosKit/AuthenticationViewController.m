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

#define GoogleClientID    @"888201765523-3ckdo6hmd8qc6n4am6n99j9029l9iro1.apps.googleusercontent.com"
#define GoogleClientSecret @"wSSy7QnRUxATk8SQSt26sAUH"
#define GoogleAuthURL @"https://accounts.google.com/o/oauth2/auth"
#define GoogleTokenURL @"https://accounts.google.com/o/oauth2/token"

#define FacebookClientID @"599056916893893"
#define FacebookClientSecret @"01da67d985fe718849787559569a8efe"
#define FacebookAuthURL @"https://www.facebook.com/dialog/oauth?client_id=599056916893893&redirect_uri=https://www.facebook.com/connect/login_success.html"

NSString *urlEndpoint;
static NSString *const keychainItemName = @"TrosKit OAuth";
NSURL *tokenURL;
NSString * redirectURI;

@interface AuthenticationViewController ()

@end
//Hello!

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    //NEED: Client ID, secret, token URL, redirect URL, endpoint, scope
    //HAVE: Client ID, secret, token URL, redirect URL,
    //urlEndpoint=@"https://www.googleapis.com/oauth2/v2/userinfo";
    redirectURI = @"https://www.facebook.com/connect/login_success.html";
    
    tokenURL=[NSURL URLWithString:FacebookAuthURL];
    
    GTMOAuth2Authentication *auth=[GTMOAuth2Authentication authenticationWithServiceProvider:@"TrosKit" tokenURL:tokenURL redirectURI:redirectURI clientID: FacebookClientID clientSecret:FacebookClientSecret];
    auth.scope=@"email";
    
    GTMOAuth2ViewControllerTouch *viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth authorizationURL:[NSURL URLWithString:FacebookAuthURL] keychainItemName:keychainItemName delegate:self finishedSelector:@selector(viewController:finishedWithFacebookAuth:error:)];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)googleAuthentication:(UIButton *)sender {
    urlEndpoint=@"https://www.googleapis.com/oauth2/v2/userinfo";
    
    tokenURL=[NSURL URLWithString:GoogleTokenURL];
    redirectURI = @"urn:ietf:wg:oauth:2.0:oob";
    
    GTMOAuth2Authentication *auth=[GTMOAuth2Authentication authenticationWithServiceProvider:@"TrosKit" tokenURL:tokenURL redirectURI:redirectURI clientID: GoogleClientID clientSecret:GoogleClientSecret];
    auth.scope=@"https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile";
    
    GTMOAuth2ViewControllerTouch *viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth authorizationURL:[NSURL URLWithString:GoogleAuthURL] keychainItemName:keychainItemName delegate:self finishedSelector:@selector(viewController:finishedWithGoogleAuth:error:)];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
finishedWithFacebookAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self.navigationController popToViewController:self animated:NO];
    NSLog(@"code: %@",auth.code);
    NSLog(@"test AT: %@",auth.accessToken);
    if(!auth.accessToken){
    NSString *authorizationCode=auth.code;
    //NSString *urlString = urlEndpoint;
    NSString *urlString=[NSString stringWithFormat:@"https://graph.facebook.com/oauth/access_token?client_id=%@&redirect_uri=%@&client_secret=%@&code=%@",FacebookClientID,@"https://www.facebook.com/connect/login_success.html",FacebookClientSecret,authorizationCode];
    
    NSURL *url1 = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    /*[request setValue:FacebookClientID forHTTPHeaderField:@"client_id"];
    [request setValue:@"https://www.facebook.com/connect/login_success.html" forHTTPHeaderField:@"redirect_uri"];
    [request setValue:FacebookClientSecret forHTTPHeaderField:@"app_secret"];
    [request setValue:authorizationCode forHTTPHeaderField:@"code"];*/
    
    NSError *error2 = nil;
    NSURLResponse *response1 = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request1
                                         returningResponse:&response1
                                                     error:&error2];
    NSLog(@"%@",data);
    
    
    NSString *decoded=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"decoded: %@",decoded);
    int expireLocation=(int)[decoded rangeOfString:@"&expires="].location;
    
    NSRange accessRange=NSMakeRange(@"access_token=".length, decoded.length-@"access_token=".length-(decoded.length-expireLocation));
    
    
    NSString *accessToken=[decoded substringWithRange:accessRange];
    NSRange expirationRange=NSMakeRange(@"access_token=".length+accessToken.length+@"&expires=".length, decoded.length-(@"access_token=".length+accessToken.length+@"&expires=".length));
    NSString *expirationTime=[decoded substringWithRange:expirationRange];
        
    NSLog(@"Access token?: %@",accessToken);
    NSLog(@"Expiration time?: %@",expirationTime);
    auth.accessToken=accessToken;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    auth.expiresIn = [f numberFromString:expirationTime];
    }
    
    
    //"https://graph.facebook.com/me?access_token="
    
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",auth.accessToken]];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2];
    /*[request setValue:FacebookClientID forHTTPHeaderField:@"client_id"];
     [request setValue:@"https://www.facebook.com/connect/login_success.html" forHTTPHeaderField:@"redirect_uri"];
     [request setValue:FacebookClientSecret forHTTPHeaderField:@"app_secret"];
     [request setValue:authorizationCode forHTTPHeaderField:@"code"];*/
    
    NSError *error3 = nil;
    NSURLResponse *response2 = nil;
    NSData *data2 = [NSURLConnection sendSynchronousRequest:request2
                                         returningResponse:&response2
                                                     error:&error3];
    
    
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:&myError];
    
    NSString *userEmail=@"";NSString *userFullName=@"";
    // show all values
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
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    //Hello!
    NSLog(@"Email: %@",userEmail);
    NSLog(@"Full name: %@",userFullName);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject: userEmail forKey:@"User Email"];
    [defaults setObject:userFullName forKey:@"User Full Name"];
    
    [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithGoogleAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    NSLog(@"Access token: %@",auth.accessToken);
    
    [self.navigationController popToViewController:self animated:NO];
    NSLog(@"code: %@",auth.code);
    NSString *urlString = urlEndpoint;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error2 = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error2];
    //NSLog(@"%@",data);
    
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    
    
    NSString *userEmail=@"";NSString *userFullName=@"";
    // show all values
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
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    NSLog(@"Email: %@",userEmail);
    NSLog(@"Full name: %@",userFullName);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject: userEmail forKey:@"User Email"];
    [defaults setObject:userFullName forKey:@"User Full Name"];
    
    [self performSegueWithIdentifier:@"AuthToPostSegue" sender:self];
    
    
    //KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
    
    /*[keychainItem setObject:@"password you are saving" forKey:kSecValueData];
    [keychainItem setObject:@"username you are saving" forKey:kSecAttrAccount];
    
    NSString *password = [keychainItem objectForKey:kSecValueData];
    NSString *username = [keychainItem objectForKey:kSecAttrAccount];*/
}

- (IBAction)emailAuthentication:(UIButton *)sender {
}
@end
