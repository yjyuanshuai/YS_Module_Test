//
//  YSSongModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSongModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * url;

- (instancetype)initWithWebSongDic:(NSDictionary *)dic;

@end
