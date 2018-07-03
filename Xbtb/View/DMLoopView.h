//
//  DMLoopView.h
//  拼图游戏
//
//  Created by 尚往文化 on 17/4/18.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMLoopView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, copy) void(^didClickBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame didClickBlock:(void(^)(NSInteger index))didClickBlock titles:(NSArray<NSString *> *)titles;

@end
