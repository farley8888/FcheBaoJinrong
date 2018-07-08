//
//  LotOfViewScrollerTopView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotOfViewScrollerTopView : UIView

@property (nonatomic, strong) NSArray *titleArr;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy) void(^buttonClickBlock)(NSInteger tag);

@property (nonatomic, assign) NSInteger selectIndex;

@end
