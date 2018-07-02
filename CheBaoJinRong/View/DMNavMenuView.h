//
//  DMNavMenuView.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/4/21.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMNavMenuItem.h"

@interface DMNavMenuView : UIView

@property (nonatomic, copy) void(^itemClickBlock)(NSInteger index);
@property (nonatomic, copy) void(^setClickBlock)();

@property (nonatomic, strong) NSArray<DMNavMenuItem *> *items;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSDictionary *orderDict;
@property (nonatomic, strong) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<DMNavMenuItem *> *)items;

@end
