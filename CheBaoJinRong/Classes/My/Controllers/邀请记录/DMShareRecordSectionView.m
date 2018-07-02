//
//  DMShareRecordSectionView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareRecordSectionView.h"

@implementation DMShareRecordSectionView

+ (DMShareRecordSectionView *)shareRecordSectionView
{
    DMShareRecordSectionView *view = [[UINib nibWithNibName:@"DMShareRecordSectionView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return view;
}

@end
