//
//  UIImage+DM.h
//  DMUnits
//
//  Created by 尚往文化 on 17/6/20.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DM)

- (UIImage *)barrageImageScaleToSize:(CGSize)size;

- (UIImage *)barrageImageScaleToMaxSize:(CGSize)size;

//给我一种颜色，一个尺寸，我给你返回一个UIImage:不透明
+(UIImage *)imageWithColor:(UIColor *)color;
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

/*
 *  圆形图片
 */
@property (nonatomic,strong,readonly) UIImage *roundImage;
/**
 *  从给定UIView中截图：UIView转UIImage
 */
+(UIImage *)cutFromView:(UIView *)view;
/**
 *  直接截屏
 */
+(UIImage *)cutScreen;
/**
 *  从给定UIImage和指定Frame截图：
 */
-(UIImage *)cutWithFrame:(CGRect)frame;

@end
