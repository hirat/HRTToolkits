//
//  HomeTableViewController.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/24.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIColor+HRTToolkits.h"
#import "HomeTableViewCell.h"
#import <HexColors.h>
#import <ViewUtils.h>

@interface HomeTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIView *headerBackgroundView;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    [self setupTableView];
}

#pragma mark - 视图初始化

- (void)setupTableView
{
    self.headerView.backgroundColor = [UIColor navigationBarBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIView* backgroundView = [[UIView alloc] initWithFrame: self.tableView.bounds];
    backgroundView.backgroundColor = [UIColor hx_colorWithHexString: @"f3f6f8"];
    self.tableView.backgroundView = backgroundView;
    
    self.headerBackgroundView = [[UIView alloc] initWithFrame: self.headerView.frame];
    self.headerBackgroundView.backgroundColor = [UIColor navigationBarBackgroundColor];
    [self.tableView.backgroundView addSubview: self.headerBackgroundView];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HomeTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = [self tableView: tableView heightForHeaderInSection: section];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset <= 0 && self.headerBackgroundView)
    {
        self.headerBackgroundView.height = -offset;
    }
    
}

@end
