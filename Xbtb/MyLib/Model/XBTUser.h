//
//  User.h
//  Wanyingjinrong
//
//  Created by Jason on 15/11/13.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBTArchive.h"

@interface XBTUser : XBTArchive

//用户名
@property (nonatomic, copy) NSString *userName;
//实名
@property (nonatomic, copy) NSString *realName;
//total1  今日利息
@property (nonatomic, copy) NSString *total1;
//total2  总利息
@property (nonatomic, copy) NSString *total2;
//是否设置交易密码
@property (nonatomic, assign) BOOL payPwd;
/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;
/*
 *  用户后续访问票据
 */
@property (nonatomic, copy) NSString *token;

//
@property (nonatomic, copy) NSString *tPerson;

@property (nonatomic, copy) NSString *bankCardNo;

@property (nonatomic, assign) BOOL isGiveUpLogin;


@end
