//
//  RecordChildController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordChildController : UIViewController
@property (nonatomic, assign) NSInteger type;  //1： 投资   2：赎回
@property (nonatomic, assign) BOOL isLoadData;
- (void)loadData;
@end
