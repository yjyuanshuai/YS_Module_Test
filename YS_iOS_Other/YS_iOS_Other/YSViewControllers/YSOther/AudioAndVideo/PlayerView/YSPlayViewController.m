//
//  YSPlayViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YSPlayViewController () <UIScrollViewDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIScrollView * audioScrollView;
@property (nonatomic, strong) UIImageView * audioImageView;
@property (nonatomic, strong) UIProgressView * playProgress;
@property (nonatomic, strong) UILabel * currentTime;
@property (nonatomic, strong) UILabel * allTime;


@property (nonatomic, assign) AudioType type;
@property (nonatomic, strong) AVAudioPlayer * ysAudioPlayer;
@property (nonatomic, strong) NSTimer * ysTime;
@property (nonatomic, assign) NSTimeInterval currentTimeInterval;
@property (nonatomic, assign) NSTimeInterval allTimeInterval;

@end

@implementation YSPlayViewController

- (instancetype)initWithPlayType:(AudioType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createUI];
    [self createShapeLayer];
    [self createUpBtn];
    [self createDownBtn];
    [self createProgressView];
    [self createAudioPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"音乐播放器";
    _currentTimeInterval = 0.0;
    _allTimeInterval = 0.0;
}

- (void)createAudioPlayer
{
    if (_type == AudioTypeWeb) {
        
        NSError * error = nil;
        NSString * path = @"http://a.ali.dongting.com/494a44568a1c7555/1422090214/m4a_32_9/0b/0c/0b4466a12a5af34259fba0090380da0c.m4a?s=t";
        NSURL * dataUrl = [NSURL URLWithString:path];
        NSData * mydata = [[NSData alloc] initWithContentsOfURL:dataUrl];
        _ysAudioPlayer = [[AVAudioPlayer alloc] initWithData:mydata error:&error];
        
        if (error) {
            NSLog(@"----------- web play error");
        }
        
        _ysAudioPlayer.delegate = self;
        [_ysAudioPlayer prepareToPlay];
        
        // 音量（0.0 - 1.0）
        _ysAudioPlayer.volume = 0.8;
        // 时长
        _allTimeInterval = _ysAudioPlayer.duration;
        _allTime.text = [NSString stringWithFormat:@"%f", _ysAudioPlayer.duration];
        // 当前
        _currentTimeInterval = _ysAudioPlayer.currentTime;
        _currentTime.text = [NSString stringWithFormat:@"%f", _ysAudioPlayer.currentTime];
    }
    
    else {
        
        NSError * error = nil;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
        NSURL * localUrl = [NSURL fileURLWithPath:path];
        _ysAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:localUrl error:&error];
        
        if (error) {
            NSLog(@"----------- local play error");
        }
    
        _ysAudioPlayer.delegate = self;
    }
    
    [self creataTimer];
}

- (void)creataTimer
{
    _ysTime = [NSTimer scheduledTimerWithTimeInterval:0.1
                                               target:self
                                             selector:@selector(ysPlayTimer)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_ysTime forMode:NSRunLoopCommonModes];
}

#pragma mark - UI
- (void)createShapeLayer
{
    CGFloat height = 150;
    CGFloat space = 30;
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    CGPoint p1 = CGPointMake(0, self.view.frame.size.height - height);
    CGPoint p2 = CGPointMake(0, self.view.frame.size.height);
    CGPoint p3 = CGPointMake(kScreenWidth, self.view.frame.size.height);
    CGPoint p4 = CGPointMake(kScreenWidth, self.view.frame.size.height - height);
    CGPoint control1 = CGPointMake(kScreenWidth/2, self.view.frame.size.height - height - space);
    
    [bezierPath moveToPoint:p1];
    [bezierPath addLineToPoint:p2];
    [bezierPath addLineToPoint:p3];
    [bezierPath addLineToPoint:p4];
    [bezierPath addQuadCurveToPoint:p1 controlPoint:control1];
    
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
}

- (void)createUI
{
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"audioPlayer_bg" ofType:@"jpg"]];
    [self.view addSubview:_bgImageView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    _audioScrollView = [UIScrollView new];
//    _audioScrollView.delegate = self;
//    _audioScrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenWidth);
//    [self.view addSubview:_audioScrollView];
//    
//    [_audioScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(0);
//        make.left.equalTo(self.view).mas_offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
//    }];
    
    _audioImageView = [UIImageView new];
    _audioImageView.image = [UIImage imageNamed:@"audioPlayer_image"];
    _audioImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_audioImageView];
    
    [_audioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, kScreenWidth - 30));
        make.top.equalTo(self.view).mas_offset(15);
    }];
}

