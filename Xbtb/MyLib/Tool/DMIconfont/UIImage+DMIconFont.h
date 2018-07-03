//
//  UIImage+DMIconFont.h
//  Iconfont封装
//
//  Created by 尚往文化 on 17/2/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMIconInfo.h"

@interface UIImage (DMIconFont)

+ (UIImage *)imageWithInfo:(DMIconInfo *)inFfo;
+ (UIImage *)imageWithText:(NSString *)text color:(UIColor *)color size:(CGSize)size;
@end
