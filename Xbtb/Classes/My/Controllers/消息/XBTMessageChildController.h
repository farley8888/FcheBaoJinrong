//
//  DMMessageChildController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTBaseTableViewController.h"

@interface XBTMessageChildController : XBTBaseTableViewController


@property (nonatomic, assign) BOOL isLoadData;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger type;//1：平台公告  2：媒体报道
//@property (nonatomic, assign) NSInteger fatherType; //1.我的跳转进入  2.首页跳转进入

- (void)loadData;

@end
