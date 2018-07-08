//
//  UITableViewCell+XBT.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/19.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (DM)

- (UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
