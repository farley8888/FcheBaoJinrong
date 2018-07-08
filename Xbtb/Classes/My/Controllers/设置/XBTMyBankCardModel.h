//
//  XBTMyBankCardModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTMyBankCardModel : NSObject

//bankCardNo = 6217885840061085383;
/**  银行卡号  **/
@property (nonatomic, copy) NSString *bankCardNo;
//bankCode = 0801040000;
/**  银行code  **/
@property (nonatomic, copy) NSString *bankCode;
//bankName = "\U4e2d\U56fd\U94f6\U884c";
/**  银行名称  **/
@property (nonatomic, copy) NSString *bankName;
//cardStatus = 2;
//createTime = 1526556020000;
//id = 2;
//realName = "\U8c22\U8d35";
/**  开户名  **/
@property (nonatomic, copy) NSString *realName;
//userId = 4;


@end
