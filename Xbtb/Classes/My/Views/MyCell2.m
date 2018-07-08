//
//  YSMyCell2.m
//  XHGY_merchant
//
//  Created by 张殿明 on 17/7/26.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "MyCell2.h"
#import "HomeButton.h"
#import "UIImage+XBTIconFont.h"

@interface MyCell2 ()

@end

@implementation MyCell2

- (void)awakeFromNib {
     [super awakeFromNib];
     
}

- (void)setOrderNumber:(NSDictionary *)orderNumber
{
     for (NSInteger i = 1; i < 5; i++) {
          
          HomeButton *button = [self getHomeButtonWithTag:1100+i];
          UILabel *labTag = [button viewWithTag:100+i];
          [labTag removeFromSuperview];
          
          UILabel *lab = [[UILabel alloc]initWithFrame: CGRectMake(button.imageView.mj_x + button.imageWidth, 0, 15, 15)];
          lab.tag = 100 +i;
          lab.textColor = [UIColor redColor];
          lab.layer.cornerRadius = 7.5;
          lab.layer.borderWidth = 1;
          lab.font = [UIFont systemFontOfSize:10];
          lab.textAlignment = NSTextAlignmentCenter;
          lab.adjustsFontSizeToFitWidth = YES;
          lab.clipsToBounds = YES;
          lab.layer.borderColor = [UIColor redColor].CGColor;
          
          NSNumber *num = nil;
          if (i == 1){
               num = orderNumber[@"payment"];
          }else if (i == 2){
               num = orderNumber[@"delivered"];
          }else if (i == 3){
               num = orderNumber[@"received"];
          }else if (i == 4){
               num = orderNumber[@"evaluated"];
          };
          if ([num integerValue] != 0) {
               lab.text = [NSString stringWithFormat:@"%@",num];
               [button addSubview:lab];
          }
     }
}

- (void)setUI:(NSArray *)arr
{
     for (NSInteger i = 1; i < arr.count+1; i++) {
          
          HomeButton *button = [self getHomeButtonWithTag:1100+i];
          button.imageWidth = 25;
          [button setTitle:arr[i-1][@"title"] forState:UIControlStateNormal];  // i-1 为了对应枚举
          button.titleLabel.textAlignment = NSTextAlignmentCenter;
          [button setImage:[UIImage imageWithText:arr[i-1][@"img"] color:[UIColor redColor] size:CGSizeMake(50, 50)] forState:UIControlStateNormal];
          [button addTarget:self action:@selector(cellHomeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     }
}

- (void)cellHomeButtonClick:(HomeButton *)homeButton
{
     DMLog(@"%ld",homeButton.tag);
     if (self.cellHomeButtonClick) {
          self.cellHomeButtonClick(homeButton.tag -1100);
     }
}

- (IBAction)moreOrder:(UIButton *)sender {
     
     DMLog(@"查看更多订单");
     if (self.cellHomeButtonClick) {
          self.cellHomeButtonClick(0);
     }
}

- (HomeButton *)getHomeButtonWithTag:(NSInteger)tag
{
     HomeButton *button = [self viewWithTag:tag];
     return button;
}

- (void)setCellArray:(NSArray<NSDictionary *> *)cellArray
{
     _cellArray = cellArray;
     
     [self setUI: cellArray];
}


@end
