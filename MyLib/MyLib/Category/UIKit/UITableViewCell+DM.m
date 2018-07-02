//
//  UITableViewCell+DM.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/19.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "UITableViewCell+DM.h"
#import "DMDefine.h"

@implementation UITableViewCell (DM)

- (UITableView *)tableView
{
    __kindof UIView *superView = self.superview;
    while (![superView isKindOfClass:[UITableView class]]) {
        superView = [superView superview];
    }
    return superView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //从缓存池中取出cell
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    //缓存池中无数据
    if(cell == nil) {
        cell = kGetViewForXib(NSStringFromClass(self));
    }
    if (cell.reuseIdentifier.length==0) {
        [cell setValue:NSStringFromClass(self) forKey:@"reuseIdentifier"];
    }
    
    return cell;
}

@end
