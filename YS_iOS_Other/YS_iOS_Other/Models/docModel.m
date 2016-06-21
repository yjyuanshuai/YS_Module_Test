//
//  docModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "docModel.h"
#import "NSString+BreakLine.h"

@implementation sectionDetailModel

- (instancetype)initDeatiltWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _title = dic[@"title"];
        _detail = [dic[@"detail"] analyseBreakLine];//dic[@"detail"];
    }
    return self;
}

@end





@implementation docModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _sectionTitle = dic[@"sectiontitle"];
        _sectionDetailArr = [NSMutableArray array];
        
        for (NSDictionary * subDic in dic[@"sectiondetail"]) {
            sectionDetailModel * model = [[sectionDetailModel alloc] initDeatiltWithDic:subDic];
            [_sectionDetailArr addObject:model];
        }
    }
    return self;
}

@end
