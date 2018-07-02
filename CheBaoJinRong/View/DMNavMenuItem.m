//
//  DMNavMenuItem.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/4/21.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "DMNavMenuItem.h"

@implementation DMNavMenuItem

+ (instancetype)itemWithTitle:(NSString *)title type:(DMNavMenuItemType)type cls:(Class)cls
{
    DMNavMenuItem *item = [[DMNavMenuItem alloc] init];
    item.title = title;
    item.type = type;
    item.cls = NSStringFromClass(cls);
    return item;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _width = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}].width+30;
}

@end
