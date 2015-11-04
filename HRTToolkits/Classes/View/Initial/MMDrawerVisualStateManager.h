//
//  MMDrawerVisualStateManager.h
//  HRTToolkits
//
//  Created by Hirat on 15/1/10.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDrawerVisualState.h"

typedef NS_ENUM(NSInteger, MMDrawerAnimationType){
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlide,
    MMDrawerAnimationTypeSlideAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};

@interface MMDrawerVisualStateManager : NSObject

@property (nonatomic,assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic,assign) MMDrawerAnimationType rightDrawerAnimationType;

+ (MMDrawerVisualStateManager *)sharedManager;

-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;

@end
