//
//  DMDatePicker.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "XBTDatePickerTool.h"
#import "DMDefine.h"

@interface XBTDatePickerTool ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, copy) void(^didSelect)(NSDate *obj);

@end

@implementation XBTDatePickerTool

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self];
        [_bgView addSubview:self.toolBar];
        
        
    }
    return _bgView;
}

- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-self.frame.size.height-34, kScreenW, 34)];
        _toolBar.backgroundColor = [UIColor whiteColor];

        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kScreenW-60, 0, 60, _toolBar.frame.size.height);
        [finishBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(8, 0, 60, _toolBar.frame.size.height);
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}

- (void)finishClick
{
    if (self.didSelect) {
        self.didSelect(self.date);
    }
    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    self.toolBar = nil;
    self.bgView = nil;
}

+ (void)showMode:(UIDatePickerMode)datePickerMode didSelect:(void (^)(NSDate *))didSelect
{
    XBTDatePickerTool *datePicker = [XBTDatePickerTool shareTool];
    datePicker.didSelect = didSelect;
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor whiteColor];
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:datePicker.bgView];
}

+ (XBTDatePickerTool *)shareTool
{
    XBTDatePickerTool *datePicker = [[XBTDatePickerTool alloc] initWithFrame:CGRectMake(0, kScreenH-220, kScreenW, 220)];
    datePicker.backgroundColor = [UIColor whiteColor];
    return datePicker;
}

+ (void)showMode:(UIDatePickerMode)datePickerMode didSelect:(void (^)(NSDate *))didSelect ex:(NSDictionary *)ex
{
    XBTDatePickerTool *datePicker = [XBTDatePickerTool shareTool];
    datePicker.didSelect = didSelect;
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker setValuesForKeysWithDictionary:ex];
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:datePicker.bgView];
}

@end
