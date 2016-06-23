//
//  OneCollectionViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ComeFromType)
{
    ComeFromTypeOneCollection,
    ComeFromTypeTwoDocument,            // 沙盒
    ComeFromTypeTwoFile,                // 文件
    ComeFromTypeTwoArchive,             // 归档
    ComeFromTypeTwoSqlite,              // sqlite
    ComeFromTypeTwoCoreData             // CoreData
};


@interface OneCollectionViewController : UIViewController

- (instancetype)initWithType:(ComeFromType)type;

@end
