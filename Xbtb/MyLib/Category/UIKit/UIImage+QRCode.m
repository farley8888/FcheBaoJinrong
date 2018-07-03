//
//  UIImage+QRCode.m
//  XHGY_client
//
//  Created by 尚往文化 on 17/3/21.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "UIImage+QRCode.h"
#import "UIImageView+SD.h"

@implementation UIImage (QRCode)

- (UIImage *)QRCodeWithString:(NSString *)string
{
    CIImage *outputImage = [self creatQRCodeImage:string];
//    UIImage *image = [UIImage imageWithCIImage:[outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)]];
//    NSData *data = UIImagePNGRepresentation(image);
//    UIImage *img = [UIImage imageWithData:data];
//    [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:50];
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

//创建二维码
- (CIImage *)creatQRCodeImage:(NSString *)string
{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = string;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    return outputImage;
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//添加本地图片
- (UIImage *)addLogo:(UIImage *)qrUIImage singIMG:(UIImage *)sImage
{
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    //再把小图片画上去
    //     UIImage *sImage = [UIImage imageNamed:@"code"];
    //    UIImage *sImage = [self addLogoWithURL:<#(NSString *)#>];
    CGFloat sImageW = 150;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return finalyImage;
}

- (UIImage *)QRCodeWithString:(NSString *)string complete:(UIImage *)complete
{
    NSArray *arr = [string componentsSeparatedByString:@";"]; // 分割字符根据MyModel内部拼接方式
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [obj rangeOfString:@"="];
        NSString *str = [obj stringByReplacingCharactersInRange:NSMakeRange(0, range.location+1) withString:@""];
        [arrM addObject:str];
    }];
    
    
    //arr[1]];   根据myModel放入顺序
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    WeakSelf
    //    [imgView imageWithUrlStr:arrM[1] phImage:nil progressBlock:^(NSInteger receivedSize, NSInteger expectedSize) {
    //
    //    } completedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //        if (error == nil) {
    CIImage *outputImage = [self creatQRCodeImage:string];
    UIImage *img = [[UIImage alloc]init];
    UIImage *outimage = [UIImage imageWithCIImage:[outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)]];
    if (complete == nil) {
        img = outimage;
    }else{
        img = [self addLogo:outimage singIMG:complete];
    }
    
    return img;
    //        }
    //    }];
}

@end
