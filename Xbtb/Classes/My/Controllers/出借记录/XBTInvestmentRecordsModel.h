//
//  DMInvestmentRecordsModel.h
//  CheBaoJinRong
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTInvestmentRecordsModel : NSObject

//borrowStatus = 4;
/**  借款状态（1，申请中，2，初审通过，3，招标中，4，复审中，5，还款中，6，已还款，7，借款失败(初审)，8复审失败,9流标,10， 复审处理中,11 流标或复审不通过处理中  **/
@property (nonatomic, assign) NSInteger borrowStatus;
//borrowTitle = " test006";
/**  出借标题  **/
@property (nonatomic, copy) NSString *borrowTitle;

/**  出借金额  **/
@property (nonatomic, assign) CGFloat investAmount;
//investTime = 1526884107000;
/**  出借时间  **/
@property (nonatomic, assign) unsigned long long investTime;


@end
