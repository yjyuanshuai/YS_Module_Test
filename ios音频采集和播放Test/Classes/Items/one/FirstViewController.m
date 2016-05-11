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
@property (nonatomic, strong) UIButton * oneStartOrPauseBtn;   // 开始/暂停
@property (nonatomic, strong) UIButton * threeEndBtn;   // 停止
@property (nonatomic, strong) UIButton * fourPlayBtn;   // 播放

@end

@implementation FirstViewController
{
    YSVoiceObject * _recorder;
    UIView * _audioView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize size = self.view.frame.size;
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((size.width - 80)/2, 70, 80, 80)];
    [_startBtn setImage:[UIImage imageNamed:@"one"] forState:UIControlStateNormal];
    [_startBtn setImage:[UIImage imageNamed:@"two"] forState:UIControlStateHighlighted];
    // 开始
    [_startBtn addTarget:self action:@selector(startAudio:) forControlEvents:UIControlEventTouchDown];
    // 结束
    [_startBtn addTarget:self action:@selector(endAudio:) forControlEvents:UIControlEventTouchUpInside];
    // 取消
    [_startBtn addTarget:self action:@selector(cancleAudio:) forControlEvents:UIControlEventTouchDragOutside];
    [self.view addSubview:_startBtn];
    
    
    _oneStartOrPauseBtn = [[UIButton alloc] initWithFrame:CGRectMake((size.width - 80*3)/4, 70 + 80 + 10, 80, 40)];
    [_oneStartOrPauseBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_oneStartOrPauseBtn setTitle:@"暂停" forState:UIControlStateSelected];
    _oneStartOrPauseBtn.selected = NO;
    [_oneStartOrPauseBtn setBackgroundColor:[UIColor redColor]];
    [_oneStartOrPauseBtn addTarget:self
                            action:@selector(startOrPause)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oneStartOrPauseBtn];
    
    _threeEndBtn = [[UIButton alloc] initWithFrame:CGRectMake((size.width - 80*3)/4 + CGRectGetMaxX(_oneStartOrPauseBtn.frame), 70 + 80 + 10, 80, 40)];
    [_threeEndBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_threeEndBtn setBackgroundColor:[UIColor orangeColor]];
    [_threeEndBtn addTarget:self
                            action:@selector(endFinish)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_threeEndBtn];
    
    _fourPlayBtn = [[UIButton alloc] initWithFrame:CGRectMake((size.width - 80*3)/4 + CGRectGetMaxX(_threeEndBtn.frame), 70 + 80 + 10, 80, 40)];
    [_fourPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_fourPlayBtn setBackgroundColor:[UIColor blueColor]];
    [_fourPlayBtn addTarget:self
                     action:@selector(playerAudio)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fourPlayBtn];
    
    _audioView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_oneStartOrPauseBtn.frame) + 10, size.width, size.height - CGRectGetMaxY(_oneStartOrPauseBtn.frame) - 10)];
    _audioView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_audioView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击事件
- (void)startAudio:(UIButton *)btn
{
    _recorder = [[YSVoiceObject alloc] init];
    [_recorder startAudioRecorderWithPath:@"ys201605061637.caf"];
}

- (void)endAudio:(UIButton *)btn
{
    [_recorder stopAudioRecorder];
}

- (void)cancleAudio:(UIButton *)btn
{
    [_recorder cancleAudioRecorder];
}

#pragma mark - 点击事件
- (void)startOrPause
{
    if (_oneStartOrPauseBtn.selected) {
        
        // 暂停
        
        
    } else {
        
        // 开始
        
    }
    
    _oneStartOrPauseBtn.selected = !_oneStartOrPauseBtn.selected;
}

- (void)endFinish
{

}

- (void)playerAudio
{
    
}

@end
