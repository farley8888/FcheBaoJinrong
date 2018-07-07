//
//  DMRecordChildModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTRecordChildModel : NSObject
//borrowId = 0;
//id = 13;
//investTime = 1527598675000;
@property (nonatomic, assign) unsigned long long investTime;
//investmoney = 200;
@property (nonatomic, assign) CGFloat investmoney;
//locktime = 1;
//type = 1;
//userId = 2;

//applyStatus = 1;   赎回状态
@property (nonatomic, assign) NSInteger applyStatus;
@property (nonatomic, copy) NSString *applyStatusString;
//createTime = 1527649039000;
@property (nonatomic, assign) unsigned long long createTime;
//id = 1;
//shmoney = 10;
@property (nonatomic, assign) CGFloat shmoney;
//userId = 2;

@end
