//
//  HRTThemeManager.h
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+HRTToolkits.h"

typedef NS_ENUM(NSInteger, HRTThemeStyle) {
    HRTThemeStyleLight,  //白天主题
    HRTThemeStyleNight   //夜晚主题
};

@interface HRTThemeManager : NSObject

@property (nonatomic) HRTThemeStyle theme;

+ (instancetype)sharedInstance;


@end
