//
//  DMRegularSectionHeadView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMRegularSectionHeadView.h"

@implementation DMRegularSectionHeadView

+(DMRegularSectionHeadView  *)headview
{
    DMRegularSectionHeadView *headView = [[UINib nibWithNibName:@"DMRegularSectionHeadView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return headView;
}
@end
