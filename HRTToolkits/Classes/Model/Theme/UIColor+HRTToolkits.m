//
//  UIColor+HRTToolkits.m
//  HRTToolkits
//
//  Created by Hirat on 15/4/18.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "UIColor+HRTToolkits.h"
#import <HexColors.h>

@implementation UIColor (HRTToolkits)

+ (UIColor*)navigationBarBackgroundColor
{
    return [UIColor hx_colorWithHexString: @"19CAAD"];
}

+ (UIColor*)navigationBarButtonItemColor
{
    return [UIColor whiteColor];
}

+ (UIColor*)navigationBarButtonItemSelectedColor
{
    return [UIColor lightGrayColor];
}


@end
