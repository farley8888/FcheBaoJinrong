//
//  DMLogOutView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMLogOutView : UIView

@property (nonatomic, copy) void(^logoutBlock)();

+ (DMLogOutView *)logoutView;

@end
