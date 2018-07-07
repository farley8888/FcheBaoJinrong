//
//  DMProductInformationModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTProductInformationModel : NSObject
//collateralInfos = "<p>\U5ba2\U6237\U540d\U4e0b\U4e30\U7530\U8f66\Uff0c \U8d2d\U4e70\U4ef750\U4e07\Uff0c\U8bc4\U4f30\U4ef726\U4e07\Uff0c\U501f\U6b3e17\U4e07\Uff0c\U8f66\U8f86\U72b6\U51b5\U826f\U597d\U3002<br></p>";
/**  项目说明  **/
@property (nonatomic, copy) NSString *introductionInfos;
@property (nonatomic, copy) NSString *introductionInfosNomString;

//riskControlInfos = "<p>\U501f\U6b3e\U4eba\Uff1a\U90b9\U7d20\U743c</p><p>\U5e74\U9f84\Uff1a54\U5c81</p><p>\U5a5a\U59fb\Uff1a\U5df2\U5a5a</p><p>\U7c4d\U8d2f\Uff1a\U5e7f\U4e1c\U6df1\U5733</p><p>\U5f81\U4fe1\Uff1a\U826f\U597d</p><p>\U6536\U5165\U60c5\U51b5\Uff1a\U6bcf\U6708\U51c0\U6536\U5165100\U4e07\U4ee5\U4e0a</p><p>\U501f\U6b3e\U7528\U9014\Uff1a\U5e97\U9762\U6269\U5f20</p>";
/**  借款人信息  **/
@property (nonatomic, copy) NSString *riskControlInfos;
@property (nonatomic, copy) NSString *riskControlInfosNomString;

//collateralInfos = "<p>\U5ba2\U6237\U540d\U4e0b\U4e30\U7530\U8f66\Uff0c \U8d2d\U4e70\U4ef750\U4e07\Uff0c\U8bc4\U4f30\U4ef726\U4e07\Uff0c\U501f\U6b3e17\U4e07\Uff0c\U8f66\U8f86\U72b6\U51b5\U826f\U597d\U3002<br></p>";
/**  车辆信息  **/
@property (nonatomic, copy) NSString *collateralInfos;
@property (nonatomic, copy) NSString *collateralInfosNomString;

//guaranteetype = "\U8f66\U8f86\U62b5\U62bc";
/**  担保措施  **/
@property (nonatomic, copy) NSString *guaranteetype;
@property (nonatomic, copy) NSString *guaranteetypeNomString;

@end
