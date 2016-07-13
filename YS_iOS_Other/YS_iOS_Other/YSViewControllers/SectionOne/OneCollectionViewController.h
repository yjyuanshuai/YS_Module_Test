//
//  OneCollectionViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, ComeFromType)
{
    ComeFromTypeOneCollection,
    ComeFromTypeTwoDocument,            // 沙盒
    ComeFromTypeTwoFile,                // 文件
    ComeFromTypeTwoArchive,             // 归档
    ComeFromTypeTwoSqlite,              // sqlite
    ComeFromTypeTwoCoreData             // CoreData
};


@interface OneCollectionViewController : YSRootViewController

- (instancetype)initWithType:(ComeFromType)type;

@end
