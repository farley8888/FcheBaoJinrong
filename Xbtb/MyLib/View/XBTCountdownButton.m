//
//  DMCountdownButton.m
//  DMCountdownButton
//
//  Created by 尚往文化 on 2017/11/8.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "XBTCountdownButton.h"
#import "DMConfig.h"

@interface XBTCountdownButton ()

@property (nonatomic, strong)UILabel *timeLabel;

@end

@implementation XBTCountdownButton
{
    NSTimer *_timer;
    
    NSTimeInterval _timeCount2;
    
    UILabel *_timeLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = self.backgroundColor;
        _timeLabel.layer.cornerRadius = self.layer.cornerRadius;
    }
    return _timeLabel;
}

- (void)setTimeCount:(NSTimeInterval)timeCount
{
    _timeCount = timeCount;
    _timeCount2 = timeCount;
    self.surplusTimeCount = timeCount;
}

- (void)start
{
    self.enabled = NO;
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [self addSubview:self.timeLabel];
    _timeLabel.backgroundColor = [UIColor grayColor];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.clipsToBounds = YES;
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f秒后可重发", _timeCount2];
    self.surplusTimeCount = self.timeCount;
}

- (void)timerAction
{
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f秒后可重发", --_timeCount2];
    self.surplusTimeCount = _timeCount2;
    if (_timeCount2 == 0) {
        self.enabled = YES;
        [self.timeLabel removeFromSuperview];
        _timeCount2 = self.timeCount;
        if ([_timer isValid]) {
            [_timer invalidate];
        }
    }
}
@end
