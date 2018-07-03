//
//  UIImage+QRCode.h
//  XHGY_client
//
//  Created by 尚往文化 on 17/3/21.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^completeBlock)(UIImage *image);

@interface UIImage (QRCode)

//@property (nonatomic, copy) completeBlock compBlock;

- (UIImage *)QRCodeWithString:(NSString *)string;

//带有网络图片的二维码
- (UIImage *)QRCodeWithString:(NSString *)string complete:(UIImage *)complete;

@end
