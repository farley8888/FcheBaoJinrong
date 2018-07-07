//
//  DMLoanMateriaModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTLoanMateriaModel : NSObject
//attrName = "\U8f66\U8f86\U56fe\U72473";
@property (nonatomic, copy) NSString *attrName;
//attrPath = "upload/images/borrow/20180525/c201805253.jpg";
@property (nonatomic, copy) NSString *attrPath;

@property (nonatomic, assign) CGFloat image_w;
@property (nonatomic, assign) CGFloat image_h;

//attrType = 1;
//borrowId = 1;
//createTime = 1527219705000;
//id = 7;
@end
