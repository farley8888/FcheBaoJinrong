//
//  UILabel+DMIconFont.m
//  DMUnits
//
//  Created by 尚往文化 on 17/9/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "UILabel+DMIconFont.h"
#import "DMIconFont.h"

@implementation UILabel (DMIconFont)

- (void)setIconText:(NSString *)iconText fontSize:(NSInteger)fontSize
{
    UIFont *iconfont = [DMIconFont fontWithSize:fontSize];
    self.font = iconfont;
    self.text = iconText;
}

@end
