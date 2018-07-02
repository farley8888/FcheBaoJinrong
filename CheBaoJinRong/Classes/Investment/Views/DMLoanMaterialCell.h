//
//  DMLoanMaterialCell.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLoanMateriaModel.h"

@interface DMLoanMaterialCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *leftConterButton;
@property (nonatomic, strong) DMLoanMateriaModel *cellModel;

@end
