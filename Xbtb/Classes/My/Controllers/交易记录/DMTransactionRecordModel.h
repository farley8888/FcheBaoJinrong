//
//  DMTransactionRecordModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMTransactionRecordModel : NSObject

//createTime = 1526884107000;
@property (nonatomic, assign) unsigned long long createTime;
//frozenAmount = 150;
/**  冻结金额  **/
//@property (nonatomic, assign) CGFloat frozenAmount;
//fundMode = "\U6295\U8d44\U51bb\U7ed3";
/**  基金类型、模式  **/
@property (nonatomic, copy) NSString *fundMode;
//fundType = 6;
//@property (nonatomic, assign) NSInteger fundType;
//id = 65;
//inAmount = 0;
//operAmount = 50;
@property (nonatomic, assign) CGFloat operAmount;
//operType = 2;
/**  加减  1、3+  2、4-  **/
@property (nonatomic, assign) NSInteger operType;
//outAmount = 50;
//remarks = "\U6295\U8d44\U4e86\U9879\U76ee[ test006]\Uff0c\U51bb\U7ed3\U6295\U8d44\U91d1\U989d\U4e3a50.00\U5143\U3002";
//usableAmount = "27850.05";
/** 余额  **/
@property (nonatomic, assign) CGFloat usableAmount;
//userId = 4;

@end
