//
//  FirstViewController.m
//  ios音频采集和播放Test
//
//  Created by YJ on 16/5/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FirstViewController.h"
#import "YSVoiceObject.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIButton * startBtn;      // 录音按钮


/***    分开控制    ****/
@property (nonatomic, strong) UIButton * oneStartBtn;   // 开始
@property (nonatomic, strong) UIButton * twoPauseBtn;   // 暂停
@property (nonatomic, strong) UIButton * threeEndBtn;   // 停止
@property (nonatomic, strong) UIButton * fourPlayBtn;   // 播放

@end

@implementation FirstViewController
{
    YSVoiceObject * _audioObj;
    YSAudioModel * _audioModel;
    UIView * _audioView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _audioObj = [[YSVoiceObject alloc] init];
    
    CGSize size = self.view.frame.size;
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((size.width - 80)/2, 70, 80, 80)];
    [_startBtn setImage:[UIImage imageNamed:@"one"] forState:UIControlStateNormal];
    [_startBtn setImage:[UIImage imageNamed:@"two"] forState:UIControlStateHighlighted];
    // 开始
    [_startBtn addTarget:self action:@selector(startAudio:) forControlEvents:UIControlEventTouchDown];
    // 结束
    [_startBtn addTarget:self action:@selector(endAudio:) forControlEvents:UIControlEventTouchUpInside];
    // 取消
//    [_startBtn addTarget:self action:@selector(cancleAudio:) forControlEvents:UIControlEventTouchDragOutside];
    [self.view addSubview:_startBtn];
    
    
    CGFloat space = (size.width - 60*4)/5;
    CGFloat width = 60;
    _oneStartBtn = [[UIButton alloc] initWithFrame:CGRectMake(space, 70 + 80 + 10, width, 40)];
    [_oneStartBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_oneStartBtn setBackgroundColor:[UIColor redColor]];
    [_oneStartBtn addTarget:self
                     action:@selector(startRecord:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oneStartBtn];
    
    _twoPauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_oneStartBtn.frame) +  space, 70 + 80 + 10, width, 40)];
    [_twoPauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [_twoPauseBtn setBackgroundColor:[UIColor redColor]];
    [_twoPauseBtn addTarget:self
                     action:@selector(pauseAudio:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_twoPauseBtn];

    _threeEndBtn = [[UIButton alloc] initWithFrame:CGRectMake(space + CGRectGetMaxX(_twoPauseBtn.frame), 70 + 80 + 10, width, 40)];
    [_threeEndBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_threeEndBtn setBackgroundColor:[UIColor orangeColor]];
    [_threeEndBtn addTarget:self
                     action:@selector(endAudio:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_threeEndBtn];
    
    _fourPlayBtn = [[UIButton alloc] initWithFrame:CGRectMake(space + CGRectGetMaxX(_threeEndBtn.frame), 70 + 80 + 10, width, 40)];
    [_fourPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_fourPlayBtn setBackgroundColor:[UIColor blueColor]];
    [_fourPlayBtn addTarget:self
                     action:@selector(playerAudio:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fourPlayBtn];
    
    _audioView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_oneStartBtn.frame) + 10, size.width, size.height - CGRectGetMaxY(_oneStartBtn.frame) - 10)];
    _audioView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_audioView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击事件
- (void)startRecord:(UIButton *)btn
{
    [_audioObj startAudioRecorder];
    _audioModel = _audioObj.audioModel;
}

- (void)pauseAudio:(UIButton *)btn
{
    [_audioObj pauseAudioRecorder];
}

- (void)endAudio:(UIButton *)btn
{
    [_audioObj stopAudioRecorder];
}

- (void)playerAudio:(UIButton *)btn
{
    [_audioObj playAudio];
}

#pragma mark - 点击事件

@end
