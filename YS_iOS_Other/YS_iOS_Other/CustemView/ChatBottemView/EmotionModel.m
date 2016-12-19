//
//  EmotionModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "EmotionModel.h"

@implementation EmotionModel



@end



static EmotionFileAnalysis * instance = nil;

@implementation EmotionFileAnalysis

+ (instancetype)sharedEmotionFile
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance analysisEmoData];
    });
    return instance;
}

- (void)analysisEmoData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (!_emoArr) {
        _emoArr = [@[] mutableCopy];
    }
    
    // 枚举
    NSString * key;
    NSEnumerator * enumerator = [[dict allKeys] objectEnumerator];
    while (key = [enumerator nextObject]) {
        EmotionModel * model = [[EmotionModel alloc] init];
        model.cht = key;
        model.emo = dict[key];
        
        [_emoArr addObject:model];
    }
}


@end
