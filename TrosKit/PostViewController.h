//
//  PostViewController.h
//  TrosKit
//
//  Created by Alex Boulton on 2/9/15.
//  Copyright (c) 2015 Alex Boulton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITableView *postTableView;
- (IBAction)signOut:(UIBarButtonItem *)sender;

@end
