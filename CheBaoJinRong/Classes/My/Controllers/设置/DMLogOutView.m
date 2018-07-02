//
//  DMLogOutView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLogOutView.h"


@implementation DMLogOutView

+ (DMLogOutView *)logoutView
{
    DMLogOutView *view = [[UINib nibWithNibName:@"DMLogOutView" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return view;
}
- (IBAction)logOutButtonClick:(id)sender {
    
    if (self.logoutBlock) {
        self.logoutBlock();
    }
}

@end
