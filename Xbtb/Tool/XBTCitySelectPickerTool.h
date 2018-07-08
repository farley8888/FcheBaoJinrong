//
//  YBPickerTool.h
//  SWWH
//
//  Created by 尚往文化 on 16/8/15.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTCitySelectPickerTool : NSObject

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, copy) void(^finishBlock)();


- (void)showDatePicker;
- (void)show;
- (void)close;

@end
