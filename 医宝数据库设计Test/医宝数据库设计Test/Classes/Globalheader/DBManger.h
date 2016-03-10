//
//  DBManger.h
//  医宝数据库设计Test
//
//  Created by YJ on 16/3/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBQueryString.h"
#import "FMDB.h"

@interface DBManger : NSObject

//数据库名
#define DB_NAME @"DB_NAME.sqlite"

//获取用户documents 目录
#define user_document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//数据库路径
#define db_path [user_document stringByAppendingPathComponent:DB_NAME]

//表
#define TEST_TABLE_NAME @"ysTestTable"


#pragma mark - 操作方法
//单例 - 数据库
+ (FMDatabase *)sharedDB;

//关闭数据库
- (void)closeYSDB;

//建表
- (void)createTable;
- (void)dropTable;
- (void)insertData;
- (void)selectData;



@end
