//
//  UILabel+XBTIconFont.m
//  DMUnits
//
//  Created by 尚往文化 on 17/9/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "UILabel+XBTIconFont.h"
#import "XBTIconFont.h"

@implementation UILabel (XBTIconFont)

- (void)setIconText:(NSString *)iconText fontSize:(NSInteger)fontSize
{
    UIFont *iconfont = [XBTIconFont fontWithSize:fontSize];
    self.font = iconfont;
    self.text = iconText;
}

@end
