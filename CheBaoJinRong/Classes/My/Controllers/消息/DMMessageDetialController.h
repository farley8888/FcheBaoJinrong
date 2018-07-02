//
//  DMMessageDetialController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMessageChildModel.h"

@interface DMMessageDetialController : UIViewController

@property (nonatomic, strong) DMMessageChildModel *childModel;
@property (nonatomic, assign) NSInteger type;

@end
