//
//  DMLoanMaterialCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMLoanMaterialCell.h"
#import "UIImageView+SD.h"

@interface DMLoanMaterialCell ()



@end
@implementation DMLoanMaterialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftConterButton.userInteractionEnabled = NO;
}


- (void)setCellModel:(DMLoanMateriaModel *)cellModel
{
    _cellModel = cellModel;
    
//    NSString *url = [NSString stringWithFormat:@"%@%@",kAPI_URL,cellModel.attrPath];
    NSString *url = [NSString stringWithFormat:@"%@%@",kAPI_URL,cellModel.attrPath];
    [self.imgView imageWithUrlStr:url phImage:kMorentupian];
    
}

@end
