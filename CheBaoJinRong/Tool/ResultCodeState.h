//
//  ResultCodeState.h
//  XYG
//
//  Created by 张殿明 on 2017/11/21.
//  Copyright © 2017年 Mac. All rights reserved.
//

#ifndef ResultCodeState_h
#define ResultCodeState_h

typedef NS_ENUM(NSInteger, ResultCodeState) {
    ResultStatusSuccess                   = 0,  ////<成功
    ResultStatusNoData                     = 3,  //数据为空
//        YBResultStatusNotSubordinate            = 180,////<没有下级  没有红包领取
//        YBResultStatusNotRedPackets             = 187,////<红包已经领完
//    YBResultStatusRedPacketsExpired         = 189,////<红包失效
};


#endif /* ResultCodeState_h */
