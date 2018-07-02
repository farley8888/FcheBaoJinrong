//
//  DMLeftTabView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OnGoingOrFinish) {
    
    OnGing,
    Finish
};

@interface DMLeftView : UIView

@property (nonatomic, assign) BOOL isLoadData;
@property (nonatomic, assign) OnGoingOrFinish type;

- (void)loadData;
-(instancetype)initWithFrame:(CGRect)frame;

@end
