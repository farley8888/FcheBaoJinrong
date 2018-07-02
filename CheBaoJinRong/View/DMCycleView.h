//
//  CycleView.h
//  无限循环图片
//
//  Created by Jason on 15/8/12.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCycleScrollView.h"

@class DMCycleView;

typedef NS_ENUM(NSInteger, DMCycleViewPageControlShowStyle) {
    DMCycleViewPageControlShowStyleCenter = 0,
    DMCycleViewPageControlShowStyleLeft = 1,
    DMCycleViewPageControlShowStyleRight = 2,
    DMCycleViewPageControlShowStyleNone = 3,
    DMCycleViewPageControlShowStyleDefault = DMCycleViewPageControlShowStyleCenter
};

/**
 *  点击循环视图的图片触发的block
 *
 *  @param index 图片索引
 */
typedef void(^DMCycleViewDidSelectForIndex)(NSInteger index);

@protocol DMCycleViewDelegate <NSObject>

@optional
/**
 *  点击循环视图的图片触发 *
 *
 *  @param index     图片索引
 */
- (void)cycleView:(DMCycleView *)cycleView didSelectForIndex:(NSInteger)index;

@end

@interface DMCycleView : UIView

@property (strong, nonatomic, readonly) DMCycleScrollView *scrollView;

@property (nonatomic, assign) DMCycleViewPageControlShowStyle pageControlShowStyle;

@property (nonatomic, assign) NSTimeInterval bannerTimeInterval;
@property (nonatomic, assign) BOOL timerEnable;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) DMCycleViewDidSelectForIndex didSelectForIndex;
@property (nonatomic, assign) id<DMCycleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex;
+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(DMCycleViewDidSelectForIndex)didSelectForIndex;
+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(DMCycleViewDidSelectForIndex)didSelectForIndex;

@end
