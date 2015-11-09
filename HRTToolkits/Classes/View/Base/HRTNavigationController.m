//
//  HRTNavigationController.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "HRTNavigationController.h"
#import "InitialViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIColor+HRTToolkits.h"
#import "UIImage+HRTToolkits.h"
#import <HRTCategorys.h>
#import <ViewUtils.h>

@interface HRTNavigationController () <UINavigationControllerDelegate>
@end

@implementation HRTNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] == 1)
    {
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
    else
    {
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] == 1)
    {
        viewController.navigationItem.leftBarButtonItem = [self menuBarButtonItem];
    }
    else if ([self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    }
}

#pragma mark - 自定义函数

- (UIBarButtonItem*)menuBarButtonItem
{
    UIImage* image = [UIImage menuButtonItemImage];
    UIImage* imageNormal= [image imageWithTintColor: [UIColor navigationBarButtonItemColor]];
    UIImage* imegeSelected = [image imageWithTintColor: [UIColor navigationBarButtonItemSelectedColor]];
    
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage: imageNormal forState: UIControlStateNormal];
    [button setImage: imegeSelected forState: UIControlStateHighlighted];
    [button addTarget: self action: @selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView: button];
    return someBarButtonItem;
}

- (IBAction)showMenu:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

@end
