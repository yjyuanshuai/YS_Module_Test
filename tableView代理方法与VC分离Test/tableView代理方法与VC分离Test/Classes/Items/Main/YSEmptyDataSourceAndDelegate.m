//
//  YSEmptyDataSourceAndDelegate.m
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSEmptyDataSourceAndDelegate.h"

@implementation YSEmptyDataSourceAndDelegate

#pragma mark - instance method
/**
 *  title + description
 *
 *  @param title
 *  @param des
 */
- (instancetype)initWithTitle:(NSString *)title description:(NSString *)des
{
    return [self initWithImage:nil title:title description:des];
}

/**
 *  图片 + title + description
 *
 *  @param bgImage
 *  @param title
 *  @param des
 *
 */
- (instancetype)initWithImage:(UIImage *)bgImage title:(NSString *)title description:(NSString *)des
{
    if (self = [super init]) {
        self.bgImage = bgImage;
        self.titleStr = title;
        self.descriptionStr = des;
    }
    
    return self;
}

/**
 *  customView
 *
 */
- (instancetype)initCustomView:(UIView *)custemView
{
    if (self = [super init]) {
        self.customView = custemView;
    }
    return self;
}


#pragma mark - class method
+ (instancetype)emptyDataSetWithCustom:(UIView *)customView
{
    return [[YSEmptyDataSourceAndDelegate alloc] initCustomView:customView];
}

+ (instancetype)emptyDataSetWithTitle:(NSString *)title description:(NSString *)des
{
    return [[YSEmptyDataSourceAndDelegate alloc] initWithImage:nil title:title description:des];
}

+ (instancetype)emptyDataSetWithImage:(UIImage *)bgImage title:(NSString *)title description:(NSString *)des
{
    return [[YSEmptyDataSourceAndDelegate alloc] initWithImage:bgImage title:title description:des];
}



#pragma mark - DZNEmptyDataSetDelegate & DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.titleStr != nil) {
        return [YSEmptyDataSourceAndDelegate getAttributeStrWithStr:self.titleStr];
    }
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.descriptionStr != nil) {
        return [YSEmptyDataSourceAndDelegate getAttributeStrWithStr:self.descriptionStr];
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.bgImage != nil) {
        return self.bgImage;
    }
    return nil;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.customView != nil) {
        return self.customView;
    }
    return nil;
}

#pragma mark - 返回属性化字符串
+ (NSAttributedString *)getAttributeStrWithStr:(NSString *)str
{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:str
                                                                   attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                                                NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16.0f]}];
    return attrStr;
}

@end
