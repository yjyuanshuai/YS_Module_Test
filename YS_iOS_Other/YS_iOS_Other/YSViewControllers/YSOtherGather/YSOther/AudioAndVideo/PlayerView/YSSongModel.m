//
//  YSSongModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSongModel.h"

@implementation YSSongModel

- (instancetype)initWithWebSongDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _name = dic[@"name"];
        _url = dic[@"url"];
    }
    return self;
}

@end
