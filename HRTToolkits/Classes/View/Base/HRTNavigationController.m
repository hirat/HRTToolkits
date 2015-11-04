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

@interface HRTNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *preViewImages;
@property (nonatomic, strong) UIImageView *preViewImageView;
@property (nonatomic, assign) BOOL disablePanPop;
@property (nonatomic, assign) CGPoint beginCenter;
@property (nonatomic, assign) BOOL needAddPanPopGesture;

@property (nonatomic) CGFloat parallaxFactor;
@end

@implementation HRTNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
#if 1
#else
    self.interactivePopGestureRecognizer.delegate = self;
    self.needAddPanPopGesture = YES;
    self.parallaxFactor = 4.0;
#endif
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] == 1)
    {
        [self.mm_drawerController setOpenDrawerGestureModeMask: MMOpenDrawerGestureModeAll];
    }
    else
    {
        [self.mm_drawerController setOpenDrawerGestureModeMask: MMOpenDrawerGestureModeNone];
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


#pragma mark - Pan pop
- (void)setupGestureIfNeed
{
    if (!self.needAddPanPopGesture)
    {
        return;
    }
    
    self.needAddPanPopGesture = NO;
    UIPanGestureRecognizer *panPopGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panPopGesture.delegate = self;
    [self.view addGestureRecognizer:panPopGesture];
    
    _preViewImages = [NSMutableArray array];
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:
        {
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint p = [panGesture translationInView:self.view];
            
            CGFloat viewWidth = self.view.frame.size.width;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            BOOL popTriggered = (p.x + velocityX*0.2) > viewWidth/2.0;
            if (popTriggered)
            {
                UIViewController<HRTNavigationDelegate> *delegate =
                [self.visibleViewController conformsToProtocol:@protocol(HRTNavigationDelegate)] ?
                (UIViewController<HRTNavigationDelegate> *)self.visibleViewController : nil;
                
                if ([delegate respondsToSelector:@selector(navigationControllerTriggeredPop:)])
                {
                    [delegate navigationControllerTriggeredPop:self];
                }
                NSTimeInterval duration = MIN((viewWidth-p.x) / velocityX, 0.2);
                [UIView animateWithDuration:duration animations:^{
                    panGesture.view.center = CGPointMake(self.beginCenter.x + self.view.width, self.beginCenter.y);
                    self.preViewImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, self.view.width/self.parallaxFactor, 0);
                } completion:^(BOOL finished) {
                    panGesture.view.center = self.beginCenter;
                    
                    if ([delegate respondsToSelector:@selector(navigationControllerWillPop:)])
                    {
                        [delegate navigationControllerWillPop:self];
                    }
                    [self popViewControllerAnimated:NO];
                    if ([delegate respondsToSelector:@selector(navigationControllerDidPop:)])
                    {
                        [delegate navigationControllerDidPop:self];
                    }
                    [self.preViewImageView removeFromSuperview];
                    self.preViewImageView = nil;
                }];
            }
            else
            {
                [UIView animateWithDuration:.3 animations:^{
                    panGesture.view.center = self.beginCenter;
                    self.preViewImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                } completion:^(BOOL finished) {
                    [self.preViewImageView removeFromSuperview];
                    self.preViewImageView = nil;
                }];
            }
            
            break;
        }
        case UIGestureRecognizerStateBegan:
        {
            self.beginCenter = panGesture.view.center;
            
            CALayer* shadowLayer = panGesture.view.layer;
            shadowLayer.shadowPath = [[UIBezierPath bezierPathWithRect: panGesture.view.frame] CGPath];
            shadowLayer.shadowColor = [UIColor colorWithWhite: 0 alpha: 0.7].CGColor;
            shadowLayer.shadowOpacity = 0.5;
            shadowLayer.shadowRadius = 2;
            shadowLayer.shadowOffset = CGSizeMake(-1, 1);
            
            self.preViewImageView = [[UIImageView alloc] initWithImage:self.preViewImages.lastObject];
            self.preViewImageView.frame = self.view.frame;
            self.preViewImageView.left = - self.view.width/self.parallaxFactor;
            [self.view.superview insertSubview:self.preViewImageView belowSubview:self.view];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        default:
        {
            CGPoint p = [panGesture translationInView:self.view];
            if (p.x > 0)
            {
                self.preViewImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, p.x / self.parallaxFactor, 0);
                panGesture.view.center = CGPointMake(self.beginCenter.x + p.x, self.beginCenter.y);
            }
            
            break;
        }
    }
}

#pragma mark - Override

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        [self setupGestureIfNeed];
        
        UIImage *image = [self.view viewToImage];
        [self.preViewImages addObject:image];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.preViewImages removeLastObject];
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [self.preViewImages removeAllObjects];
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *array = [super popToViewController:viewController animated:animated];
    [self.preViewImages removeObjectsInRange:NSMakeRange(self.viewControllers.count-1, array.count)];
    return array;
}


@end
