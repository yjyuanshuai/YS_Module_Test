//
//  YSQRCodeImageView.m
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSQRCodeImageView.h"
#import "QRCodeGenerator.h"

@implementation YSQRCodeImageView

#pragma mark - instance method
- (instancetype)initWithFrame:(CGRect)frame String:(NSString *)aString
{
    CGRect newFrame = [self returnYSImageViewRectWithOriginRect:frame];
    if (self = [super initWithFrame:newFrame]) {
        self.image = [self returnQRImageWithString:aString];
    }
    return self;
}

#pragma mark - class method
+ (instancetype)qrImageViewWithFrame:(CGRect)frame String:(NSString *)aString
{
    YSQRCodeImageView * imageView = [[YSQRCodeImageView alloc] initWithFrame:frame String:aString];
    return imageView;
}

+ (instancetype)qrImageViewWithFrame:(CGRect)frame String:(NSString *)aString viewController:(UIViewController *)viewController
{
    YSQRCodeImageView * qrImageView = [YSQRCodeImageView qrImageViewWithFrame:frame String:aString];
    [viewController.view addSubview:qrImageView];
    return qrImageView;
}

#pragma mark - tool
/**
 *  生成二维码的图片
 */
- (UIImage *)returnQRImageWithString:(NSString *)aString
{
    return [QRCodeGenerator qrImageForString:aString imageSize:self.frame.size.width];
}

- (CGRect)returnYSImageViewRectWithOriginRect:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGFloat originX = frame.origin.x;
    CGFloat originY = frame.origin.y;
    
    CGFloat size = (width <= height) ? width : height;
    return CGRectMake(originX, originY, size, size);
}

@end
