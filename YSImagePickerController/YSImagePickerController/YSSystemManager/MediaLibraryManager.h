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
/** 获取所有相册 */
- (void)getAllAlbums:(void (^)(NSMutableArray * retAlbumsArr))block;

/** 获取相册中所有原图 */
- (NSMutableArray *)getAllPhotosWithAlbum:(YSAlbumsModel *)model ascending:(BOOL)ascending;

/** 获取相册中所有缩略图 */
- (NSMutableArray *)getAllThumbPhotosWithAlbum:(YSAlbumsModel *)model ascending:(BOOL)ascending;


#pragma mark - Photo
/** 获取相册的封面图 */
- (YSPhotosModel *)getAlbumPostImage:(YSAlbumsModel *)model size:(CGSize)size;
@end