- (void)createUpBtn
{
    UIButton * collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateSelected];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved_dis"] forState:UIControlStateDisabled];
    [collectionBtn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    [downloadBtn addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn];
    
    UIButton * collectionBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateSelected];
    [collectionBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved_dis"] forState:UIControlStateDisabled];
    [collectionBtn2 addTarget:self action:@selector(clickCollectionBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn2];
    
    UIButton * downloadBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [downloadBtn2 setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    [downloadBtn2 addTarget:self action:@selector(clickDownloadBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadBtn2];
    
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.left.equalTo(self.view).mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    CGFloat space = (kScreenWidth - 30 - 4*40)/3;
    
    [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(collectionBtn).mas_equalTo(space + 40);
    }];
    
    [collectionBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(downloadBtn).mas_equalTo(space + 40);
    }];
    
    [downloadBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(collectionBtn2).mas_equalTo(space + 40);
    }];
}

- (void)createDownBtn
{
    UIButton * playOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playOrderBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateNormal];
    [playOrderBtn addTarget:self action:@selector(clickToPlayOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playOrderBtn];
    
    UIButton * frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [frontBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateNormal];
    [frontBtn addTarget:self action:@selector(clickToFront:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:frontBtn];
    
    UIButton * playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playOrPauseBtn setBackgroundImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateNormal];
    [playOrPauseBtn addTarget:self action:@selector(clickToPlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playOrPauseBtn];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(clickToNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UIButton * listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [listBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_list_prs"] forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(clickToList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listBtn];
    
    CGFloat spaceX = (kScreenWidth - 40*4 - 30 - 50)/4;
    CGFloat bottemX = -10;
    
    [playOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self.view).mas_equalTo(15);
        make.bottom.equalTo(self.view).mas_equalTo(bottemX);
    }];
    
    [frontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(playOrderBtn).mas_equalTo(spaceX + 40);
        make.bottom.equalTo(self.view).mas_equalTo(bottemX);
    }];
    
    [playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(frontBtn).mas_equalTo(spaceX + 40);
        make.bottom.equalTo(self.view).mas_equalTo(bottemX);
    }];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(playOrPauseBtn).mas_equalTo(spaceX + 40);
        make.bottom.equalTo(self.view).mas_equalTo(bottemX);
    }];
    
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(nextBtn).mas_equalTo(spaceX + 40);
        make.bottom.equalTo(self.view).mas_equalTo(bottemX);
    }];
}

- (void)clickCollectionBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)clickDownloadBtn:(UIButton *)sender
{
    
}

- (void)clickCollectionBtn2:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)clickDownloadBtn2:(UIButton *)sender
{
    
}

- (void)clickToPlayOrder:(UIButton *)sender
{

}

- (void)clickToFront:(UIButton *)sender
{
    
}

- (void)clickToPlayOrPause:(UIButton *)sender
{
    
}

- (void)clickToNext:(UIButton *)sender
{
    
}

- (void)clickToList:(UIButton *)sender
{
    
}

- (void)createProgressView
{
    _currentTime = [UILabel new];
    _currentTime.backgroundColor = [UIColor redColor];
    [self.view addSubview:_currentTime];
    
    _allTime = [UILabel new];
    _allTime.backgroundColor = [UIColor redColor];
    [self.view addSubview:_allTime];
    
    _playProgress = [UIProgressView new];
    _playProgress.progressViewStyle = UIProgressViewStyleBar;
    _playProgress.progressTintColor = [UIColor redColor];
    _playProgress.trackTintColor = [UIColor whiteColor];
    _playProgress.progress = 0.7;
    [self.view addSubview:_playProgress];
    
    [_currentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.left.equalTo(self.view).with.offset(5);
        make.bottom.equalTo(self.view).offset(-80);
    }];
    
    [_playProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 100, 2));
        make.left.equalTo(_currentTime).with.offset(5);
        make.centerX.equalTo(_currentTime).with.offset(0);
    }];
    
    [_allTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.right.equalTo(self.view).with.offset(-5);
        make.centerX.equalTo(_currentTime).with.offset(0);
    }];
}

#pragma mark - time update
- (void)ysPlayTimer
{
    _currentTimeInterval += 0.1;
    
    _currentTime.text = [NSString stringWithFormat:@"%f", _currentTimeInterval];
    _playProgress.progress = _currentTimeInterval / _allTimeInterval;
}

#pragma mark - AVAudioPlayerDelegate


@end
