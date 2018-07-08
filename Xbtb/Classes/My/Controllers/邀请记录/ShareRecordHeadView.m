//
//  ShareRecordHeadView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareRecordHeadView.h"
#import "UIView+GradientColor.h"

@implementation ShareRecordHeadView

+ (ShareRecordHeadView *)shareRecordHeadView
{
    ShareRecordHeadView *view = [[UINib nibWithNibName:@"ShareRecordHeadView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    view.totalFriendLabel.layer.cornerRadius = 30/2.0;
    view.totalFriendLabel.clipsToBounds = YES;
    
    return view;
}

@end
