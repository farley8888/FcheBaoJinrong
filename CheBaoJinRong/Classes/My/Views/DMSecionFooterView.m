//
//  DMSecionFooterView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMSecionFooterView.h"

@implementation DMSecionFooterView

+ (DMSecionFooterView *)sectionFooterView
{
    DMSecionFooterView *view = [[UINib nibWithNibName:@"DMSecionFooterView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return view;
}
- (IBAction)callPhoneClick:(id)sender {
    if (self.callPhone) {
        self.callPhone();
    }
}

@end
