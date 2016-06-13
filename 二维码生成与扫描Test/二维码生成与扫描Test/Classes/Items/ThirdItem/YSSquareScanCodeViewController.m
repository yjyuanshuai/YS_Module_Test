//
//  YSSquareScanCodeViewController.m
//  二维码生成与扫描Test
//
//  Created by YJ on 16/1/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSquareScanCodeViewController.h"
#import "ZBarSDK.h"

#define YS_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define YS_ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define YS_ColorRGB(r, g, b) [UIColor colorWithRed:r green:g blue:b alpha:1]
#define YS_DefaultGreen [UIColor colorWithRed:34/255.0 green:202/255.0 blue:37/255.0 alpha:1]

@interface YSSquareScanCodeViewController ()<ZBarReaderViewDelegate>

@end

@implementation YSSquareScanCodeViewController
{
    YSSquareScanBlock _ysBlock;
    CGRect _scanSquareRect;
    
    ZBarReaderView * _readerView;
    UIView * _allScreenView;
    UIImageView * _scanLine;
    
    BOOL _downMoving;   // 扫描线向下移动，yes下移，no上移
    
    NSTimer * _scanLineMoveTimer;
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
    [self initView];
    [self initData];
}

- (void)initZBarReaderView
{
    // 创建显示图像
    _readerView = [[ZBarReaderView alloc] init];
    _readerView.frame = CGRectMake(0, 0, YS_ScreenWidth, YS_ScreenHeight);
    _readerView.torchMode = 0;  // 关闭闪关灯
    [self.view addSubview:_readerView];
    
    // 设置扫描区域
    _scanSquareRect = CGRectMake((_readerView.frame.size.width - 200)/2, (_readerView.frame.size.height - 200)/2, 200, 200);
    _readerView.scanCrop = [self getScanCrop:_scanSquareRect readerViewFrame:_readerView.frame];

    // 去掉自动对焦的蓝色方框（方便后面用自定义的图片）
    ((CALayer *)[_readerView valueForKey:@"cropLayer"]).borderColor = [UIColor clearColor].CGColor;

    // 设置代理
    _readerView.readerDelegate = self;
    
    // 二维码、条形码识别装置
    ZBarImageScanner * scanner = _readerView.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    // 启动
    [_readerView start];
}

- (void)initView
{
    _allScreenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YS_ScreenWidth, YS_ScreenHeight)];
    _allScreenView.backgroundColor = [UIColor clearColor];
    
    [self initImageView];
    [self initScanLine];
    [self createAlphaBgView];
    [self initCancleScan];
    
    [self.view addSubview:_allScreenView];
    [self.view bringSubviewToFront:_allScreenView];
}

- (void)initImageView
{
    UIImageView * scanImageView = [[UIImageView alloc] initWithFrame:_scanSquareRect];
    scanImageView.image = [UIImage imageNamed:@"QRCodeReaderScanning"];
    [_allScreenView addSubview:scanImageView];
}

- (void)initScanLine
{
    _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(_scanSquareRect.origin.x, _scanSquareRect.origin.y, _scanSquareRect.size.width, 2)];
    _scanLine.image = [UIImage imageNamed:@"QRCodeReaderLine"];
    
    _scanLineMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                          target:self
                                                        selector:@selector(scanLineMove)
                                                        userInfo:nil
                                                         repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scanLineMoveTimer forMode:NSRunLoopCommonModes];
    
    [_allScreenView addSubview:_scanLine];
}

