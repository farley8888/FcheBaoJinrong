//
//  ShareRecordSectionView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareRecordSectionView.h"

@implementation ShareRecordSectionView

+ (ShareRecordSectionView *)shareRecordSectionView
{
    ShareRecordSectionView *view = [[UINib nibWithNibName:@"ShareRecordSectionView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return view;
}

@end
