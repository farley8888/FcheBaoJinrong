//
//  UIView+Loading.m
//  SWWH
//
//  Created by 尚往文化 on 16/8/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "UIView+Loading.h"
#import <objc/runtime.h>

static char *UIViewLoadingViewKey = "DMUIViewLoadingViewKey";
static char *UIViewNotDataViewKey = "DMUIViewNotDataViewKey";
static char *UIViewNetErrorViewKey = "DMUIViewNetErrorViewKey";

@interface UIView ()

@property (nonatomic, strong) XBTLoadingView *loadingView;
@property (nonatomic, strong) XBTNotDataView *notDataView;
@property (nonatomic, strong) XBTNetErrorView *netErrorView;

@end

@implementation UIView (Loading)

- (void)setLoadingView:(XBTLoadingView *)loadingView
{
    objc_setAssociatedObject(self, UIViewLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XBTLoadingView *)loadingView
{
    return objc_getAssociatedObject(self, UIViewLoadingViewKey);
}

- (void)setNotDataView:(XBTNotDataView *)notDataView
{
    objc_setAssociatedObject(self, UIViewNotDataViewKey, notDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XBTNotDataView *)notDataView
{
    return objc_getAssociatedObject(self, UIViewNotDataViewKey);
}

- (void)setNetErrorView:(XBTNetErrorView *)netErrorView
{
    objc_setAssociatedObject(self, UIViewNetErrorViewKey, netErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XBTNetErrorView *)netErrorView
{
    return objc_getAssociatedObject(self, UIViewNetErrorViewKey);
}

- (void)loading:(CGRect)frame
{
    XBTLoadingView *loadingView = [[XBTLoadingView alloc] initWithFrame:frame];
    self.loadingView = loadingView;
    [self addSubview:self.loadingView];
}

- (void)notData:(CGRect)frame
{
    XBTNotDataView *notDataView = [[XBTNotDataView alloc] initWithFrame:frame];
    self.notDataView = notDataView;
    [self addSubview:self.notDataView];
}

- (void)netError:(CGRect)frame againBlock:(void (^)())againBlock
{
    XBTNetErrorView *netErrorView = [[XBTNetErrorView alloc] initWithFrame:frame againBlock:againBlock];
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
