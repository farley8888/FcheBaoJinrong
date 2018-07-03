//
//  DMCustomNavVC.h
//  XYG
//
//  Created by ltyj on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMCustomNavigationBar.h"

@interface DMCustomNavVC : UIViewController

@property (nonatomic, strong) DMCustomNavigationBar *customNavBar;
- (void)setupNavBar;
@end
