//
//  YSSquareScanCodeViewController.m
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSquareScanCodeViewController.h"
#import "ZBarSDK.h"

@interface YSSquareScanCodeViewController ()<ZBarReaderViewDelegate>

@end

@implementation YSSquareScanCodeViewController
{
    YSSquareScanBlock _ysBlock;
    ZBarReaderView * _readerView;
}
#pragma mark -
- (instancetype)initWithBlock:(YSSquareScanBlock)block
{
    if (self = [super init]) {
        _ysBlock = block;
    }
    return self;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initZBarReaderView];
}

- (void)initZBarReaderView
{
    // 创建显示图像
    _readerView = [[ZBarReaderView alloc] init];
    _readerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _readerView.torchMode = 0;  // 关闭闪关灯
    [self.view addSubview:_readerView];
    
    // 设置扫描区域
    CGSize scanSize = CGSizeMake(200, 200);
    _readerView.scanCrop = [self getScanCrop:scanSize readerViewFrame:_readerView.frame];
//    NSLog(@"------- x: %f ------- y: %f ------- w: %f ------- h: %f", _readerView.scanCrop.origin.x, _readerView.scanCrop.origin.y, _readerView.scanCrop.size.width, _readerView.scanCrop.size.height);
    
    // 设置代理
    _readerView.readerDelegate = self;
    
    // 设置图片
    [self initImageViewWithSize:scanSize];
    
    // 二维码、条形码识别装置
    ZBarImageScanner * scanner = _readerView.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    // 启动
    [_readerView start];
}

- (void)initImageViewWithSize:(CGSize)size
{
    UIImageView * scanImageView = [[UIImageView alloc] init];
    scanImageView.center = CGPointMake(_readerView.center.x, _readerView.center.y);
    scanImageView.bounds = CGRectMake(0, 0, size.width, size.height);
    NSString * path = [[NSBundle mainBundle] pathForResource:@"QRCodeReaderScanning" ofType:@"png"];
    scanImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:scanImageView];
    [self.view bringSubviewToFront:scanImageView];
}

#pragma mark - ZBarReaderDelegate
- (void)readerView:(ZBarReaderView *)readerView
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol * symbol = nil;
    for (symbol in symbols) {
        break;
    }
    
    if (_ysBlock) {
        _ysBlock(symbol.data);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [_readerView removeFromSuperview];
}

#pragma mark - tool
- (CGRect)getScanCrop:(CGSize)size readerViewFrame:(CGRect)frame
{
    CGFloat originX = (frame.size.width - size.width)/2;
    CGFloat originY = (frame.size.height - size.height)/2;
    CGFloat sizeMini = (size.width <= size.height) ? size.width : size.height;
    
    NSLog(@"------- x: %f ------- y: %f ------- w: %f ", originX, originY, sizeMini);

    
    
    return CGRectMake(originX/frame.size.width, originY/frame.size.height, sizeMini/frame.size.width, sizeMini/frame.size.width);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
