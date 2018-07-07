//
//  DMSubstitutePaymentView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTSubstitutePaymentView : UIView

-(instancetype)initWithFrame:(CGRect)frame;
- (void)loadData;

@property (nonatomic, assign) NSInteger type; //1：待收款  2：已收款
@property (nonatomic, assign) BOOL isLoadData;  //是否已经加载数据



@end
