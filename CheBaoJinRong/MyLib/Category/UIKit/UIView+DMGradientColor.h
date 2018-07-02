//
//  UIView+DMGradientColor.h
//  XYG
//
//  Created by ltyj on 2017/12/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DMGradientColor)

/*
 * 渐变色
 *  transverse ：是否为横向渐变
 *  vertical：是否为竖向渐变
 *  strColor： 开始颜色
 *  endColor： 结束颜色
 */

- (void)gradientColorTransverse:(BOOL)transverse vertical:(BOOL)vertical width:(CGFloat)width stratColor:(UIColor *)strColor endColor:(UIColor *)endColor;

@end
