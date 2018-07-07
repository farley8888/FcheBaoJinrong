//
//  DMInputPSWController.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTInputPSWController : UIViewController

@property (nonatomic, copy) void (^passWordBlock)(NSString *psw);
@property (nonatomic, copy) NSString *payMoneyString;

@end
