//
//  MyHeadView.h
//  XYG
//
//  Created by 张殿明 on 2017/11/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

typedef NS_ENUM(NSInteger,MyHeadViewOrMyDiDiBaoType) {
    
    MyHeadViewType,
    MyDiDiBaoHeadViewType
};

@interface MyHeadView : UICollectionReusableView

@property (nonatomic, copy) void(^withdrawAndRechBlock)(NSInteger num);

@property (nonatomic, strong) MyModel *headModel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (nonatomic, assign) BOOL isCanSee;
@property (nonatomic, assign) MyHeadViewOrMyDiDiBaoType type;

+ (MyHeadView *)myHeadView;

@end
