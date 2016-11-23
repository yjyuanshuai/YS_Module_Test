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

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.name   = [aDecoder decodeObjectForKey:@"name"];
        self.url    = [aDecoder decodeObjectForKey:@"url"];
        
    }
    return self;
}

@end
