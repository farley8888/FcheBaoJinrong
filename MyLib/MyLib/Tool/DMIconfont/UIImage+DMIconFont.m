//
//  UIImage+DMIconFont.m
//  Iconfont封装
//
//  Created by 尚往文化 on 17/2/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "UIImage+DMIconFont.h"
#import "DMIconFont.h"

@implementation UIImage (DMIconFont)

+ (UIImage *)imageWithText:(NSString *)text color:(UIColor *)color size:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIFont *font = [DMIconFont fontWithSize:size.width*scale];
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scale, size.height*scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        [text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, color.CGColor);
        [text drawAtPoint:CGPointMake(0, 0) withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}

@end
