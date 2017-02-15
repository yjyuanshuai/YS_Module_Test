//
//  YSPhotosModel.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSPhotosModel.h"
#import "YSImagePickerHead.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation YSPhotosModel



@end




@implementation YSAlbumsModel

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithAlbum:(id)album name:(NSString *)name
{
    if (self = [super init]) {
        if (iOS_Version >= 8.0) {
            
            PHFetchResult * assetResult = (PHFetchResult *)album;
            self.name = name;
            self.count = assetResult.count;
            self.albumPhotos = assetResult;
            
        }
        else {
        
        }
    }
    return self;
}


@end
