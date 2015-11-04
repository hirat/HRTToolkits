//
//  InitialViewController.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/24.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "InitialViewController.h"
#import "MMDrawerVisualStateManager.h"

@interface MMDrawerControllerSegue : UIStoryboardSegue
@end

@implementation MMDrawerControllerSegue
-(void)perform
{
    NSAssert( [self.sourceViewController isKindOfClass: [MMDrawerController class]], @"MMDrawerControllerSegue only to be used to define left/center/right controllers for a MMDrawerController!");
}
@end


@interface InitialViewController ()

@end

@implementation InitialViewController

-(void)awakeFromNib
{
    if (self.storyboard)
    {
        [self performSegueWithIdentifier: @"mm_home" sender: self];
        [self performSegueWithIdentifier: @"mm_menu" sender: self];
    }
}

- (void)loadView
{
    [super loadView];
    [self setup];
}

- (void)setup
{
    CGFloat width = self.view.frame.size.width;
    self.maximumLeftDrawerWidth = width - 60;
    self.maximumRightDrawerWidth = 160;
    
    self.showsShadow = NO;
    
    [self setStatusBarViewBackgroundColor:[UIColor clearColor]];
    [self setOpenDrawerGestureModeMask: MMOpenDrawerGestureModePanningNavigationBar];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block = [[MMDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide: drawerSide];
        if(block)
        {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"mm_menu"] )
    {
        NSParameterAssert( [segue isKindOfClass: [MMDrawerControllerSegue class]]);
        [self setLeftDrawerViewController: segue.destinationViewController];
    }
    else
    {
        NSParameterAssert( [segue isKindOfClass: [MMDrawerControllerSegue class]]);
        [self setCenterViewController: segue.destinationViewController
                   withCloseAnimation:YES
                           completion:nil];
    }
}

@end

