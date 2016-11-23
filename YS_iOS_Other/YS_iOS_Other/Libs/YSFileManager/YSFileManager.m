//
//  YSFileManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSFileManager.h"

@implementation YSFileManager

#pragma mark - 目录管理
+ (BOOL)directHasExist:(NSString *)diretPath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:diretPath isDirectory:&isDir];
    if (isExist && isDir) {
        DDLogInfo(@"---------- %@ 已存在！", diretPath);
    }
    else {
        DDLogInfo(@"---------- %@ 不存在！", diretPath);
    }
    return isExist;
}

+ (BOOL)createDirectName:(NSString *)directName
                  toPath:(NSString *)toDirect
{
    NSString * path = [toDirect stringByAppendingPathComponent:directName];
    
    if (![YSFileManager directHasExist:path]) {
        NSError * error = nil;
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        BOOL createSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogInfo(@"------------- 目标目录: %@ 创建失败！----- error: %@", path, error.localizedDescription);
        }
        if (createSuccess) {
            DDLogInfo(@"---------- 目标目录: %@ 创建成功！", path);
        }
        return createSuccess;
    }
    
    return NO;
}

#pragma mark - 文件管理

+ (BOOL)fileHasExist:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        DDLogInfo(@"------------ %@ 文件已存在！", path);
        return YES;
    }
    DDLogInfo(@"------------ %@ 文件不存在！", path);
    return NO;
}

+ (BOOL)createFileWithName:(NSString *)fileName toDes:(NSString *)path
{
    NSString * desPath = [path stringByAppendingPathComponent:fileName];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL createSuccess = [fileManager createFileAtPath:desPath contents:nil attributes:nil];
    if (createSuccess) {
        DDLogInfo(@"----------- %@ 创建成功", fileName);
    }
    else {
        DDLogInfo(@"----------- %@ 创建失败", fileName);
    }
    return createSuccess;
}

+ (BOOL)deleteFile:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError * error = nil;
    BOOL deleteSuccess = [fileManager removeItemAtPath:path error:&error];
    if (error) {
        DDLogInfo(@"------------ %@ 文件删除失败，error: %@", path, error.localizedDescription);
    }
    
    return deleteSuccess;
}

#pragma mark - 文件内容管理
+ (BOOL)writeData:(id)writeData toFile:(NSString *)path
{
    BOOL writeSuccess = NO;
    if ([writeData isKindOfClass:[NSString class]]) {
        
        // 字符串
        NSError * error = nil;
        
        NSString * writeStr = (NSString *)writeData;
        writeSuccess = [writeStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            DDLogInfo(@"----------- writeFile出错，error: %@", error.localizedDescription);
        }
        
    }
    else if ([writeData isKindOfClass:[NSData class]]) {
    
        NSData * writeDatas = (NSData *)writeData;
        writeSuccess = [writeDatas writeToFile:path atomically:YES];
        
    }
    else {
    
        DDLogInfo(@"------------- 写入数据非法！");
        
    }
    return writeSuccess;
}

+ (id)readDataFromFile:(NSString *)path
{
    return nil;
}


#pragma mark - 获取沙盒文件路径
+ (NSString *)getSandBoxHomePath
{
    return NSHomeDirectory();
}

+ (NSString *)getDocumentsPath
{
    // NSDocumentDirectory 表明我们正在查找 Documents 目录的路径
    // NSUserDomainMask 表示将搜索限制在引用程序的沙盒内
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
}

+ (NSString *)getLibraryPath
{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, NO);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
    
    // 另方法
    // [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)getLibraryCachesPath
{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
}

+ (NSString *)getTmpPath
{
    return NSTemporaryDirectory();
    
    // 另方法
    // return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

@end
