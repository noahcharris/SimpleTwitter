//
//  SimpleTwitterViewController.h
//  SimpleTwitter
//
//  Created by Noah Harris on 2/18/14.
//  Copyright (c) 2014 Noah Harris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface SimpleTwitterViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tweetTable;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
-(IBAction)sendButtonClick:(id)sender;

@end
