//
//  DMVCTool.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/8.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DMVCTool : NSObject

+ (UIViewController *)getVCForView:(UIView *)view;
+ (UIViewController *)getCurrentVC;

@end
