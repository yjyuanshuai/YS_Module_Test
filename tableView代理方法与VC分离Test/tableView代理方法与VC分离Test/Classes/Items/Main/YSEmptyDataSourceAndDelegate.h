//
//  YSEmptyDataSourceAndDelegate.h
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface YSEmptyDataSourceAndDelegate : NSObject <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>


#pragma mark - 属性
@property (nonatomic, strong) UIImage * bgImage;        // 背景图片
@property (nonatomic, copy) NSString * titleStr;        // 标题
@property (nonatomic, copy) NSString * descriptionStr;  // 描述
@property (nonatomic, strong) UIView * customView;      // 


#pragma mark - 
#pragma mark - 初始化（实例方法）
/** 标题 + 描述 */
- (instancetype)initWithTitle:(NSString *)title description:(NSString *)des;
/** 背景图片 + 标题 + 描述 */
- (instancetype)initWithImage:(UIImage *)bgImage title:(NSString *)title description:(NSString *)des;
/** 自定义背景 */
- (instancetype)initCustomView:(UIView *)custemView;




#pragma mark - 初始化（类方法）
+ (instancetype)emptyDataSetWithCustom:(UIView *)customView;
+ (instancetype)emptyDataSetWithTitle:(NSString *)title description:(NSString *)des;
+ (instancetype)emptyDataSetWithImage:(UIImage *)bgImage title:(NSString *)title description:(NSString *)des;


@end
