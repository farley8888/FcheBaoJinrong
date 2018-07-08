//
//  DMLotOfViewScroller.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTLotOfViewScroller : UIView

@property (nonatomic, strong) NSArray *titileArray;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)skipToPageForType:(NSInteger )type;

@end
