//
//  YSTestDataBase.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface YSTestDataBase : NSObject

+ (NSString *)dbPath;
+ (FMDatabaseQueue *)getDBQueue;
+ (instancetype)defaultYSTestDB;

@end
