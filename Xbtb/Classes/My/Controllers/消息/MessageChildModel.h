//
//  MessageChildModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageChildModel : NSObject
//adminId = 15;

//createTime = 1527128201000;
@property (nonatomic, assign) unsigned long long createTime;
//id = 3;
@property (nonatomic, copy) NSString *id;
//imgsrc = "";
//isDelete = 0;
//isSend = 0;
//noticeContent = "\U5c0a\U656c\U7684\U7528\U6237\Uff1a\U4e3a\U5e86\U795d\U5e73\U53f0\U5168\U9762\U5347\U7ea7\U4e0a\U7ebf\Uff0c\U5373\U65e5\U8d77\U5728\U8f66\U5b9d\U91d1\U878dAPP\U6ce8\U518c\U7684\U7528\U6237\U5373\U4eab\U65b0\U624b\U6ce8\U518c3\U91cd\U58d5\U793c\Uff0c\U9664\U4e861208\U5143\U8d85\U5927\U7406\U8d22\U7ea2\U5305\U5916\Uff0c\U8fd8\U6709\U6700\U9ad815%+3%\U65b0\U624b\U4e13\U4eab\U6807\U4e0e\U6700\U9ad810%\U989d\U5916\U52a0\U606f\Uff01\U8be6\U60c5\U8bf7\U53c2\U9605\Uff1a\U65b0\U624b\U8c6a\U793c\U8f66\U5b9d\U91d1\U878d2018\U5e745\U670824\U65e5";
@property (nonatomic, copy) NSString *noticeContent;
//noticeTitle = "\U65b0\U624b\U6ce8\U518c3\U91cd\U58d5\U793c\Uff0c1208\U5143\U7ea2\U5305\U4e0e\U8d85\U9ad8\U52a0\U606f\U7b49\U4f60\U62ff";
@property (nonatomic, copy) NSString *noticeTitle;
//noticetype = 0;
//orderNo = 3;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;


@end
