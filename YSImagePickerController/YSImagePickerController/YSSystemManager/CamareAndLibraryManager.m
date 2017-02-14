//
//  CamareAndLibraryManager.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "CamareAndLibraryManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YSImagePickerHead.h"

@implementation CamareAndLibraryManager

// 获取所有相册
- (BOOL)getAlbums
{
    if (iOS_Version >= 8.0) {
        
    }
    else {
    
    }
    return NO;
}

#pragma mark -
+ (BOOL)userHasCamareRoot
{
    BOOL hasRoot = NO;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
        {
            // 许可对话框没有出现，发起授权许可
            
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            // 已开启授权
            hasRoot = YES;
        }
            break;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
        {
            // 用户拒绝授权，或相机设备无法访问
            hasRoot = NO;
        }
            break;
        default:
            break;
    }
    
    return hasRoot;
}

+ (void)openCamareWithBlock:(void (^)(void))block
{
    if ([CamareAndLibraryManager userHasCamareRoot]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (granted) {
                    // 第一次用户接受
                    if (block) {
                        block();
                    }
                }
                else {
                    // 用户拒绝
                }
            });
        }];
    }
}

#pragma mark -




@end
