//
//  DMShareRecordHeadView.h
//  CheBaoJinRong
//
//  Created by apple on 2018/6/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMShareRecordHeadView : UIView

+ (DMShareRecordHeadView *)shareRecordHeadView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalFriendLabel;
    
@end
