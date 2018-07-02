//
//  DMShareRecordHeadView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareRecordHeadView.h"
#import "UIView+DMGradientColor.h"

@implementation DMShareRecordHeadView

+ (DMShareRecordHeadView *)shareRecordHeadView
{
    DMShareRecordHeadView *view = [[UINib nibWithNibName:@"DMShareRecordHeadView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    view.totalFriendLabel.layer.cornerRadius = 30/2.0;
    view.totalFriendLabel.clipsToBounds = YES;
    
    return view;
}

@end
