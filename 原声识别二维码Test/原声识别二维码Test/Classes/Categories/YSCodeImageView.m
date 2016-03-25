//
//  YSCodeImageView.m
//  原声识别二维码Test
//
//  Created by YJ on 16/3/24.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCodeImageView.h"

@implementation YSCodeImageView
{
    NSString * _codeStr;
}
- (instancetype)initWithFrame:(CGRect)frame type:(YSCodeImageViewType)type
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        _ysImageViewType = type;
    }
    return self;
}

#pragma mark - 识别二维码和条形码 -
- (NSString *)recgoniteCode
{
    _codeStr = @"";
    
    if (self.image == nil) {
        _codeStr = @"";
    }else {
        
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                                  context:[CIContext contextWithOptions:nil]
                                                  options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
        
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:[self.image CGImage]]];
        
        if (features.count) {
            for (CIFeature *feature in features) {
                
                if ([feature isKindOfClass:[CIQRCodeFeature class]]) {
                    
                    _codeStr = ((CIQRCodeFeature *)feature).messageString;
                    
                    break;
                }
            }
            
        } else {
            
            _codeStr = @"";
            NSLog(@"未正常解析二维码图片, 请确保iphone5/5c以上的设备");
            
        }
    }
    
    return _codeStr;
}

#pragma mark - 生成条形码和二维码 -
//生成条形码
- (void)createBarCodeWithStr:(NSString *)codeStr
{
    _ysImageViewType = YSCodeImageViewTypeBar;
    [self createCodeWithStr:codeStr];
}

//生成二维码
- (void)createQRCodeWithStr:(NSString *)codeStr
{
    _ysImageViewType = YSCodeImageViewTypeQR;
    [self createCodeWithStr:codeStr];
}


#pragma mark - 内部方法 -
- (void)createCodeWithStr:(NSString *)codeStr
{
    NSString * filerName = @"";
    if (_ysImageViewType == YSCodeImageViewTypeQR) {
        
        filerName = @"CIQRCodeGenerator";
        
    } else if (_ysImageViewType == YSCodeImageViewTypeBar) {
        
        filerName = @"CICode128BarcodeGenerator";
        
    }
    
    NSData * codeData = [codeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter * filer = [CIFilter filterWithName:filerName];
    [filer setValue:codeData forKey:@"inputMessage"];
    
    //上色
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    CIFilter * colorFiler = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:@"inputImage",filer.outputImage,@"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],@"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],nil];
    CIImage * image = colorFiler.outputImage;
    
    //绘制
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    self.image = codeImage;
}

@end
