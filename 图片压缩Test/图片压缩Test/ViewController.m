//
//  ViewController.m
//  图片压缩Test
//
//  Created by YJ on 16/3/24.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView * _originImageView; //原始图片
    UIImageView * _firstImageView;  //方法一
    UIImageView * _secondImageView; //方法二
    UIImageView * _thirdImageView;  //方法三
    
    UIImage * _testImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _testImage = [UIImage imageNamed:@"test"];
    [self createOriginImage];
    [self createFirstImage];
    [self createSecondImage];
    [self createThirdImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)createOriginImage
{
    _originImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 40, 200, 100)];
    _originImageView.contentMode = UIViewContentModeScaleAspectFit;
    _originImageView.image = _testImage;
    
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
    NSData * data = [NSData dataWithContentsOfFile:imagePath];
    NSLog(@"----------- 原始图片大小，origin: %u", data.length/1024);
    
    [self.view addSubview:_originImageView];
}

- (void)createFirstImage
{
    _firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 150, 200, 100)];
    _firstImageView.contentMode = UIViewContentModeScaleAspectFit;
    _firstImageView.image = [self scaleToSize:_testImage size:CGSizeMake(100, 50)];
    [self.view addSubview:_firstImageView];
}

- (void)createSecondImage
{
    _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 260, 200, 100)];
    _secondImageView.contentMode = UIViewContentModeScaleAspectFit;
    _secondImageView.image = [self imageCompressForSize:_testImage targetSize:CGSizeMake(100, 50)];
    
    [self.view addSubview:_secondImageView];
}

- (void)createThirdImage
{
    _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 370, 200, 100)];
    _thirdImageView.image = [self imageCompressForWidth:_testImage targetWidth:100];
    _thirdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_thirdImageView];
}

#pragma mark -
/**
 *  方法一 压缩成指定大小
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  方法二
 */
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 *  方法三
 */
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  方法四
 */
- (UIImage *)imagePNG:(UIImage *)image
{
    NSData * imageData = UIImagePNGRepresentation(image);
    NSLog(@"--------- 方法四，imagePNG 大小：%u", [imageData length]/1024);
    return [UIImage imageWithData:UIImagePNGRepresentation(image)];
}

/**
 *  方法五
 */
- (UIImage *)imageJPEG:(UIImage *)image size:(CGFloat)size
{
    NSData * imageData = UIImageJPEGRepresentation(image, size);
    NSLog(@"--------- 方法五，imageJPEG 大小：%u", [imageData length]/1024);
    return [UIImage imageWithData: UIImageJPEGRepresentation(image, size)];
}

- (double)returnImageLength:(UIImage *)image
{
    return 0;
}

@end
