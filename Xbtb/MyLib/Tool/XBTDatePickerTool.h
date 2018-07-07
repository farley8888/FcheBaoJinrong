//
//  DMDatePicker.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTDatePickerTool : UIDatePicker

+ (void)showMode:(UIDatePickerMode)datePickerMode didSelect:(void (^)(NSDate *date))didSelect;

+ (void)showMode:(UIDatePickerMode)datePickerMode didSelect:(void (^)(NSDate *date))didSelect ex:(NSDictionary *)ex;

@end
