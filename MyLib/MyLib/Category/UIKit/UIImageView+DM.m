//
//  UIImageView+DM.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#define isImportSDWebImage 0 //是否导入了SDWebImage框架

#import "UIImageView+DM.h"

#if isImportSDWebImage
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#endif


@implementation UIImageView (DM)

- (void)DM_setImage:(id)image
{
    if ([image isKindOfClass:[NSString class]]) {
#if isImportSDWebImage
            [self sd_setImageWithURL:[NSURL URLWithString:[image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
#endif
    } else if ([image isKindOfClass:[UIImage class]]) {
        self.image = image;
    } else if ([image isKindOfClass:[NSData class]]) {
        self.image = [UIImage imageWithData:image];
    }
}

@end

@implementation UIButton (DM)

- (void)DM_setImage:(id)image forState:(UIControlState)state
{
    if ([image isKindOfClass:[NSString class]]) {
#if isImportSDWebImage
        [self sd_setImageWithURL:[NSURL URLWithString:[image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] forState:state];
#endif
    } else if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:state];
    } else if ([image isKindOfClass:[NSData class]]) {
        [self setImage:[UIImage imageWithData:image] forState:state];
    }
}

@end
