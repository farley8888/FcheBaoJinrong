//
//  CycleScrollView.h
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IndexChange)(NSInteger index);

UIKIT_EXTERN NSString *const TimerRestartNotification;

@interface XBTCycleScrollView : UIScrollView

@property (nonatomic) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *images;

/**
 *  记录是不是由pageCtl点击的
 */
@property (nonatomic, assign) BOOL flag;

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images andCurrentIndex:(NSInteger)index andIndexChange:(IndexChange)block;

- (void)configImages;

- (NSInteger)beyondBoundWithIndex:(NSInteger)index;

@end
