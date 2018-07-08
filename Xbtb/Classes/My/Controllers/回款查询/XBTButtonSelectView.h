//
//  XBTButtonSelectView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTButtonSelectView : UIView

+ (XBTButtonSelectView  *)buttonselectView;

@property(nonatomic,copy)void(^buttonClick)(NSInteger tag);

@property (nonatomic, assign) NSInteger selectIndex;

@end
