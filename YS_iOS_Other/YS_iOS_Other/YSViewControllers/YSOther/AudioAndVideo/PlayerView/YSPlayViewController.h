//
//  YSPlayViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, AudioType)
{
    AudioTypeWeb,       //
    AudioTypeLocal      //
};

@interface YSPlayViewController : YSRootViewController

- (instancetype)initWithPlayType:(AudioType)type;

@end
