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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendButtonClick:(id)sender
{
    NSLog(@"hi!!!");
    NSLog(self.textField.text);
}


#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tweetTable
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    
    cell.textLabel.text = tweet[@"text"];
    return cell;
}


@end
