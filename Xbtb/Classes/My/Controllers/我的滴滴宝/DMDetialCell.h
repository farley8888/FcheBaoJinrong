//
//  DMDetialCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMDetialCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *cellDict;

@property (weak, nonatomic) IBOutlet UIView *detialBKView;

@property (nonatomic, copy) NSString *titleStrig;
@property (nonatomic, copy) NSString *detialString;

@end
