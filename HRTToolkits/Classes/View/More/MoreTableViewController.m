//
//  MoreTableViewController.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/27.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "MoreTableViewController.h"
#import "MoreTableViewCell.h"
#import <VTAcknowledgementsViewController.h>

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"MoreTableViewCell" forIndexPath: indexPath];
    cell.textLabel.text = @"开源组件许可";
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Pods-HRTToolkits-acknowledgements" ofType:@"plist"];
    VTAcknowledgementsViewController *viewController = [[VTAcknowledgementsViewController alloc] initWithAcknowledgementsPlistPath:path];
//    VTAcknowledgementsViewController *viewController = [VTAcknowledgementsViewController acknowledgementsViewController];
    viewController.title = @"开源组件许可";
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
