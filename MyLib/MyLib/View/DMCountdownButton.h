//
//  DMCountdownButton.h
//  DMCountdownButton
//
//  Created by 尚往文化 on 2017/11/8.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCountdownButton : UIButton

/**
 *  计时时间
 */
@property (nonatomic, assign) NSTimeInterval timeCount;
/**
 *  剩余时间
 */
@property (nonatomic, assign) NSTimeInterval surplusTimeCount;

/**
 *  开始倒计时
 */
- (void)start;
@end
