//
//  YSPhotosViewController.h
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSImagePickerRootVC.h"
@class YSAlbumsModel;

@interface YSPhotosViewController : YSImagePickerRootVC

- (instancetype)initWithAlbum:(YSAlbumsModel *)album
                       horNum:(NSInteger)horNum;

@end
