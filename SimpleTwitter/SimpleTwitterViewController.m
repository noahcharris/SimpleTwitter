//
//  SimpleTwitterViewController.m
//  SimpleTwitter
//
//  Created by Noah Harris on 2/18/14.
//  Copyright (c) 2014 Noah Harris. All rights reserved.
//

#import "SimpleTwitterViewController.h"

@interface SimpleTwitterViewController ()

@end

@implementation SimpleTwitterViewController

@synthesize dataSource;
@synthesize tweetTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshButton addTarget:self action:@selector(refreshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendButtonClick:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Initial Tweet Text!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    

}

- (void)refreshButtonClick:(id)sender
{
    [self getTweets];
}




- (void)getTweets {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"10" forKey:@"count"];
                 
                 SLRequest *request = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 [request setAccount:twitterAccount];
                 
                 
                 
                 [request performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      
                      NSLog(@"%d", urlResponse.statusCode);
                      self.dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                      
                      
                      
                      if (self.dataSource.count != 0) {
                          NSLog(@"Count is not 1!!!");
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self.tweetTable reloadData];
                          });
                      }
                  }];
             }
         } else {
             // Handle failure to get account access
             NSLog(@"Error receiveing tweets...");
         }
     }];
}




#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"HEYO");
    NSLog(@"%d", dataSource.count);
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tweetTable
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tweet = self.dataSource[[indexPath row]];
    
    cell.textLabel.text = tweet[@"text"];
    return cell;
}


@end
