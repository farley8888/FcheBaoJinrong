//
//  DMShareCodeController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DMShareCodeController.h"
#import "UIImage+QRCode.h"

@interface DMShareCodeController ()
@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation DMShareCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor = [UIColor colorWithRed:144/255.0 green:140/255.0 blue:146/255.0 alpha:0.5];
    self.bkView.layer.cornerRadius = 10;
    self.bkView.clipsToBounds = YES;

    self.codeImageView.image = [[[UIImage alloc]init] QRCodeWithString:[NSString stringWithFormat:@"http://www.chebaojr.com/wechat/regIndex.html?tel=%@",[UserManager sharedManager].user.userName]];;
    self.codeImageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveCodePhoto:)];
    longPressGes.minimumPressDuration = 0.5;
    [self.codeImageView addGestureRecognizer:longPressGes];
}

- (void)saveCodePhoto:(UILongPressGestureRecognizer *)longGes
{
    if (longGes.state == UIGestureRecognizerStateBegan) {
        WeakSelf
        UIAlertView *alet = [UIAlertView alertWithTitle:@"温馨提示" message:@"是否将二维码图片保存至相册？" buttonIndex:^(NSInteger index) {
            if (index == 1) {
                [weakSelf saveImage];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
        [alet show];
    }
}

- (void)saveImage
{
//    NSData* imageData =  UIImagePNGRepresentation(self.codeImageView.image);
//    UIImage* newImage = [UIImage imageWithData:imageData];
    UIImageWriteToSavedPhotosAlbum(self.codeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSString *messzge = @"保存失败";
    if (error == nil) {
        messzge = @"已存入手机相册";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:messzge delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
