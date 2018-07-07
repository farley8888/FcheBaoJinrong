//
//  DMIconFont.h
//  Iconfont封装
//
//  Created by 尚往文化 on 17/2/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTIconInfo.h"

#define DMIconInfoMake(text, imageSize, imageColor) [XBTIconInfo iconInfoWithText:text size:imageSize color:imageColor]

@interface DMIconFont : NSObject


/**
 创建字体

 @param size 字体大小
 */
+ (UIFont *)fontWithSize: (CGFloat)size;


/**
 设置字体名称

 @param fontName 字体名称
 */
+ (void)setFontName:(NSString *)fontName;

@end
