//
//  YSImageAndTextSort.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSImageAndTextSort : NSObject

+ (NSMutableAttributedString *)textAttach:(NSString *)text  attributDic:(NSDictionary *)dict emoArr:(NSArray *)emoArr originY:(CGFloat)originY;

@end
