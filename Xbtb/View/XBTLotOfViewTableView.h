//
//  DMLotOfViewTableView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTLotOfViewTableView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadData;

@property (nonatomic, assign) BOOL isLoadData;
@property (nonatomic, assign) NSInteger type;

@end
