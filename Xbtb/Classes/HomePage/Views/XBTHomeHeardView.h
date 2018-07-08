//
//  XBTHomeHeardView.h
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"

@interface XBTHomeHeardView : UIView

@property (nonatomic, copy) void (^homeButtonClickBlock)(NSInteger tag);
@property (nonatomic, copy) void (^banerClickBlock)(NSInteger index);
@property (nonatomic, copy) void (^loopViewBlock)();

+ (XBTHomeHeardView *)homeHeardView;

/**
 *  图片数组
 */
//@property (nonatomic, strong) NSMutableArray<Banners *> *imageArray;
@property (nonatomic, strong) NSArray<Banners *> *imageArray;
@property (nonatomic, strong) NSArray<Data4*> *loopViewArray;

@end
