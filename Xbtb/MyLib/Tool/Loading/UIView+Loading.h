//
//  UIView+Loading.h
//  SWWH
//
//  Created by 尚往文化 on 16/8/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTLoadingView.h"
#import "XBTNotDataView.h"
#import "XBTNetErrorView.h"

@interface UIView (Loading)

//正在加载
- (void)loading:(CGRect)frame;
- (void)notData:(CGRect)frame;
- (void)netError:(CGRect)frame againBlock:(void(^)())againBlock;


- (void)stop;



@end
