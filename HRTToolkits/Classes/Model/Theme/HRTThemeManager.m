//
//  HRTThemeManager.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "HRTThemeManager.h"
#import <UIKit/UIKit.h>
#import "HRTNavigationController.h"
#import "AppDelegate.h"
#import <HexColors.h>
#import "UIColor+Hirat.h"

@implementation HRTThemeManager

+ (void)load
{
    [HRTThemeManager sharedInstance].theme = HRTThemeStyleLight;
}

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)setTheme:(HRTThemeStyle)theme
{
    _theme = theme;
    
    [self updateNavigationBarWithTheme: theme];
}

- (void)updateNavigationBarWithTheme:(HRTThemeStyle)theme
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    switch (theme)
    {
        case HRTThemeStyleLight:
        {
            NSMutableArray* navArray = [NSMutableArray array];
            
            NSArray* classNameArray = @[@"HomeNavigationController",
                                        ];
            [classNameArray enumerateObjectsUsingBlock:^(NSString* className, NSUInteger idx, BOOL *stop) {
                
                Class class = NSClassFromString(className);
                if (class && [class isSubclassOfClass: [HRTNavigationController class]])
                {
                    [navArray addObject: class];
                }
                
            }];
            
            NSDictionary* titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                                 [UIFont systemFontOfSize: 20], NSFontAttributeName,
                                                 nil];
            
            UIImage* backgroundImage = [[UIColor navigationBarBackgroundColor] image];
            UIImage* shadowImgae = [[UIColor navigationBarBackgroundColor] imageWithSize: CGSizeMake(1, 1)];
            [navArray enumerateObjectsUsingBlock:^(Class class, NSUInteger idx, BOOL *stop) {
                [UINavigationBar appearanceWhenContainedIn: class, nil].titleTextAttributes = titleTextAttributes;
                [[UINavigationBar appearanceWhenContainedIn: class, nil] setBackgroundImage: backgroundImage forBarMetrics: UIBarMetricsDefault];
                [UINavigationBar appearanceWhenContainedIn: class, nil].tintColor = [UIColor whiteColor];
                [UINavigationBar appearanceWhenContainedIn: class, nil].shadowImage = shadowImgae;
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
