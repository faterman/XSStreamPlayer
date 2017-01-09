//
//  XSMainTableViewController.m
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/8.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSMainTableViewController.h"
#import "XSAudioViewController.h"
#import "XSAudioTableViewController.h"

@interface XSMainTableViewController ()

@end

@implementation XSMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"PushToAudioViewController" sender:nil];
    }else {
        [self performSegueWithIdentifier:@"PushToAudioTableViewController" sender:nil];
    }

    
}

@end
