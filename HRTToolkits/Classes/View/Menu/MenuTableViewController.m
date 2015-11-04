//
//  MenuTableViewController.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/24.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuTableViewCell.h"
#import <HexColors.h>
#import <ViewUtils.h>
#import "MenuTableViewController+DataSource.h"
#import "UIViewController+MMDrawerController.h"

#import <HRTAppModule.h>

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString: @"000000"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    CGFloat height = [self itemsInSection: 0].count * 50;
    UIView* headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.tableView.width, self.tableView.height - height - 20)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.scrollEnabled = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* menuItems = [self itemsInSection:section];
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MenuTableViewCell" forIndexPath:indexPath];
    NSDictionary* info = [[self itemsInSection: indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = info[HRTToolkitDataKeys.name];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];

    [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
        
    }];    
    
    NSDictionary* info = [[self itemsInSection: indexPath.section] objectAtIndex:indexPath.row];
    NSString* toolkitClassString = info[HRTToolkitDataKeys.class];
    Class toolkitClass = NSClassFromString(toolkitClassString);
    if (toolkitClass)
    {
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        if ([toolkitClass conformsToProtocol: @protocol(HRTAppModule)])
        {
            id<HRTAppModule> appModel  = [toolkitClass performSelector:@selector(sharedInstance)];
            
            appModel.navigationController = nav;
            [nav pushViewController: appModel.rootViewController animated: YES];
        }
        else
        {
            UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier: toolkitClassString];
            [nav pushViewController: vc animated: YES];
        }
    }

}

@end
