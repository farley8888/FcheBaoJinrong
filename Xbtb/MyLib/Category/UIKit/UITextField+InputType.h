//
//  UITextField+InputType.h
//  UITextFiledInputType
//
//  Created by ios-dev on 16/4/1.
//  Copyright © 2016年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DMTextInputType) {
    DMTextInputTypeAll              = 0,///< 所有
    DMTextInputTypeNumber           = 1<<0,///< 数字
    DMTextInputTypeLetter           = 1<<1,///< 字母
    DMTextInputTypeChinese          = 1<<2,///< 汉字
    DMTextInputTypeSpecialCharacter = 1<<3,///< 特殊字符
};

@interface UITextField (InputType)

/**
 *  输入的类型
 */
@property (nonatomic, assign) DMTextInputType inputType;

/**
 *  允许输入最长的长度  设置为<=0 无限制
 */
@property (nonatomic, assign) NSInteger maxLength;

- (void)setInputType:(DMTextInputType)inputType maxLength:(NSInteger)maxLength;

@end


