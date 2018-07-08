//
//  SecionFooterView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SecionFooterView.h"

@implementation SecionFooterView

+ (SecionFooterView *)sectionFooterView
{
    SecionFooterView *view = [[UINib nibWithNibName:@"SecionFooterView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return view;
}
- (IBAction)callPhoneClick:(id)sender {
    if (self.callPhone) {
        self.callPhone();
    }
}

@end
