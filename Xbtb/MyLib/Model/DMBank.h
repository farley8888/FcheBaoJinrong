//
//  DMBank.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/13.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMBank : NSObject

//"code":"ABC",
@property (nonatomic, copy) NSString *code;
//"name":"中国农业银行",//银行卡名称
@property (nonatomic, copy) NSString *name;
//"num":"1002"// 银行卡编号
@property (nonatomic, copy) NSString *num;

@end
