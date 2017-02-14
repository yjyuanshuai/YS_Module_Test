//
//  CamareAndLibraryManager.h
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CamareAndLibraryManager : NSObject

/** 是否有相机权限 */
// iOS 8 以后，要求授权
+ (BOOL)userHasCamareRoot;
+ (void)openCamareWithBlock:(void (^)(void))block;

/** 是否有相机权限 */


/** 获取相册 */
+ (BOOL)getAlbums:(void (^)(id albums))block;


@end
