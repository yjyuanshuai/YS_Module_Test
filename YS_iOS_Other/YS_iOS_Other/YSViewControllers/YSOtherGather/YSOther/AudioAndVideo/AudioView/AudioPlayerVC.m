//
//  AudioPlayerVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioPlayerVC.h"
#import "YSSongModel.h"
#import "ListTableViewCell.h"

dispatch_queue_t serialQueue;


static NSString * const ListCellID = @"ListCellID";

@interface AudioPlayerVC ()<AVAudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource>

//------------------//
@property (nonatomic, strong) NSTimer * ysTime;

//------------------//
@property (nonatomic, strong) YSSongModel * currentModel;

@property (nonatomic, assign) AudioPlaySetting settingType;     // 播放方式
@property (nonatomic, assign) AudioPlayStatus playStatus;       // 播放状态


//------------------//
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIScrollView * audioScrollView;
@property (nonatomic, strong) UIImageView * audioImageView;
@property (nonatomic, strong) UISlider * playProgress;
@property (nonatomic, strong) UILabel * currentTime;
@property (nonatomic, strong) UILabel * allTime;
@property (nonatomic, strong) UITableView * listTableView;

@property (nonatomic, strong) UIButton * collectionBtn;
@property (nonatomic, strong) UIButton * downloadBtn;
@property (nonatomic, strong) UIButton * volBtn;
@property (nonatomic, strong) UIButton * tempBtn;

//------------------//

@end

@implementation AudioPlayerVC
{
    NSMutableArray * _audioArr;
}

+ (AudioPlayerVC *)defaultAudioVC
{
    static AudioPlayerVC * instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self obtainCurrentSongList];
    }
    return self;
}

- (void)dealloc
{
    [self invalidTimer];
    
    if (_ysAudioPlayer) {
        [_ysAudioPlayer stop];
        _ysAudioPlayer.delegate = nil;
        _ysAudioPlayer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createUI];
    [self createShapeLayer];
    [self createUpBtn];
    [self createDownBtn];
    [self createListTableView];
    [self createProgressView];
    
    [self playOnBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*****************   控制台   *****************/
#pragma mark - 声明App接收远程控制事件
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

#pragma mark - App结束声明接收远程控制事件
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

#pragma mark - 
- (void)obtainCurrentSongList
{
    if (!_audioArr) {
        _audioArr = [@[] mutableCopy];
    }
    
    NSArray * songsArr = [NSArray arrayWithContentsOfFile:sbMedia_AudioCurrentPlist];
    for (NSData * songData in songsArr) {
        YSSongModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:songData];
        [_audioArr addObject:model];
    }
}

- (void)playOnBackground
{
    NSError * error = nil;
    NSError * activeError = nil;
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    [session setActive:YES error:&activeError];
    
    if (error) {
        DDLogInfo(@"-------- AVAudioSession setCategory error: %@", error.localizedDescription);
    }
    
    if (activeError) {
        DDLogInfo(@"-------- AVAudioSession setActive error: %@", activeError.localizedDescription);
    }
}

- (void)createAVPlayer:(YSSongModel *)model
{
    if (_ysAudioPlayer) {
        _ysAudioPlayer = nil;
    }
    
    if (model != nil) {
        _currentModel = model;
    }
    
    // 判断音频是否已存入本地
    NSString * path = [NSString stringWithFormat:@"%@.%@", _currentModel.name, _currentModel.expandType];
    
    if ([YSFileManager fileHasExist:[sbMedia_AudioDir stringByAppendingPathComponent:path]] && !_currentModel.hasDownload) {
        _currentModel.hasDownload = YES;
    }
    else if (![YSFileManager fileHasExist:[sbMedia_AudioDir stringByAppendingPathComponent:path]] && _currentModel.hasDownload) {
        _currentModel.hasDownload = NO;
    }
    
    if (_currentModel.hasDownload) {
        
        //创建串行队列 (放入线程中,免得页面假死)
        serialQueue = dispatch_queue_create("com.yjyuanshuai.auido", DISPATCH_QUEUE_SERIAL);
        dispatch_async(serialQueue, ^{
            
            NSData * audioData = (NSData *)[YSFileManager readDataFromFile:[sbMedia_AudioDir stringByAppendingPathComponent:path] dataType:[NSData class]];
            
            NSError * error = nil;
            
            _ysAudioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
            //        _ysAudioPlayer.numberOfLoops = -1;      // 循环
            _ysAudioPlayer.delegate = self;
            [_ysAudioPlayer prepareToPlay];
            [_ysAudioPlayer play];
            
            if (error) {
                NSLog(@"------------- AVAudioPlayer - Local - Error: %@", error.localizedDescription);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self creataTimer];
                
                NSString * str = [self turnIntoTimeWithTimeInterval:_ysAudioPlayer.duration];
                _allTime.text = str;
                _playProgress.maximumValue = _ysAudioPlayer.duration;
                _downloadBtn.selected = YES;
            });
            
        });
        
    }
    else {
        
        serialQueue = dispatch_queue_create("com.yjyuanshuai.auido", DISPATCH_QUEUE_SERIAL);
        dispatch_async(serialQueue, ^{
        
            NSData * audioData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_currentModel.url]];
            NSError * error = nil;
            
            _ysAudioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
            _ysAudioPlayer.delegate = self;
            [_ysAudioPlayer prepareToPlay];
            [_ysAudioPlayer play];
            
            if (error) {
                NSLog(@"------------- AVAudioPlayer - Web - Error: %@", error.localizedDescription);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self creataTimer];
                
                NSString * str = [self turnIntoTimeWithTimeInterval:_ysAudioPlayer.duration];
                _allTime.text = str;
                _playProgress.maximumValue = _ysAudioPlayer.duration;
                _downloadBtn.selected = NO;
            });
        
        });
    }
}

