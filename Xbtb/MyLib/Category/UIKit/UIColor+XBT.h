//
//  UIColor+XBT.h
//  DMUnits
//
//  Created by 尚往文化 on 17/6/20.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XBT)

/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

@end
