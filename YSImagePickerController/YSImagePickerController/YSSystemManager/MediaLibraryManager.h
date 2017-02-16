//
//  CamareAndLibraryManager.h
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class YSPhotosModel;
@class YSAlbumsModel;

@interface MediaLibraryManager : NSObject

+ (instancetype)sharedMediaLibrary;

#pragma mark - Root
/** 相册权限  */
- (BOOL)hasMediaLibraryRoot;



#pragma mark - Album
/** 获取指定的相册 */
- (void)getAlbum:(NSString *)albumName albumBlock:(void (^)(YSAlbumsModel * model))block;

/** 获取所有相册 */
- (void)getAllAlbums:(void (^)(NSMutableArray * retAlbumsArr))block;




#pragma mark - Photo
/** 获取相册的封面图 */
- (void)getAlbumPostImage:(YSAlbumsModel *)model
                     size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode
                postBlock:(void (^)(YSPhotosModel *model, UIImage *postImage, NSDictionary * info))block;

/** 获取相册中所有原图 */
- (void)getOriginAssetsFromAlbum:(YSAlbumsModel *)model ascending:(BOOL)ascending originBlock:(void (^)(NSMutableArray *originArr))block;

/** 获取相册中所有缩略图 */
- (void)getAllThumbPhotosWithAlbum:(YSAlbumsModel *)model size:(CGSize)size ascending:(BOOL)ascending thumbBlock:(void (^)(NSMutableArray *thumbArr))block;

@end