- (void)initCancleScan
{
    UILabel * cancleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_scanSquareRect) + 50, YS_ScreenWidth - 20, 40)];
    cancleLable.backgroundColor = [UIColor clearColor];
    cancleLable.text = @"将二维码/条码放入框内，即可自动扫描";
    cancleLable.textColor = [UIColor whiteColor];
    cancleLable.textAlignment = NSTextAlignmentCenter;
    cancleLable.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    [_allScreenView addSubview:cancleLable];

    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake((YS_ScreenWidth - 100)/2, CGRectGetMaxY(cancleLable.frame) + 50, 100, 40);
    cancleBtn.backgroundColor = [UIColor clearColor];
    [cancleBtn setTitle:@"取消扫描" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:YS_DefaultGreen forState:UIControlStateNormal];
    cancleBtn.layer.borderColor = YS_DefaultGreen.CGColor;
    cancleBtn.layer.borderWidth = 2;
    [cancleBtn addTarget:self action:@selector(cancleScan) forControlEvents:UIControlEventTouchUpInside];
    [_allScreenView addSubview:cancleBtn];
}

- (void)initData
{
    _downMoving = YES;
}

#pragma mark - 功能方法
- (void)cancleScan
{
    [self.navigationController popViewControllerAnimated:YES];
    if (_readerView != nil) {
        [_readerView stop];
        [_readerView removeFromSuperview];
    }
    [self invalidateScanLineMoveTimer];
}

- (void)scanLineMove
{
    // 扫描线
    CGFloat upLimit = _scanSquareRect.origin.y;
    CGFloat downLimit = _scanSquareRect.origin.y + _scanSquareRect.size.height;
    CGRect tempLineFrame = _scanLine.frame;
    
    if (tempLineFrame.origin.y + 2 >= downLimit) {
        _downMoving = NO;
    }else if (tempLineFrame.origin.y <= upLimit){
        _downMoving = YES;
    }
    
    if (_downMoving) {
        // 向下移动
        dispatch_async(dispatch_get_main_queue(), ^{
            _scanLine.frame = CGRectMake(tempLineFrame.origin.x, tempLineFrame.origin.y + 2, tempLineFrame.size.width, tempLineFrame.size.height);
        });
    }else {
        // 向上移
        dispatch_async(dispatch_get_main_queue(), ^{
            _scanLine.frame = CGRectMake(tempLineFrame.origin.x, tempLineFrame.origin.y - 2, tempLineFrame.size.width, tempLineFrame.size.height);
        });
    }
    
}

- (void)invalidateScanLineMoveTimer
{
    if (_scanLineMoveTimer) {
        [_scanLineMoveTimer invalidate];
        _scanLineMoveTimer = nil;
    }
}

/**
 *  非扫描区域，灰色半透明
 */
- (void)createAlphaBgView
{
    CGFloat w1 = YS_ScreenWidth;
    CGFloat h1 = _scanSquareRect.origin.y;
    
    CGFloat w2 = _scanSquareRect.origin.x;
    CGFloat h2 = _scanSquareRect.size.height;
    
    CGFloat x3 = YS_ScreenWidth - _scanSquareRect.origin.x;
    
    CGFloat y4 = h1 + h2;
    CGFloat h4 = YS_ScreenHeight - y4;
    
    [self createAlphaViewWithFrame:CGRectMake(0, 0, w1, h1)];
    [self createAlphaViewWithFrame:CGRectMake(0, h1, w2, h2)];
    [self createAlphaViewWithFrame:CGRectMake(x3, h1, w2, h2)];
    [self createAlphaViewWithFrame:CGRectMake(0, y4, w1, h4)];
}

- (void)createAlphaViewWithFrame:(CGRect)frame
{
    UIView * bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.7;
    [_allScreenView addSubview:bgView];
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
    [_readerView stop];
    [_readerView removeFromSuperview];
    [self invalidateScanLineMoveTimer];
}

#pragma mark - tool
- (CGRect)getScanCrop:(CGRect)rect readerViewFrame:(CGRect)frame
{
    CGFloat originX = rect.origin.x / frame.size.width;
    CGFloat originY = rect.origin.y / frame.size.height;
    CGFloat width = rect.size.width / frame.size.width;
    CGFloat height = rect.size.width / frame.size.height;

    return CGRectMake(originY, originX, height, width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
