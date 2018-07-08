//
//  UIImage+XBTIconFont.h
//  Iconfont封装
//
//  Created by 尚往文化 on 17/2/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTIconInfo.h"

@interface UIImage (XBTIconFont)

+ (UIImage *)imageWithInfo:(XBTIconInfo *)inFfo;
+ (UIImage *)imageWithText:(NSString *)text color:(UIColor *)color size:(CGSize)size;
@end
