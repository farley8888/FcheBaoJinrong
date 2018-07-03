//
//  DMAlertView.h
//  HongLiQuan
//
//  Created by 游兵 on 2017/6/17.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBaseAlertView : UIView

@property (nonatomic, copy) void(^didClicked)(NSInteger index);

- (void)show;
- (void)close;
+ (instancetype)alertView;

@end
