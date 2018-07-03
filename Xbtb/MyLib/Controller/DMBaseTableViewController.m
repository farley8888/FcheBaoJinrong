//
//  DMBaseTableViewController.m
//  SWWH
//
//  Created by 尚往文化 on 16/7/12.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DMBaseTableViewController.h"
#import "DMTableView.h"

@interface DMBaseTableViewController ()

@end

@implementation DMBaseTableViewController

- (void)setScrollInvalidRect:(CGRect)scrollInvalidRect
{
    _scrollInvalidRect = scrollInvalidRect;
    [self.tableView setValue:[NSValue valueWithCGRect:scrollInvalidRect] forKey:@"scrollInvalidRect"];
}

- (void)loadView
{
    DMTableView *tableView = [[DMTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    tableView.scrollInvalidRect = self.scrollInvalidRect;
    UITableView_AutomaticDimension(tableView, 44);
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


@end
