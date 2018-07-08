//
//  WebImageAutoSizeConst.h
//  DMWebImageAutoSizeExample
//
//  Created by zhuxiaohui on 2017/10/25.
//  Copyright © 2017年 it7090.com. All rights reserved.

#import <UIKit/UIKit.h>

#define DMWebImageAutoSizeDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#ifdef DEBUG
#define DMDebugLog(...) NSLog(__VA_ARGS__)
#else
#define DMDebugLog(...)
#endif

