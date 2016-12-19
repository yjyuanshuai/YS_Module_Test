//
//  YSTestDataBase.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSTestDataBase.h"
#import "YSFileManager.h"

@implementation YSTestDataBase

static YSTestDataBase * instance = nil;

+ (instancetype)defaultYSTestDB
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSTestDataBase alloc] init];
        [instance createDB];
    });
    return instance;
}

+ (NSString *)dbPath
{
    NSString * path = [YSFileManager getDocumentsPath];
    return [path stringByAppendingPathComponent:@"YSTestDB.sqlite"];
}

+ (FMDatabaseQueue *)getDBQueue
{
    FMDatabaseQueue * dbQueue = [FMDatabaseQueue databaseQueueWithPath:[YSTestDataBase dbPath]];
    return dbQueue;
}

//+ (FMDB)

//
- (BOOL)createDB
{
    BOOL createSuc = [YSFileManager createFiletoDes:[YSTestDataBase dbPath]];
    if (createSuc) {
        DDLogInfo(@"--------- DB file create success!");
    }
    else {
        DDLogInfo(@"--------- DB file create error!");
    }
    return createSuc;
}

@end
