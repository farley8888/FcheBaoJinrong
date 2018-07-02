//
//  DMDindModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List:NSObject
//activityBS = tjyl;
//activityImg = "upload/images/banner/20180521175059.jpg";
@property (nonatomic, copy) NSString *activityImg;
//activityMsg = "\U63a8\U8350\U597d\U53cb\U4eab\U8c6a\U793c\Uff01";
//activityName = "\U63a8\U8350\U6709\U793c";
@property (nonatomic, copy) NSString *activityName;
//activitySrc = "http://www.chebaojr.com/wechat/recommend.html";
//activityType = 0;
//activityWapSrc = "http://www.chebaojr.com/wechat/recommend.html";
@property (nonatomic, copy) NSString *activityWapSrc;
//activityendtime = 1558316460000;
//activitystarttime = 1528076460000;
//createTime = 1528076651000;
//id = 2;
//source = 0;
@end

@interface DMDindModel : NSObject

@property (nonatomic, strong) DMPageModel *page;
@property (nonatomic, strong) DMStateModel *state;
@property (nonatomic, strong) NSMutableArray<List *> *list;

@end
