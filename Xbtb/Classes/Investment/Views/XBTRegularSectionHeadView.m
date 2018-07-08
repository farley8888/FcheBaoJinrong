//
//  XBTRegularSectionHeadView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTRegularSectionHeadView.h"

@implementation XBTRegularSectionHeadView

+(XBTRegularSectionHeadView  *)headview
{
    XBTRegularSectionHeadView *headView = [[UINib nibWithNibName:@"XBTRegularSectionHeadView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return headView;
}
@end
