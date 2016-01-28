//
//  YSPageControl.h
//  YSCircleImagesScrollView
//
//  Created by YJ on 16/1/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSPageControl : UIView

#pragma mark - 属性
@property (nonatomic, assign) NSUInteger numberOfPages;   //全部页数
@property (nonatomic, assign) NSUInteger currentPageNumber; //当前页码

@property (nonatomic, strong) UIImage * pageControlTintImage;       // 未选中时的图片
@property (nonatomic, strong) UIImage * pageControlCurrentImage;    // 已选中时的图片

@property (nonatomic, strong) UIColor * pageControlTintColor;     //未颜色
@property (nonatomic, strong) UIColor * pageControlCurrentColor;  //已颜色

#pragma mark - 实例方法
- (instancetype)initWithFrame:(CGRect)frame;

@end
