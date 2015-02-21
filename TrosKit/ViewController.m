//
//  ViewController.m
//  TrosKit
//
//  Created by Alex Boulton on 2/3/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)post:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"true" forKey:@"post"];
    [defaults setObject:@"false" forKey:@"drive"];
}

- (IBAction)drive:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"true" forKey:@"drive"];
    [defaults setObject:@"false" forKey:@"post"];
}

@end
