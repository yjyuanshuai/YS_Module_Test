//
//  DBQueryString.h
//  医宝数据库设计Test
//
//  Created by YJ on 16/3/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#ifndef DBQueryString_h
#define DBQueryString_h

//建表
#define CREATE_TABLE(str) [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(studentID integer NOT NULL, name text, sex text)", str]

//删表
#define DROP_TABLE(table_name) [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", table_name]

//插入数据
#define INSERT_DATA(table_name) [NSString stringWithFormat:@"INSERT INTO %@(studentID, name, sex) VALUES (?, ?, ?)", table_name]

//查询数据
#define SELECT_DATA_ALL(table_name) [NSString stringWithFormat:@"SELECT * FROM %@", table_name]
#define SELECT_DATA_WHERE(table_name, where_str) [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", table_name, where_str]

//删除数据
#define DELETE_DATA_ALL(table_name) [NSString stringWithFormat:@"DELETE FROM %@", table_name]
#define DELETE_DATA_WHERE(table_name, where_str) [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", table_name, where_str]

//更新数据
#define UPDATE_DATA(table_name, values) [NSString stringWithFormat:@"UPDATE %@ SET %@", table_name, values]

#endif /* DBQueryString_h */







