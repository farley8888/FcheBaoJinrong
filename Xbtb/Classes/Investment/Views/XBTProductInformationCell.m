//
//  DMProductInformationCell.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTProductInformationCell.h"

@interface XBTProductInformationCell()
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UILabel *detialLabel;
@property (weak, nonatomic) IBOutlet UIView *detialBKView;

@end

@implementation XBTProductInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detialBKView.layer.cornerRadius = 5;
    self.detialBKView.clipsToBounds = YES;
    self.titleButton.userInteractionEnabled = NO;
}

- (void)setTitleStrig:(NSString *)titleStrig
{
    _titleStrig = titleStrig;
    [self.titleButton setTitle:self.titleStrig forState:UIControlStateNormal];
}

- (void)setDetialString:(NSString *)detialString
{
    _detialString = detialString;
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    if ([detialString containsString:@"<p>"]) {
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[detialString dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
        self.detialLabel.attributedText = attrStr;
        self.detialLabel.font = [UIFont systemFontOfSize:14.0f];
    }else{
        self.detialLabel.text = detialString;
    }
}


@end
