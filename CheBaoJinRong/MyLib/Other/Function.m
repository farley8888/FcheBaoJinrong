//
//  Function.m
//  SWWH
//
//  Created by cy on 16/7/1.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "Function.h"


void UITableView_RegisterFormNib(UITableView *tableView, NSString *nibName)
{
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

void UITableView_RegisterFormClass(UITableView *tableView, NSString *className)
{
    [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

void UITableView_AutomaticDimension(UITableView *tableView, CGFloat estimatedRowHeight)
{
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = estimatedRowHeight;
}

__kindof UITableViewCell* UITableView_GetCell(UITableView *tableView, NSInteger section, NSInteger row)
{
    return [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

__kindof UIView * NSBundle_GetView(NSString *nibName)
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

NSString * NSStringFormatPCA(NSString *province, NSString *city, NSString *area)
{
    NSMutableString *mStr = [NSMutableString string];
    if (province.length) {
        [mStr appendString:province];
    }
    if (city.length) {
        [mStr appendString:city];
    }
    if (area.length) {
        [mStr appendString:area];
    }
    return mStr;
    
}

void DM_Call_Customer_Service_Phone()
{
     [[UIAlertView alertWithTitle:nil message:[NSString stringWithFormat:@"是否拨打客服电话%@", kCustomer_Service_Phone] buttonIndex:^(NSInteger index) {
          if (index == 1) {
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", kCustomer_Service_Phone]]];
          }
     } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"] show];
}

UIButton * DM_CreateBtn(CGRect frame, NSString *title, UIColor *bgColor)
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = bgColor;
    return btn;
}
