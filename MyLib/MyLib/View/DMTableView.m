//
//  DMTableView.m
//  ZCWL
//
//  Created by ios-dev on 16/2/29.
//  Copyright © 2016年 com.zcwljs.cnge.app. All rights reserved.
//

#import "DMTableView.h"

@interface DMTableView ()

@end

@implementation DMTableView

/**
 *  获取View的控制器
 */
- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (self.scrollInvalidRect.size.width!=0 && self.scrollInvalidRect.size.height!=0) {
        if (CGRectContainsPoint(self.scrollInvalidRect, point)) {
            self.scrollEnabled = NO;
        } else {
            self.scrollEnabled = YES;
        }
    }
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return view;
    }
    
    if (![view isKindOfClass:[UITextField class]] && ![view isKindOfClass:[UITextView class]]) {
        [self endEditing:YES];
        [self.superview endEditing:YES];
        
        [self.superview.superview endEditing:YES];
        UIViewController *vc = [self viewController];
        [vc.navigationController.navigationBar endEditing:YES];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController *)vc).navigationBar endEditing:YES];
        }

    }
    return view;
}

@end
