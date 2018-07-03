//
//  DMNetErrorView.h
//  SWWH
//
//  Created by 尚往文化 on 16/8/19.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMNetErrorView : UIView

@property (nonatomic, copy) void(^againBlock)();

- (instancetype)initWithFrame:(CGRect)frame againBlock:(void(^)())againBlock;

@end