- (void)updateSongInfo:(YSSongModel *)model
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = model.name;
        [_listTableView reloadData];
    });
}

- (void)creataTimer
{
    [self invalidTimer];
    
    _ysTime = [NSTimer scheduledTimerWithTimeInterval:0.1
                                               target:self
                                             selector:@selector(ysPlayTimer)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_ysTime forMode:NSRunLoopCommonModes];
}

- (void)invalidTimer
{
    if (_ysTime) {
        [_ysTime invalidate];
        _ysTime = nil;
    }
}

#pragma mark - set
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    [self createAVPlayer:_audioArr[_currentIndex]];
    [self updateSongInfo:_audioArr[_currentIndex]];
}

#pragma mark - time update
- (void)ysPlayTimer
{
    _currentTime.text = [self turnIntoTimeWithTimeInterval:_ysAudioPlayer.currentTime];
    
    if (_playProgress.state == UIControlStateNormal) {
        [_playProgress setValue:_ysAudioPlayer.currentTime animated:YES];
    }
}

#pragma mark -- 接受控制台的控制事件
- (void)remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        //判断点击按钮的类型
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlPlay:
                [self.ysAudioPlayer play];  //播放
                break;
            case UIEventSubtypeRemoteControlPause:
                [self.ysAudioPlayer pause]; //暂停
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self playFrontSong]; //播放上一首
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self playNextSong];  //播放下一首
                break;
            default:
                break;
        }
    }
}

#pragma mark - AVAudioPlayerDelegate
// 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"++++++++++++++++ 播放完成！");
        
        [self invalidTimer];
        [_ysAudioPlayer stop];
        _ysAudioPlayer = nil;
        
        
        if (_settingType == AudioPlaySettingOne) {
            
            [self createAVPlayer:_audioArr[_currentIndex]];
            [self updateSongInfo:_audioArr[_currentIndex]];
            
        }
        else if (_settingType == AudioPlaySettingList) {
            
            if (_currentIndex < [_audioArr count] - 1) {
                _currentIndex++;
            }
            else {
                _currentIndex = 0;
            }
            [self createAVPlayer:_audioArr[_currentIndex]];
            [self updateSongInfo:_audioArr[_currentIndex]];
            
        }
        else if (_settingType == AudioPlaySettingAny){
            
            // 随机播放
            NSInteger anyIndex = arc4random()%[_audioArr count];
            while (anyIndex == _currentIndex) {
                anyIndex = arc4random()%[_audioArr count];
            }
            _currentIndex = anyIndex;
            
            [self createAVPlayer:_audioArr[_currentIndex]];
            [self updateSongInfo:_audioArr[_currentIndex]];
            
        }
        
    }
    else {
        
    }
    
}

// 后台播放被打断, 继续恢复播放 (比如打电话...)
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    [self.ysAudioPlayer play];
}

