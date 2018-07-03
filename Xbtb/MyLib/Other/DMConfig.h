//
//  DMConfig.h
//  DMUnits
//
//  Created by 尚往文化 on 17/6/20.
//  Copyright © 2017年 DMing. All rights reserved.
//
#import "DMDefine.h"

#ifndef DMConfig_h
#define DMConfig_h

#import "UserManager.h"

#define kCustomer_Service_Phone @"400-8555-603" //客服电话
#define kLimit @(10)//每一页的数据


#define kAPPID @"1153938790"

#if 0 //0表示测试环境 1表示正式环境
#define kAPI_URL @"http://consumerapi.jufengyigo.com/"  //外网接口
#define kHTML_URL @"http://xwfstatic.jufengyigo.com/"  //html WAP页面
#else
#define kAPI_URL @"http://cs2.xhact.xyz/"   //接口
//#define kAPI_URL @"http://192.168.1.23:8080/"   //接口
#define kHTML_URL @"http://xwfstatic.xhact.com/"   //html  wap页面
#endif


#define kShareImageURL [UIImage imageNamed:@"share"]
#define kMorentouxiang [UIImage imageNamed:@"toux"]
#define kMorentupian [UIImage imageNamed:@"morentupian"]
#define kBlueColor kColor(66, 89, 134)
#define kRedColor kColor(252, 80, 52)

//app配置
//主题颜色
#define kMenuColor ([UserManager sharedManager].user.type==0?kColor(242, 73, 104):kColor(175, 149, 103))
#define kBlackColor kColor(25, 25, 25)

#define kGreenColor kColor(60, 167, 38)


#endif /* DMConfig_h */
