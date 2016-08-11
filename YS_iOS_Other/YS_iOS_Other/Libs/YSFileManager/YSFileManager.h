//
//  YSFileManager.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FileLibrary)
{
    FileLibraryDocuments,
    FileLibraryCaches,
    FileLibraryPreferences,
    FileLibraryTmp
};

@interface YSFileManager : NSObject

#pragma mark - 文件管理
/**
 *  文件是否已存在（YES 存在，NO 不存在）
 */
+ (BOOL)fileHasExist:(NSString *)path;

/**
 *  创建文件到制定路径下
 */
+ (BOOL)createFileWithType:(FileLibrary)fileType toDes:(NSString *)path;

/**
 *  移动文件到指定路径下
 */
+ (BOOL)moveFile:(NSString *)originPath toDes:(NSString *)desPath;

/**
 *  复制文件到指定路径下
 */
+ (BOOL)copyFile:(NSString *)originPath toDes:(NSString *)desPath;

/**
 *  删除文件
 */
+ (BOOL)deleteFile:(NSString *)path;

/**
 *  获取文件大小
 */
+ (NSNumber *)getFileSize:(NSString *)path;

/**
 *  获取文件目录信息
 */


#pragma mark - 文件内容管理
/**
 *  写入数据到文件（不存在则创建）
 */
+ (BOOL)writeDataToFile:(NSString *)path;

/**
 *  从文件中读取数据
 */
+ (BOOL)readDataFromFile:(NSString *)path;

/**
 *  比较2个文件的内容是否一样（YES 相同，NO 不同）
 */
+ (BOOL)contentsOfFile:(NSString *)oPath equalTo:(NSString *)tPath;


@end