#pragma mark - UI
- (void)initUIAndData
{
    _currentIndex = 0;
    
    if ([_audioArr count] > 0) {
        _currentModel = _audioArr[_currentIndex];
        self.title = _currentModel.name;
    }
    else {
        self.title = @"音乐播放";
    }
    
    _settingType = AudioPlaySettingList;
    _playStatus = AudioPlayStatusPlaying;
}

- (void)createUI
{
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"audioPlayer_bg" ofType:@"jpg"]];
    [self.view addSubview:_bgImageView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
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
    shapeLayer.fillColor = YSColorDefault.CGColor;
    shapeLayer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
}

- (void)createUpBtn
{
    _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateSelected];
    [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_loved_dis"] forState:UIControlStateDisabled];
    [_collectionBtn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_collectionBtn];
    
    _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    [_downloadBtn addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadBtn];
    
    _volBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_volBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_vol_speaker"] forState:UIControlStateNormal];
    [_volBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_vol_speaker"] forState:UIControlStateSelected];
    [_volBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_vol_speaker"] forState:UIControlStateDisabled];
    [_volBtn addTarget:self action:@selector(clickCollectionBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_volBtn];
    
    _tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tempBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateNormal];
    [_tempBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dlded_prs"] forState:UIControlStateSelected];
    [_tempBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_dld_dis"] forState:UIControlStateDisabled];
    [_tempBtn addTarget:self action:@selector(clickDownloadBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tempBtn];
    
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.left.equalTo(self.view).mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    CGFloat space = (kScreenWidth - 30 - 4*40)/3;
    
    [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(_collectionBtn).mas_equalTo(space + 40);
    }];
    
    [_volBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(_downloadBtn).mas_equalTo(space + 40);
    }];
    
    [_tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_equalTo(-120);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(_volBtn).mas_equalTo(space + 40);
    }];
}

- (void)createDownBtn
{
    // 播放设置
    UIButton * playOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_settingType == AudioPlaySettingOne) {
        [playOrderBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateNormal];
    }
    else if (_settingType == AudioPlaySettingList) {
        [playOrderBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateNormal];
    }
    else if (_settingType == AudioPlaySettingAny){
        [playOrderBtn setBackgroundImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateNormal];
    }
    [playOrderBtn addTarget:self action:@selector(clickToPlayOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playOrderBtn];
    
    // 前一首
    UIButton * frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [frontBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateNormal];
    [frontBtn addTarget:self action:@selector(clickToFront:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:frontBtn];
    frontBtn.transform = CGAffineTransformMakeRotation(M_PI);
    
    // 播放 、 暂停
    UIButton * playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_playStatus == AudioPlayStatusPause) {
        [playOrPauseBtn setBackgroundImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateNormal];
    }
    else {
        [playOrPauseBtn setBackgroundImage:[UIImage imageNamed:@"cm2_btn_pause"] forState:UIControlStateNormal];
        
    }
    [playOrPauseBtn addTarget:self action:@selector(clickToPlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playOrPauseBtn];
    
    // 后一首
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(clickToNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    // 播放列表
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

- (void)createListTableView
{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = UITableViewAutomaticDimension;
    _listTableView.estimatedRowHeight = 80;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _listTableView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    _listTableView.tableFooterView = [UIView new];
    _listTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _listTableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, 300));
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10-40);
    }];
    
    [_listTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:ListCellID];
    
    _listTableView.hidden = YES;
}

- (void)createProgressView
{
    _currentTime = [UILabel new];
    _currentTime.backgroundColor = [UIColor clearColor];
    _currentTime.textColor = [UIColor whiteColor];
    _currentTime.font = [UIFont systemFontOfSize:14.0];
    _currentTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_currentTime];
    
    _allTime = [UILabel new];
    _allTime.backgroundColor = [UIColor clearColor];
    _allTime.textColor = [UIColor whiteColor];
    _allTime.font = [UIFont systemFontOfSize:14.0];
    _allTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_allTime];
    
    _playProgress = [UISlider new];
    _playProgress.minimumTrackTintColor = [UIColor lightGrayColor];
    _playProgress.maximumTrackTintColor = [UIColor whiteColor];
    _playProgress.value = 0.0;
    _playProgress.minimumValue = 0.0;
    _playProgress.maximumValue = 1.0;
