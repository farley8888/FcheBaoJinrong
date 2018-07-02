//
//  DMInputPSWController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMInputPSWController.h"

@interface DMInputPSWController ()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
//@property (weak, copy) NSString *chartString;
@property (weak, nonatomic) IBOutlet UILabel *moneyStringLab;

@end

@implementation DMInputPSWController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.textFiled.tintColor = [UIColor clearColor];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textFiled becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textFiled resignFirstResponder];
}

- (IBAction)closeButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupUI
{
    self.bkView.layer.cornerRadius = 10;
    self.bkView.clipsToBounds = YES;
    [self.textFiled addTarget:self action:@selector(texttfiledChangeText:) forControlEvents:UIControlEventEditingChanged];
    self.moneyStringLab.text = [NSString stringWithFormat:@"%.2f",[self.payMoneyString floatValue]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textFiled resignFirstResponder];
}

- (void)texttfiledChangeText:(UITextField *)textField
{
    if (textField.text.length <= 6) {
        for (int i = 0; i < textField.text.length; i++) {
            UILabel *lab = [self.view viewWithTag:1900+i];
            lab.text = @"*";
        }
        for (int i = 6; i >= textField.text.length;i-- ) {
            if (i<0) {
                break;
            }
            UILabel *lab = [self.view viewWithTag:1900+i];
            lab.text = @"";
        }
    }
    
    if (textField.text.length == 6) {
        if (self.passWordBlock) {
            self.passWordBlock(textField.text);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    DMLog(@"输入内容：%@",textField.text);
//    self.chartString = textField.text;
}

@end
