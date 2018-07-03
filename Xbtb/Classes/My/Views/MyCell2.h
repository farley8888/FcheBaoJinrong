//
//  YSMyCell2.h
//  XHGY_merchant
//
//  Created by 张殿明 on 17/7/26.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell2 : UITableViewCell
@property (nonatomic, strong) NSArray<NSDictionary *> *cellArray;
@property (nonatomic, copy) void(^cellHomeButtonClick)(NSInteger tag);
@property (nonatomic, strong) NSDictionary *orderNumber;
@end
