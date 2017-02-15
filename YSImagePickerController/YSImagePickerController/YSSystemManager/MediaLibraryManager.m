//
//  CamareAndLibraryManager.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "MediaLibraryManager.h"
//#import <AVFoundation/AVFoundation.h>
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import "YSImagePickerHead.h"
#import "YSPhotosModel.h"

static dispatch_queue_t media_library_queue = nil;

@implementation MediaLibraryManager

+ (instancetype)sharedMediaLibrary
{
    static MediaLibraryManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MediaLibraryManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        media_library_queue = dispatch_queue_create("media_library_queue", NULL);
    }
    return self;
}

#pragma mark - Root
- (BOOL)hasMediaLibraryRoot
{
    BOOL hasRoot = NO;
    
    return hasRoot;
}

#pragma mark - Album
// 获取所有相册
- (void)getAllAlbums:(void (^)(NSMutableArray *))block
{
    dispatch_async(media_library_queue, ^{
    
        NSMutableArray * albumsArr = [@[] mutableCopy];
        
        if (iOS_Version >= 8.0) {
            
            // 所有智能相册
            PHFetchResult * ret = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            
            // 筛选条件
            PHFetchOptions * options = [[PHFetchOptions alloc] init];
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            
            for (PHAssetCollection * assetCollection in ret) {
                // 有可能是PHCollectionList类的的对象，过滤掉
                if (![assetCollection isKindOfClass:[PHAssetCollection class]]) continue;
                
                PHFetchResult * assetFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
                NSLog(@"--- 相册名：%@ ++++++++++ 数量：%ld", assetCollection.localizedTitle, assetFetchResult.count);
                YSAlbumsModel * albumModel = [[YSAlbumsModel alloc] initWithAlbum:assetFetchResult name:assetCollection.localizedTitle];
                [albumsArr addObject:albumModel];
            }
        }
        else {
            ALAssetsLibrary * alassetLibrary = [[ALAssetsLibrary alloc] init];
            [alassetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([group numberOfAssets] < 1) return;
                NSString * name = [group valueForProperty:ALAssetsGroupPropertyName];
                
                
            } failureBlock:^(NSError *error) {
                NSLog(@"-------- 相册访问失败！");
            }];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(albumsArr);
            }
        });
    });
}

#pragma mark - Photo
//- (UIImage *)getAlbumPostImage:(YSAlbumsModel *)model size:(CGSize)size
//{
//    if (iOS_Version >= 8.0) {
//        //
//        PHFetchResult * fetchRet = (PHFetchResult *)model.albumPhotos;
//        PHAsset * lastAsset = fetchRet.lastObject;
//    }
//    else {
//        
//    }
//}

- (void)requestThumbImage:(PHAsset *)phasset 
{
//    PHImageRequestID * imageRequest = [[PHImageManager defaultManager] requestImageForAsset:phasset targetSize:<#(CGSize)#> contentMode:<#(PHImageContentMode)#> options:<#(nullable PHImageRequestOptions *)#> resultHandler:<#^(UIImage * _Nullable result, NSDictionary * _Nullable info)resultHandler#>];
}

#pragma mark -




@end