//    _playProgress.maximumValue = _ysAudioPlayer.duration;
    _playProgress.continuous = YES; //设置只有在离开滑动条的最后时刻才触发滑动事件 默认是YES
    //    [_playProgress setThumbImage:[UIImage imageNamed:@"cm2_fm_btn_love"] forState:UIControlStateNormal];
    [_playProgress setThumbImage:[UIImage imageNamed:@"cm2_fm_btn_loved"] forState:UIControlStateHighlighted];
    [_playProgress addTarget:self action:@selector(changeSliderValue:) forControlEvents:UIControlEventValueChanged];
    //    [_playProgress addTarget:self action:@selector(stopSlider:) forControlEvents:UIControlEventTouchDown];
    //    [_playProgress addTarget:self action:@selector(startSlider:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_playProgress];
    
    [_currentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.left.equalTo(self.view).with.offset(5);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    [_playProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 110, 20));
        make.left.equalTo(_currentTime).with.offset(5 + 45);
        make.centerY.equalTo(_currentTime).with.offset(0);
    }];
    
    [_allTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 20));
        make.right.equalTo(self.view).with.offset(-5);
        make.centerY.equalTo(_currentTime).with.offset(0);
    }];
}

#pragma mark - click
- (void)changeSliderValue:(id)sender
{
    UISlider * slider = (UISlider *)sender;
    
    [_ysAudioPlayer setCurrentTime:slider.value];
}

- (void)stopSlider:(id)sender
{
    
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
    if (_settingType == AudioPlaySettingOne) {
        // 单首 -> 顺序
        _settingType = AudioPlaySettingList;
        [sender setBackgroundImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateNormal];
    }
    else if (_settingType == AudioPlaySettingList) {
        // 顺序 -> 随机
        _settingType = AudioPlaySettingAny;
        [sender setBackgroundImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateNormal];
    }
    else if (_settingType == AudioPlaySettingAny){
        // 随机 -> 单首
        _settingType = AudioPlaySettingOne;
        [sender setBackgroundImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateNormal];
    }
}

- (void)clickToFront:(UIButton *)sender
{
    [self playFrontSong];
}

- (void)clickToPlayOrPause:(UIButton *)sender
{
    if (_playStatus == AudioPlayStatusPlaying) {
        // 暂停
        _playStatus = AudioPlayStatusPause;
        [_ysAudioPlayer pause];
        
        // 暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
        _ysTime.fireDate = [NSDate distantFuture];
        
        // 更新图片
        [sender setBackgroundImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateNormal];
    }
    else {
        // 开始播放
        _playStatus = AudioPlayStatusPlaying;
        [_ysAudioPlayer play];
        
        // 恢复定时器
        _ysTime.fireDate = [NSDate distantPast];
        
        // 更新图片
        [sender setBackgroundImage:[UIImage imageNamed:@"cm2_btn_pause"] forState:UIControlStateNormal];
    }
}

- (void)clickToNext:(UIButton *)sender
{
    [self playNextSong];
}

- (void)playFrontSong
{
    // 上一首
    if (_currentIndex > 0) {
        _currentIndex--;
    }
    else {
        _currentIndex = [_audioArr count] - 1;
    }
    [self createAVPlayer:_audioArr[_currentIndex]];
    [self updateSongInfo:_audioArr[_currentIndex]];
}

- (void)playNextSong
{
    // 下一首
    if (_currentIndex < [_audioArr count] - 1) {
        _currentIndex ++;
        
    }
    else {
        _currentIndex = 0;
    }
    
    [self createAVPlayer:_audioArr[_currentIndex]];
    [self updateSongInfo:_audioArr[_currentIndex]];
}

- (void)clickToList:(UIButton *)sender
{
    _listTableView.hidden = !_listTableView.hidden;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_audioArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    
    if (_currentIndex == indexPath.row) {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.8];
    }
    else {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    }
    
    [cell setListCellContent:_audioArr[indexPath.row] time:@"" ];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:ListCellID cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setListCellContent:_audioArr[indexPath.row] time:@""];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_currentIndex != indexPath.row) {
        
        _currentIndex = indexPath.row;
        YSSongModel * model = _audioArr[indexPath.row];
        [self createAVPlayer:model];
        [self updateSongInfo:model];
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

#pragma mark - private
- (NSString *)turnIntoTimeWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSInteger min = floorf(timeInterval) / 60;
    NSInteger sec = floorf(timeInterval) - min * 60;
    
    return [NSString stringWithFormat:@"%.2ld:%.2ld", min, sec];
}

@end