//
//  UIImageView+XBT.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/14.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XBT)

- (void)DM_setImage:(id)image;

@end

@interface UIButton (DM)

- (void)DM_setImage:(id)image forState:(UIControlState)state;

@end
