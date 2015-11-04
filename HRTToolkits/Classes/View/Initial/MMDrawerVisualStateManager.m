//
//  MMDrawerVisualStateManager.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/10.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "MMDrawerVisualStateManager.h"
#import <QuartzCore/QuartzCore.h>

@interface MMDrawerVisualStateManager ()
@property (nonatomic) CGFloat parallaxFactor;
@end

@implementation MMDrawerVisualStateManager

+ (MMDrawerVisualStateManager *)sharedManager {
    static MMDrawerVisualStateManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MMDrawerVisualStateManager alloc] init];
        [_sharedManager setLeftDrawerAnimationType: MMDrawerAnimationTypeNone];
        [_sharedManager setRightDrawerAnimationType: MMDrawerAnimationTypeNone];
    });
    
    return _sharedManager;
}

- (id)init
{
    if(self = [super init])
    {
        self.parallaxFactor = 4.0;
    }
    
    return self;
}

-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide{
    MMDrawerAnimationType animationType;
    if(drawerSide == MMDrawerSideLeft){
        animationType = self.leftDrawerAnimationType;
    }
    else {
        animationType = self.rightDrawerAnimationType;
    }
    
    MMDrawerControllerDrawerVisualStateBlock visualStateBlock = nil;
    switch (animationType) {
        case MMDrawerAnimationTypeSlide:
            visualStateBlock = [MMDrawerVisualState slideVisualStateBlock];
            break;
        case MMDrawerAnimationTypeSlideAndScale:
            visualStateBlock = [MMDrawerVisualState slideAndScaleVisualStateBlock];
            break;
        case MMDrawerAnimationTypeParallax:
            visualStateBlock = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
            break;
        case MMDrawerAnimationTypeSwingingDoor:
            visualStateBlock = [MMDrawerVisualState swingingDoorVisualStateBlock];
            break;
        default:
            visualStateBlock =  ^(MMDrawerController * drawerController, MMDrawerSide drawerSide, CGFloat percentVisible){
                NSParameterAssert(self.parallaxFactor >= 1.0);
                CATransform3D transform = CATransform3DIdentity;
                CATransform3D statusTransform = CATransform3DIdentity;
                UIViewController * sideDrawerViewController;
                if(drawerSide == MMDrawerSideLeft)
                {
                    sideDrawerViewController = drawerController.leftDrawerViewController;
                    CGFloat distance = MAX(drawerController.maximumLeftDrawerWidth,drawerController.visibleLeftDrawerWidth);
                    if (percentVisible <= 1.f)
                    {
                        transform = CATransform3DMakeTranslation((-distance)/self.parallaxFactor+(distance*percentVisible/self.parallaxFactor), 0.0, 0.0);
                        statusTransform = CATransform3DMakeTranslation(percentVisible*distance, 0.0, 0.0);
                    }
                    else
                    {
                        transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
                        transform = CATransform3DTranslate(transform, drawerController.maximumLeftDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
                        statusTransform = CATransform3DMakeTranslation(distance, 0.0, 0.0);
                    }
                }
                else if(drawerSide == MMDrawerSideRight)
                {
                    sideDrawerViewController = drawerController.rightDrawerViewController;
                    CGFloat distance = MAX(drawerController.maximumRightDrawerWidth,drawerController.visibleRightDrawerWidth);
                    if(percentVisible <= 1.f)
                    {
                        transform = CATransform3DMakeTranslation((distance)/self.parallaxFactor-(distance*percentVisible)/self.parallaxFactor, 0.0, 0.0);
                        statusTransform = CATransform3DMakeTranslation(-percentVisible*distance, 0.0, 0.0);
                    }
                    else
                    {
                        transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
                        transform = CATransform3DTranslate(transform, -drawerController.maximumRightDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
                        statusTransform = CATransform3DMakeTranslation(-distance, 0.0, 0.0);
                    }
                }
                
                [sideDrawerViewController.view.layer setTransform:transform];
                
                NSString *key = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9] encoding:NSASCIIStringEncoding];
                id object = [UIApplication sharedApplication];
                UIView *statusBar;
                if ([object respondsToSelector:NSSelectorFromString(key)]) {
                    statusBar = [object valueForKey:key];
                }
                statusBar.layer.transform = statusTransform;
                
            };
            break;
    }
    return visualStateBlock;
}



@end
