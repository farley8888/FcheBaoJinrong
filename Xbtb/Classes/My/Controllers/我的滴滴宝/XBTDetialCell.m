//
//  XBTDetialCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTDetialCell.h"

@interface XBTDetialCell ()

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UILabel *detialLabel;


@end


@implementation XBTDetialCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.detialBKView.layer.cornerRadius = 5;
    self.detialBKView.clipsToBounds = YES;
    self.titleButton.userInteractionEnabled = NO;
}

- (void)setCellDict:(NSDictionary *)cellDict
{
    _cellDict = cellDict;
    [self.titleButton setTitle:cellDict[@"title"] forState:UIControlStateNormal];
    self.detialLabel.text = cellDict[@"detial"];
    
}

- (void)setTitleStrig:(NSString *)titleStrig
{
    _titleStrig = titleStrig;
    [self.titleButton setTitle:self.titleStrig forState:UIControlStateNormal];
   
}


- (void)setDetialString:(NSString *)detialString
{
    _detialString = detialString;
    
    
    if ([detialString containsString:@"<p>"]) {
         NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[detialString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.detialLabel.attributedText = attrStr;
    }else{
        self.detialLabel.text = detialString;
    }
}

@end
