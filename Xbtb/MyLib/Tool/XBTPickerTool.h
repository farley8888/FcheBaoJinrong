//
//  DMAreaPickerView.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XBTPickerTool : UIPickerView

+ (void)showDatas:(NSArray<NSString *> *)datas didSelect:(void(^)(NSInteger index))didSelect;

@end
