//
//  DMSettingCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTSettingCell.h"
#import "NSUserDefaults+Extension.h"

@interface XBTSettingCell ()

@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@end

@implementation XBTSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)switchClick:(UISwitch *)sender {
    
    UserManager *manger = [UserManager sharedManager];
    WeakSelf
    if (manger.gesString.length == 0) {
        
        if (weakSelf.cellBlock) {
            weakSelf.cellBlock();
        }
        return;
    }
    [UserManager sharedManager].isOpenGes = sender.on;
    [NSUserDefaults saveBool:sender.on key:GesturesPasswordOpenOrClose];
    DMLog(@"手势密码是否启用：%d",[NSUserDefaults getBoolForKey:GesturesPasswordOpenOrClose]);
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    self.switchView.hidden = YES;
    if(index == 4){
        BOOL select = [UserManager sharedManager].isOpenGes;
        self.switchView.hidden = NO;
        self.switchView.on = select;
        self.rightLabel.text = @"";
    }else if (index == 2){
        self.rightLabel.text = @"";
        
    }
}

@end
