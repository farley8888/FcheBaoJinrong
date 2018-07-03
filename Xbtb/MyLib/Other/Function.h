//
//  Function.h
//  SWWH
//
//  Created by cy on 16/7/1.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void UITableView_RegisterFormNib(UITableView *tableView, NSString *nibName);
void UITableView_RegisterFormClass(UITableView *tableView, NSString *className);

void UITableView_AutomaticDimension(UITableView *tableView, CGFloat estimatedRowHeight);


__kindof UITableViewCell* UITableView_GetCell(UITableView *tableView, NSInteger section, NSInteger row);
UIButton* DM_CreateBtn(CGRect frame, NSString *title, UIColor *bgColor);

__kindof UIView * NSBundle_GetView(NSString *nibName);

NSString * NSStringFormatPCA(NSString *province, NSString *city, NSString *area);

void DM_Call_Customer_Service_Phone(void);
