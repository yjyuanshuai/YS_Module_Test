//
//  YSCodeImageView.h
//  原声识别二维码Test
//
//  Created by YJ on 16/3/24.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, YSCodeImageViewType)
{
    YSCodeImageViewTypeQR,      //二维码
    YSCodeImageViewTypeBar      //条形码
};


@interface YSCodeImageView : UIImageView
#pragma mark - 属性 -
@property (nonatomic, assign) YSCodeImageViewType ysImageViewType;



#pragma mark - 实例方法 -
- (instancetype)initWithFrame:(CGRect)frame type:(YSCodeImageViewType)type;
// 生成条形码
- (void)createBarCodeWithStr:(NSString *)codeStr;
// 生成二维码
- (void)createQRCodeWithStr:(NSString *)codeStr;
// 识别二维码和条形码
- (NSString *)recgoniteCode;

@end

