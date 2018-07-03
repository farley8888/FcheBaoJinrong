//
//  DMBaseController.m
//  SWWH
//
//  Created by 尚往文化 on 16/6/28.
//  Copyright © 2016年 DMing. All rights reserved.
//

#import "DMBaseController.h"


@interface DMBaseController ()



@end

@implementation DMBaseController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
