//
//  DMDidiDetialHeadView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegularModel.h"

typedef NS_ENUM(NSInteger,HeadViewType){
    RegularHeadView,
    DidiDetialHeadView
};

@interface XBTDidiDetialHeadView : UIView

@property (nonatomic, assign) HeadViewType type;
@property (nonatomic, assign) CGFloat interestRateNumber;
@property (nonatomic, copy) NSString *minAmout;
@property (nonatomic, assign) NSInteger lateTime;
@property (nonatomic, strong) DMRegularModel *regularModel;
@property (nonatomic, copy) void(^timerStopBlock)();

+(XBTDidiDetialHeadView  *)headView;

@end
