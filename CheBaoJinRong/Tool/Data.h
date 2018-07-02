//
//  Data.h
//  SWWH
//
//  Created by 尚往文化 on 16/7/20.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Fee : NSObject

//"nowstate" : 3,
@property (nonatomic, assign) NSInteger nowstate;
//"type" : 3,
@property (nonatomic, assign) NSInteger type;
//"issupportcombo" : 1,
@property (nonatomic, assign) NSInteger issupportcombo;
//"fee" : 10.0,
@property (nonatomic, assign) CGFloat fee;
//"name" : "优质服务商",
@property (nonatomic, copy) NSString *name;
//"starttime" : null,
@property (nonatomic, assign) unsigned long long starttime;
//"endtime" : null,
@property (nonatomic, assign) unsigned long long endtime;
//"msg" : "优质服务商",
@property (nonatomic, copy) NSString *msg;
//"istrial" : null
@property (nonatomic, assign) NSInteger istrial;


/**
 是否需要登录
 */
@property (nonatomic, assign) BOOL needLogin;


@end


@interface Data : NSObject


//@property (nonatomic, copy) NSString *imTicket;
////limit = 10;
//@property (nonatomic, assign) NSInteger limit;
////msg = "\U64cd\U4f5c\U6210\U529f";
//@property (nonatomic, copy) NSString *msg;
////obj = "<null>";
//@property (nonatomic, strong) id obj;
////page = "<null>";
//@property (nonatomic, assign) NSInteger page;
////result = 1;
//@property (nonatomic, assign) NSInteger result;
////ticket = "<null>";
//@property (nonatomic, copy) NSString *ticket;
////total = "<null>";
//@property (nonatomic, assign) NSInteger total;
////totalPage = "<null>";
//@property (nonatomic, assign) NSInteger totalPage;
//
//@property (nonatomic, copy) NSString *mark;
//
//@property (nonatomic, strong) Fee *fee;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id data;

@property (nonatomic, assign) NSInteger code;


@end
