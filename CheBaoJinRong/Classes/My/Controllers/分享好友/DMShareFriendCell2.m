//
//  DMShareFriendCell2.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareFriendCell2.h"

@interface DMShareFriendCell2 ()
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareCode;
@property (weak, nonatomic) IBOutlet UIButton *shareURL;
@property (weak, nonatomic) IBOutlet UIView *labBK;

@end


@implementation DMShareFriendCell2

- (void)awakeFromNib {
    [super awakeFromNib];
        self.urlLabel.text = [NSString stringWithFormat:@"http://www.chebaojr.com/wechat/regIndex.html?tel=%@",[UserManager sharedManager].user.userName];
    self.labBK.layer.cornerRadius = self.labBK.height/2.0;
    self.labBK.clipsToBounds = YES;
//    self.urlLabel.hidden = YES;

}
- (IBAction)shareURLButtonClick:(id)sender
{
    if (self.shareURLBlock) {
        self.shareURLBlock();
    }
}
- (IBAction)shareCodeButtonClick:(id)sender {
    if (self.shareCodeBlock) {
        self.shareCodeBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
