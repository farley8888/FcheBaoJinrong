//
//  UIImageView+DMAnimated.m
//  TEST
//
//  Created by 尚往文化 on 17/4/10.
//  Copyright © 2017年 DMing. All rights reserved.
//

#import "UIImageView+DMAnimated.h"
#import <objc/runtime.h>

#ifndef UIImageView_displaylink
#define UIImageView_displaylink @"UIImageView_displaylink"
#endif

@interface UIImageView ()

@property (nonatomic, strong) CADisplayLink *___displaylink;

@end

@implementation UIImageView (DMAnimated)

- (void)set___displaylink:(CADisplayLink *)___displaylink
{
    objc_setAssociatedObject(self, UIImageView_displaylink, ___displaylink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CADisplayLink *)___displaylink
{
    return objc_getAssociatedObject(self, UIImageView_displaylink);
}

- (void)DM_startAnimating
{
    [self DM_stopAnimating];
    self.___displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(DM_displaylink:)];
    [self.___displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)DM_stopAnimating
{
    [self.___displaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.___displaylink = nil;
}

- (void)DM_displaylink:(CADisplayLink *)displaylink
{
    if (self.image==nil) return;
    CGImageRef imageRef = self.image.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    UInt32 *inputPixels = (UInt32 *)calloc(width*height, sizeof(UInt32));
    CGContextRef contextRef = CGBitmapContextCreate(inputPixels, width, height, 8, width*4, colorSpaceRef, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    for (int i=0; i<height; i++) {
        for (int j=0; j<width; j++) {
            if (j<width-1) {
                *(inputPixels + i*width + j) = *(inputPixels + i*width + j+1);
            } else {
                *(inputPixels + i*width + j) = *(inputPixels + i*width + 0);
            }
        }
    }
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(contextRef);
    self.image = [[UIImage alloc] initWithCGImage:newImageRef];
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(newImageRef);
    CGContextRelease(contextRef);
    free(inputPixels);
}

@end
