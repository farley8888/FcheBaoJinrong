//
//  DMHomeHeardView.h
//  CheBaoJinRong
//
//  Created by ltyj on 2017/12/7.
//  Copyright © 2017年 ltyj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMHomePageModel.h"

@interface DMHomeHeardView : UIView

@property (nonatomic, copy) void (^homeButtonClickBlock)(NSInteger tag);
@property (nonatomic, copy) void (^banerClickBlock)(NSInteger index);
@property (nonatomic, copy) void (^loopViewBlock)();

+ (DMHomeHeardView *)homeHeardView;

/**
 *  图片数组
 */
//@property (nonatomic, strong) NSMutableArray<Banners *> *imageArray;
@property (nonatomic, strong) NSArray<Banners *> *imageArray;
@property (nonatomic, strong) NSArray<Data4*> *loopViewArray;

@end
