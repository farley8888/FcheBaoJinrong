//
//  DMLoadingView.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DMLoadingView.h"
#import "UIView+Extension.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>

@implementation DMLoadingView

-(void)dealloc
{
    DMLog(@"%s",__func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOut tintColor:kMenuColor];
        CGFloat width = 100;
        CGFloat height = 100;
        
        activityIndicatorView.frame = CGRectMake(frame.size.width/2.0 - 50,frame.size.height*0.35 -50 , width, height);
        [self addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
    }
    return self;
}

@end
