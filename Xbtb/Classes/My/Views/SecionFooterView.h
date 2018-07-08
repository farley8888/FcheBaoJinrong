//
//  SecionFooterView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecionFooterView : UICollectionReusableView

+ (SecionFooterView *)sectionFooterView;

@property (nonatomic, copy) void (^callPhone)();

@end
