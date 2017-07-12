//
//  CamareAndLibraryManager.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "MediaLibraryManager.h"
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
        media_library_queue = dispatch_queue_create("media_library_queue", DISPATCH_QUEUE_CONCURRENT);
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
// 获取指定相册
- (void)getAlbum:(NSString *)albumName albumBlock:(void (^)(YSAlbumsModel *))block
{
    dispatch_async(media_library_queue, ^{
        
        __block YSAlbumsModel * retAlbum = nil;
        [self getAllAlbums:^(NSMutableArray *retAlbumsArr) {
            
            for (YSAlbumsModel * album in retAlbumsArr) {
                if ([album.name isEqualToString:albumName]) {
                    retAlbum = album;
                }
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(retAlbum);
            }
        });
    });
}

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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(albumsArr);
            }
        });
    });
}


#pragma mark - Photo
/** 获取相册的封面图 */
- (void)getAlbumPostImage:(YSAlbumsModel *)model
                     size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode
                postBlock:(void (^)(YSPhotosModel *model, UIImage *postImage, NSDictionary * info))block
{
    dispatch_async(media_library_queue, ^{
    
        __block YSPhotosModel * retPhotoModel = nil;
        __block UIImage * retImage = nil;
        __block NSDictionary * retInfo = [NSDictionary dictionary];
    
        if (iOS_Version >= 8.0) {
            [self getAllAlbums:^(NSMutableArray *retAlbumsArr) {
                
                for (YSAlbumsModel * album in retAlbumsArr) {
                    if ([album.name isEqualToString:model.name]) {
                        
                        PHFetchResult * ret = (PHFetchResult *)album.albumPhotos;
                        PHAsset * lastAsset = ret.lastObject;
                        
                        retPhotoModel = [[YSPhotosModel alloc] initWithAsset:lastAsset];
                        
                        PHImageRequestOptions * imageRequestOption = [[PHImageRequestOptions alloc] init];
                        imageRequestOption.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
                        imageRequestOption.resizeMode = resizeMode;
                        
                        [[PHImageManager defaultManager] requestImageForAsset:lastAsset
                                                                   targetSize:size
                                                                  contentMode:PHImageContentModeAspectFit
                                                                      options:imageRequestOption
                                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                            
                                                                    
                            NSLog(@"--------- image: %@", result);
                            retImage = result;
                            retInfo = info;
                            
                        }];
                        
                        break;
                    }
                }
            }];

        }
    
    
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(retPhotoModel, retImage, retInfo);
            }
        });
    });
    
//    dispatch_release(media_library_queue);
}

/** 获取相册中所有原图 */
- (void)getOriginAssetsFromAlbum:(YSAlbumsModel *)model ascending:(BOOL)ascending originBlock:(void (^)(NSMutableArray *originArr))block
{
    
}

/** 获取相册中所有缩略图 */
- (void)getAllThumbPhotosWithAlbum:(YSAlbumsModel *)model size:(CGSize)size ascending:(BOOL)ascending thumbBlock:(void (^)(NSMutableArray *thumbArr))block
{

}

#pragma mark - PHAsset 转 UIImage




@end
