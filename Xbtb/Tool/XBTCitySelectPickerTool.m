//
//  YBPickerTool.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/15.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "XBTCitySelectPickerTool.h"
#import "Define.h"

@interface XBTCitySelectPickerTool ()

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *showDateView;

@end

@implementation XBTCitySelectPickerTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self showView];
        [self bgView];
    }
    return self;
}

- (UIView *)showView
{
    if (_showView == nil) {
        
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-250, kScreenW, 250)];
        showView.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(showView.width-60, 0, 60, 34);
        [finishBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(8, 0, 60, 34);
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:cancelBtn];
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(finishBtn.frame), showView.width, showView.height-CGRectGetMaxY(finishBtn.frame))];
        pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [showView addSubview:pickerView];
        self.pickerView = pickerView;
        self.showView = showView;
    }
    return _showView;
}

- (UIView *)showDateView
{
    if (_showDateView == nil) {
        
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-250, kScreenW, 250)];
        showView.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(showView.width-60, 0, 60, 34);
        [finishBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(8, 0, 60, 34);
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:cancelBtn];
        
        UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(finishBtn.frame), showView.width, showView.height-CGRectGetMaxY(finishBtn.frame))];
        pickerView.datePickerMode = UIDatePickerModeDate;
        pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [showView addSubview:pickerView];
        self.datePicker = pickerView;
        self.showDateView = showView;
    }
    return _showDateView;
}

- (void)finishClick:(UIButton *)btn
{
    [self close];
    if (self.finishBlock) {
        self.finishBlock();
    }
}

- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .5;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self.showView removeFromSuperview];
    [self.showDateView removeFromSuperview];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    [window addSubview:self.showView];
    
}

- (void)showDatePicker
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    [window addSubview:self.showDateView];
}

@end
