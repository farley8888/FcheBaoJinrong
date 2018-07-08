//
//  UITextField+InputType.m
//  UITextFiledInputType
//
//  Created by ios-dev on 16/4/1.
//  Copyright © 2016年 DMing. All rights reserved.
//

#import "UITextField+InputType.h"
#import <objc/runtime.h>

//定义常量 必须是C语言字符串
static char *UITextFieldInputTypeKey = "UITextFieldInputTypeKey";
static char *UITextFieldMaxLengthKey = "UITextFieldMaxLengthKey";

@implementation UITextField (InputType)

- (void)textFieldDidChange:(UITextField *)textField
{
    UITextRange *selectedRange = [textField markedTextRange];
    NSString * newText = [textField textInRange:selectedRange];
    //获取高亮部分
    if(newText.length>0) return;
    
    NSString *inputStr = textField.text;
    if (inputStr.length == 0) return;
    NSInteger maxLength = textField.maxLength;
    if (inputStr.length>maxLength) {
        textField.text = [inputStr substringToIndex:maxLength];
    }
    DMTextInputType inputType = textField.inputType;
    NSMutableString *str = [NSMutableString stringWithString:textField.text];
    for (NSInteger i = str.length-1; i>-1; i--) {
        NSInteger c = [str characterAtIndex:i];
         BOOL result = [self filter:c inputType:inputType];
        if (!result) {
            [str replaceCharactersInRange:NSMakeRange(i, 1) withString:@""];
        }
    }
    textField.text = str;
    
}

- (BOOL)filter:(NSInteger)c inputType:(DMTextInputType)inputType
{
    if (inputType == DMTextInputTypeAll) {
        return YES;
    }
    if ((inputType & DMTextInputTypeNumber) == DMTextInputTypeNumber) {
        if (c>='0' && c<='9') {
            return YES;
        }
    }
    if ((inputType & DMTextInputTypeChinese) == DMTextInputTypeChinese) {
        if (c>0x4e00 && c<0x9fff) {//只能输入汉字
            return YES;
        }
    }
    if ((inputType & DMTextInputTypeLetter) == DMTextInputTypeLetter) {
        if (((c>='a' && c<='z') || (c>='A' && c<='Z'))) {
            return YES;
        }
    }
    if ((inputType & DMTextInputTypeSpecialCharacter) == DMTextInputTypeSpecialCharacter) {
        NSString *str = @"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～";
        NSString *charStr = [NSString stringWithFormat:@"%c", (char)c];
        if ([str rangeOfString:charStr].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (void)setInputType:(DMTextInputType)inputType
{
    objc_setAssociatedObject(self, UITextFieldInputTypeKey, @(inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (DMTextInputType)inputType
{
    return [objc_getAssociatedObject(self, UITextFieldInputTypeKey) unsignedIntegerValue];
}

- (void)setMaxLength:(NSInteger)maxLength
{
    objc_setAssociatedObject(self, UITextFieldMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)maxLength
{
    NSInteger max = [objc_getAssociatedObject(self, UITextFieldMaxLengthKey) integerValue];
    return max<=0 ? NSIntegerMax : max;
}

- (void)setInputType:(DMTextInputType)inputType maxLength:(NSInteger)maxLength
{
    self.inputType = inputType;
    self.maxLength = maxLength;
}


@end

