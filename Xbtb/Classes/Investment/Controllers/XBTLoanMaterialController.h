//
//  XBTLoanMaterialController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

//#import "DMBaseTableViewController.h"
#import <UIKit/UIKit.h>

@interface XBTLoanMaterialController : UIViewController

@property (nonatomic, copy) NSString *prdID;
@property (nonatomic, assign) BOOL isLoadData;
- (void)loadData;

@end