//
//  ImagePickerManager.m
//  YS_iOS_Other
//
//  Created by YJ on 17/2/10.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ImagePickerManager.h"
#import <QBImagePickerController/QBImagePickerController.h>

@implementation ImagePickerManager
{
    PickType _pickType;
    UIViewController * _listViewController;
}

- (instancetype)initWithPickerType:(PickType)type
                listViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        _pickType = type;
        _listViewController = viewController;
        
        UIImagePickerControllerSourceType soucreType = -1;
        
        if (_pickType == PickTypeSystemCamera || _pickType == PickTypeQBImagePickerCamera) {
            soucreType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            soucreType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        BOOL hasRoot = [self hasRootToUseWithMediaType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        
        if (hasRoot) {
            if (_pickType == PickTypeSystemCamera || _pickType == PickTypeSystemImageLibrary) {
                [self initSystemImagePickerVC];
            }
            else {
                [self initQBImagePickerVC];
            }
        }
    }
    return self;
}

- (void)initSystemImagePickerVC
{
    _imagePickerCon = [[UIImagePickerController alloc] init];
    _imagePickerCon.delegate = _listViewController;
    _imagePickerCon.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    if (_pickType == PickTypeSystemCamera) {
        _imagePickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;       // 相机
    }
    else {
        _imagePickerCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // 相册
    }
    
    [_listViewController presentViewController:_imagePickerCon animated:YES completion:nil];
}

- (void)initQBImagePickerVC
{
    _QBImagePC = [[QBImagePickerController alloc] init];
    _QBImagePC.delegate = _listViewController;
    _QBImagePC.allowsMultipleSelection = YES;        // 默认是NO
    _QBImagePC.minimumNumberOfSelection = 1;         // 最小选择数
    _QBImagePC.maximumNumberOfSelection = 9;         // 最大选择数
    _QBImagePC.showsNumberOfSelectedAssets = YES;    //
    if (_pickType == PickTypeQBImagePickerCamera) {
        _QBImagePC.mediaType = QBImagePickerMediaTypeVideo;  // 视频
    }
    else {
        _QBImagePC.mediaType = QBImagePickerMediaTypeImage;  // 图片
    }
    //        _QBImagePC.mediaType = QBImagePickerMediaTypeAny;    // 图片或视频
    //        _QBImagePC.prompt = @"选择照片";
    _QBImagePC.showsNumberOfSelectedAssets = YES;    // 显示已选中的图片数量
    _QBImagePC.numberOfColumnsInPortrait = 4;        // 竖屏时一排数
    _QBImagePC.numberOfColumnsInLandscape = 7;       // 横屏时一排数
    _QBImagePC.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeSmartAlbumUserLibrary), // 相机胶卷
                                           @(PHAssetCollectionSubtypeAlbumMyPhotoStream),    // 照片流
                                           @(PHAssetCollectionSubtypeSmartAlbumPanoramas),   // 全景图片
                                           @(PHAssetCollectionSubtypeSmartAlbumVideos),      // 视频
                                           @(PHAssetCollectionSubtypeSmartAlbumBursts)       // 连拍快照
                                           ];
    [_listViewController presentViewController:_QBImagePC animated:YES completion:nil];
}


// 判断是否有权限
- (BOOL)hasRootToUseWithMediaType:(UIImagePickerControllerSourceType)mediaType
{
    BOOL hasRoot = NO;
    
    if (![UIImagePickerController isSourceTypeAvailable:mediaType]) {
        DDLogInfo(@"---------- 没有权限，获取相册 / 相机");
    }
    else {
        hasRoot = YES;
    }
    return hasRoot;
}

@end
