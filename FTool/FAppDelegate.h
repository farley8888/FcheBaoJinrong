//
//  AppDelegate.h
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//



static NSString * const FToolUserDidSaveARecordNotification = @"FToolUserDidSaveARecordNotification";

#import <UIKit/UIKit.h>

@class FAccountCategaries, FCurrentMonthRecord;
@interface FAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FUserModel *userInfo;
@property (nonatomic,strong) FAccountCategaries *aFAccountCategaries;

@property (nonatomic,strong) FCurrentMonthRecord *currentMonthRecord;
@end

