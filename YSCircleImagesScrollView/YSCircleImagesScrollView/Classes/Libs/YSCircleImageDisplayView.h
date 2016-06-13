//
//  YSCircleImageDisplayView.h
//  YSCircleImagesScrollView
//
//  Created by YJ on 16/1/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCircleImageDisplayView : UIView

#pragma mark - 属性
#pragma mark -
@property (nonatomic, assign) NSTimeInterval * timeInterval;    //每张图轮播的时间
@property (nonatomic, strong) NSArray * imagesArr;              //图片数组

/**
 *  自定义 pageControl 的图片
 */
@property (nonatomic, strong) UIImage * pageControlCurrentImage;    //pageControl选中时的图片
@property (nonatomic, strong) UIImage * pageControlTintImage;       //pageControl未选中时的图片


#pragma mark - 实例方法
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr;

#pragma mark - 类方法
#pragma mark -

@end
