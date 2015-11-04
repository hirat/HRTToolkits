//
//  UIImage+HRTToolkits.m
//  HRTToolkits
//
//  Created by Hirat on 15/4/18.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "UIImage+HRTToolkits.h"

@implementation UIImage (HRTToolkits)

+ (UIImage*)menuButtonItemImage
{
    static UIImage *drawerButtonImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIGraphicsBeginImageContextWithOptions( CGSizeMake(16, 16), NO, 0 );
        
        //// Color Declarations
        UIColor* fillColor = [UIColor whiteColor];
        
        //// Frames
        CGRect frame = CGRectMake(0, 0, 16, 16);
        
        //// Bottom Bar Drawing
        UIBezierPath* bottomBarPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 16, 1)];
        [fillColor setFill];
        [bottomBarPath fill];
        
        
        //// Middle Bar Drawing
        UIBezierPath* middleBarPath1 = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) * 0.33333 + 0.5), 16*0.8, 1)];
        [fillColor setFill];
        [middleBarPath1 fill];
        
        //// Middle Bar Drawing
        UIBezierPath* middleBarPath2 = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) * 0.66666 + 0.5), 16*0.6, 1)];
        [fillColor setFill];
        [middleBarPath2 fill];
        
        
        //// Top Bar Drawing
        UIBezierPath* topBarPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 1) + 0.5), 16, 1)];
        [fillColor setFill];
        [topBarPath fill];
        
        drawerButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    });
    
    return drawerButtonImage;
}


@end
