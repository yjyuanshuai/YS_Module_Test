//
//  YSImagePickerController.h
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSImagePickerDelegate;

@interface YSImagePickerController : UINavigationController

// 最大选择数，默认是 9
@property (nonatomic, assign) NSInteger maxCount;
// 一行的个数
@property (nonatomic, assign) NSInteger columentNum;
// 是否默认展示图片选择页
@property (nonatomic, assign) BOOL showPickerView;
// 相册
@property (nonatomic, strong, readonly) NSMutableArray * allAlbums;
// 已选中的
//@property (nonatomic, strong) NSMutableArray * selectedAssets;
// 所有图片
//@property (nonatomic, strong) NSMutableArray * allAssets;

// delegate
@property (nonatomic, weak) id<YSImagePickerDelegate> imageDelegate;

// 初始化方法
- (instancetype)initWithMaxCount:(NSInteger)maxCount delegate:(id<YSImagePickerDelegate>)delegate;



@end


@protocol YSImagePickerDelegate <NSObject>

@optional


@end
