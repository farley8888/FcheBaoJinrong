//
//  MessageDetialController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MessageDetialController.h"
#import "NSDate+DM.h"

@interface MessageDetialController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation MessageDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.type == 0) {
        self.navigationItem.title = @"平台公告";
    }else{
        self.navigationItem.title = @"媒体报道";
    }
    
    self.titleLab.text = self.childModel.noticeTitle;
    self.timeLab.text = [NSDate stringWithTimeInterval:self.childModel.createTime dateFormat:@"yyyy-MM-dd HH-mm-ss"];

    self.childModel.noticeContent = [self.childModel.noticeContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    self.contentLab.text = [NSString stringWithFormat:@"  %@",self.childModel.noticeContent];
}


@end
