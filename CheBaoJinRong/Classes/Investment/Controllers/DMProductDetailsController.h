//
//  DMProductDetailsController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRegularModel.h"

@interface DMProductDetailsController : UIViewController

@property (nonatomic, copy) NSString *prdID;

@property (nonatomic, strong) DMRegularModel *regModel;

@end
