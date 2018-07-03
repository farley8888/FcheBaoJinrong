//
//  UIView+DMGradientColor.m
//  XYG
//
//  Created by ltyj on 2017/12/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+DMGradientColor.h"

@implementation UIView (DMGradientColor)

- (void)gradientColorTransverse:(BOOL)transverse vertical:(BOOL)vertical width:(CGFloat)width
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)KColorFromRGB(0xe7375b).CGColor, (id)KColorFromRGB(0xf43459).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(transverse, vertical);
    if (width == 0) {
       gradientLayer.frame = CGRectMake(0, 0, kScreenW, self.height);
    }else{
        gradientLayer.frame = CGRectMake(0, 0, width, self.height);
    }
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
