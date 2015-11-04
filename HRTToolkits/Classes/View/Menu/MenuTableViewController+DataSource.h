//
//  MenuTableViewController+DataSource.h
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "MenuTableViewController.h"

extern const struct HRTToolkitDataKeys
{
    __unsafe_unretained NSString* name;
    __unsafe_unretained NSString* class;
    __unsafe_unretained NSString* describe;
} HRTToolkitDataKeys;

@interface MenuTableViewController (DataSource)

- (NSArray*)sections;
- (NSArray*)itemsInSection:(NSInteger)section;

@end
