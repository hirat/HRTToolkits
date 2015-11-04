//
//  HRTNavigationController.h
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTNavigationController : UINavigationController

@end

@protocol HRTNavigationDelegate <NSObject>
@optional
- (BOOL)disablePanPopAtPoint:(CGPoint)point;
- (void)navigationControllerTriggeredPop:(HRTNavigationController*)nc;
- (void)navigationControllerWillPop:(HRTNavigationController *)nc;
- (void)navigationControllerDidPop:(HRTNavigationController *)nc;
@required
@end
