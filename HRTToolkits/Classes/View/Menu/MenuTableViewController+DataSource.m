//
//  MenuTableViewController+DataSource.m
//  HRTToolkits
//
//  Created by Hirat on 15/1/11.
//  Copyright (c) 2015年 Hirat. All rights reserved.
//

#import "MenuTableViewController+DataSource.h"

const struct HRTToolkitDataKeys HRTToolkitDataKeys =
{
    .name       = @"name",
    .class      = @"class",
    .describe   = @"describe"
};

@implementation MenuTableViewController (DataSource)

- (NSArray*)sections
{
    NSArray* sections = @[@"Menu"];
    return sections;
}

- (NSArray*)itemsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            NSDictionary* font = @{HRTToolkitDataKeys.name: @"字体小工具",
                                    HRTToolkitDataKeys.class: @"HRTFontToolkit"};
            NSDictionary* more = @{HRTToolkitDataKeys.name: @"更多",
                                   HRTToolkitDataKeys.class: @"MoreTableViewController"};
            
            NSArray* items = @[
                               font,
                               more
                               ];
            return items;            
        }
            
        default:
        {
            return Nil;
        }
    }
    
}

@end
