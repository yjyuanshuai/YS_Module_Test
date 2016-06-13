//
//  DBManger.m
//  医宝数据库设计Test
//
//  Created by YJ on 16/3/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "DBManger.h"

@implementation DBManger

#pragma mark -
+ (FMDatabase *)sharedDB
{
    static FMDatabase * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self new] ysDB];
    });
    return instance;
}

- (FMDatabase *)ysDB
{
    FMDatabase * ys_db = [FMDatabase databaseWithPath:db_path];
    NSLog(@"----------- db_path: %@", db_path);
    
    if (![ys_db open]) {
        NSLog(@"--------- 数据库打开失败！");
        return nil;
    }
    
    return ys_db;
}

- (void)closeYSDB
{
    [[DBManger sharedDB] close];
}

#pragma mark - 操作
//创建表
- (void)createTable
{
    NSString * createTableStr = CREATE_TABLE(TEST_TABLE_NAME);
    
    BOOL isCreateTableSuccess = [[DBManger sharedDB] executeUpdate:createTableStr];
    
    if (!isCreateTableSuccess) {
        NSLog(@"+++++++++++++++ 创建表失败！");
    } else {
        NSLog(@"+++++++++++++++ 创建表成功！");
    
    }
}

//删除表
- (void)dropTable
{
    NSString * dropTableStr = DROP_TABLE(TEST_TABLE_NAME);
    
    BOOL isDropTableSuccess = [[DBManger sharedDB] executeUpdate:dropTableStr];
    
    if (isDropTableSuccess) {
        NSLog(@"++++++++++++ 删表成功！");
    } else {
        NSLog(@"++++++++++++ 删表失败！");
    }
}

//插入
- (void)insertData
{
    NSString * insertData = INSERT_DATA(TEST_TABLE_NAME);
    
    for (int i = 0; i < 4; i++) {
        BOOL isInsertData = [[DBManger sharedDB] executeUpdate:insertData, @(arc4random_uniform(40)), @"abcd", @"‘女’"];
        
        if (isInsertData) {
            NSLog(@"++++++++++++ 插入数据成功！");
        } else {
            NSLog(@"++++++++++++ 插入数据失败！");
        }

    }
}

//查询
- (void)selectData
{
    NSString * selectData = SELECT_DATA_ALL(TEST_TABLE_NAME);
    
    FMResultSet * resDataSet = [[DBManger sharedDB] executeQuery:selectData];
    
    while ([resDataSet next]) {
        int ysId = [resDataSet intForColumn:@"studentID"];
        NSLog(@"============== 查询结果：%d", ysId);
    }
}

@end
