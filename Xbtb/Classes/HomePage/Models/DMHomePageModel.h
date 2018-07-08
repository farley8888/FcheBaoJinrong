//
//  DMHomePageModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banners:NSObject
//    "bannerName": "banner",
@property (nonatomic, copy) NSString *bannerName;
//    "bannerType": 1,
//    "createTime": 1418731085000,
//    "id": 1,
//    "imgPath": "upload/images/banner_03.png",
@property (nonatomic, copy) NSString *imgPath;
//    "isDelete": 0,
//    "orderNo": 1,
//    "url": "index.html"
@property (nonatomic, copy) NSString *url;
@end

@interface Data4:NSObject
//    "adminId": 1,
@property (nonatomic, copy) NSString *adminId;
//    "createTime": 1526550457000,
//    "id": 1,
@property (nonatomic, copy) NSString *id;
//    "imgsrc": "",
@property (nonatomic, copy) NSString *imgsrc;
//    "isDelete": 0,
//    "isSend": 0,
//    "noticeContent": "鑫贝通宝全新界面即将隆重登场！",
@property (nonatomic, copy) NSString *noticeContent;
//    "noticeTitle": "鑫贝通宝全新界面即将隆重登场！",
@property (nonatomic, copy) NSString *noticeTitle;
//    "noticetype": 0,
//    "orderNo": 1
@end

@interface Data1:NSObject
//    "annualRate": 10.00, 年利率
@property (nonatomic, assign) CGFloat annualRate;
//    "borrowAmount": 100000.00, 总借款金额
@property (nonatomic, assign)CGFloat borrowAmount;
/**
 * 借款状态（1，申请中，2，初审通过，3，招标中，4，复审中，5，还款中，6，已还款，7，借款失败(初审)，8复审失败，9流标，10，
 * 复审处理中,11 流标或复审不通过处理中）
 **/
@property (nonatomic, assign) NSInteger borrowStatus;
//    "borrowTitle": "测试0001",
@property (nonatomic, copy) NSString *borrowTitle;
//    "borrowType": 1, 借款类型
@property (nonatomic, assign) NSInteger borrowType;
//    "createTime": 1526547832000,
//    "deadline": 30,  期限数量
@property (nonatomic, copy) NSString *deadline;
//    "deadlineType": 1天  2月  ,期限类型
@property (nonatomic, assign) NSInteger deadlineType;
//    "hasBorrowAmount": 100.00,  已借出金额
@property (nonatomic, assign)CGFloat hasBorrowAmount;
//    "id": 1,
@property (nonatomic, copy) NSString *id;
//    "investStartTime": 1526547960000,
@property (nonatomic, assign) unsigned long long investStartTime;
//    "maxInvestAmount": 0.00,  最大出借金额
@property (nonatomic, assign) CGFloat maxInvestAmount;
//    "mayCast": 99900.00,
@property (nonatomic, assign) CGFloat mayCast;
//    "minInvestAmount": 100.00, 最小出借金额
@property (nonatomic, assign) CGFloat minInvestAmount;
//    "progress": 0.001000,  进度
@property (nonatomic, assign) CGFloat progress;
//    "raisingPeriod": 7,
@property (nonatomic, assign) CGFloat raisingPeriod;
//    "remainTime": 0,
/** 还款方式（1，一次性还款，2，为按月付息，到期还本,3等额本息） **/
@property (nonatomic, assign) NSInteger repayType;
@end

@interface DMHomePageModel : NSObject

//"borrowhqll": "7.8", 利率
@property (nonatomic, assign) CGFloat borrowhqll;
//"state": {
//    "info": "取值成功",
//    "status": "0"
//},
@property (nonatomic, strong) XBTStateModel *state;

//"data2" 首页第二个非滴滴宝
@property (nonatomic, strong) NSMutableArray<Data1*> *data2;

//"data4"公告
@property (nonatomic, strong) NSArray<Data4*> *data4;

//"banners":轮播图
@property (nonatomic, strong)NSArray<Banners *> *banners;


@end
