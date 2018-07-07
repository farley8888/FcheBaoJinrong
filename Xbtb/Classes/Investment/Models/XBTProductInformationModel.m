//
//  DMProductInformationModel.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTProductInformationModel.h"

@implementation XBTProductInformationModel

-(NSString *)introductionInfosNomString
{
     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.introductionInfos dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

- (NSString *)collateralInfosNomString
{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.collateralInfos dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

- (NSString *)guaranteetypeNomString
{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.guaranteetype dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}


@end
