//
//  DMBaseTableViewPlainController.m
//  DMUnits
//
//  Created by 尚往文化 on 2017/11/17.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "XBTBaseTableViewPlainController.h"
#import "DMTableView.h"


@interface XBTBaseTableViewPlainController ()

@end

@implementation XBTBaseTableViewPlainController

- (void)loadView
{
    DMTableView *tableView = [[DMTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
    UITableView_AutomaticDimension(tableView, 44);
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

@end
