//
//  DMAudioTool.m
//  SWWH
//
//  Created by 尚往文化 on 16/12/30.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DMAudioTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation DMAudioTool

+ (void)playSystemSound:(NSString *)soundFile
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
