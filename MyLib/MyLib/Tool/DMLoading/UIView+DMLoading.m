//
//  UIView+DMLoading.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "UIView+DMLoading.h"
#import <objc/runtime.h>

static char *UIViewLoadingViewKey = "DMUIViewLoadingViewKey";
static char *UIViewNotDataViewKey = "DMUIViewNotDataViewKey";
static char *UIViewNetErrorViewKey = "DMUIViewNetErrorViewKey";

@interface UIView ()

@property (nonatomic, strong) DMLoadingView *loadingView;
@property (nonatomic, strong) DMNotDataView *notDataView;
@property (nonatomic, strong) DMNetErrorView *netErrorView;

@end

@implementation UIView (DMLoading)

- (void)setLoadingView:(DMLoadingView *)loadingView
{
    objc_setAssociatedObject(self, UIViewLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DMLoadingView *)loadingView
{
    return objc_getAssociatedObject(self, UIViewLoadingViewKey);
}

- (void)setNotDataView:(DMNotDataView *)notDataView
{
    objc_setAssociatedObject(self, UIViewNotDataViewKey, notDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DMNotDataView *)notDataView
{
    return objc_getAssociatedObject(self, UIViewNotDataViewKey);
}

- (void)setNetErrorView:(DMNetErrorView *)netErrorView
{
    objc_setAssociatedObject(self, UIViewNetErrorViewKey, netErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DMNetErrorView *)netErrorView
{
    return objc_getAssociatedObject(self, UIViewNetErrorViewKey);
}

- (void)loading:(CGRect)frame
{
    DMLoadingView *loadingView = [[DMLoadingView alloc] initWithFrame:frame];
    self.loadingView = loadingView;
    [self addSubview:self.loadingView];
}

- (void)notData:(CGRect)frame
{
    DMNotDataView *notDataView = [[DMNotDataView alloc] initWithFrame:frame];
    self.notDataView = notDataView;
    [self addSubview:self.notDataView];
}

- (void)netError:(CGRect)frame againBlock:(void (^)())againBlock
{
    DMNetErrorView *netErrorView = [[DMNetErrorView alloc] initWithFrame:frame againBlock:againBlock];
    self.netErrorView = netErrorView;
    [self addSubview:self.netErrorView];
}

- (void)stop
{
    [self.loadingView removeFromSuperview];
    [self.notDataView removeFromSuperview];
    [self.netErrorView removeFromSuperview];
}

@end
