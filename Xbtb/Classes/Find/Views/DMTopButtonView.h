//
//  DMTopButtonView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTopButtonView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic, copy) void(^buttonClick)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;

@end
