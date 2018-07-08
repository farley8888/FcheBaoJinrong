//
//  DMCustomNavVC.h
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XBTCustomNavigationBar.h"

@interface XBTCustomNavVC : UIViewController

@property (nonatomic, strong) XBTCustomNavigationBar *customNavBar;
- (void)setupNavBar;
@end
