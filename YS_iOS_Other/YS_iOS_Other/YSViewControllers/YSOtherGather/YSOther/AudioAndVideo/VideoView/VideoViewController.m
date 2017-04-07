//
//  VideoViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "VideoViewController.h"
#import "YSVideoPlayerView.h"

static NSString * YSVideoControlCellID = @"YSVideoControlCellID";

@interface VideoViewController () <UITableViewDelegate, UITableViewDataSource, YSVideoPlayerViewDelegate>

@property (nonatomic, strong) UITableView * videoTableView;

@end

@implementation VideoViewController
{
    BOOL _isLandScape;
    NSMutableArray * _dataTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createVideoPlayerView];
    [self createTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _isLandScape = NO;
    [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithIsLandScape:NO];
    [self showSmallWindow];
    DDLogInfo(@"------- 关闭横屏");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"视频";
    _isLandScape = NO;
    _dataTitleArr = [@[] mutableCopy];
    
    NSArray * sectionOne = @[@"第一行"];
    [_dataTitleArr addObject:sectionOne];
    
    self.view.backgroundColor = [UIColor redColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
}

- (void)createVideoPlayerView
{
    YSVideoPlayerView * playerView = [YSVideoPlayerView shareVideoPlayerView];
    playerView.backgroundColor = [UIColor redColor];
    playerView.delegate = self;
    [self.view addSubview:playerView];
}

- (void)createTableView
{
    _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.tableFooterView = [UIView new];
    [self.view addSubview:_videoTableView];
    
    [_videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0.75*kScreenWidth, 0, 0, 0));
    }];
    
    [_videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YSVideoControlCellID];
    _videoTableView.backgroundColor = [UIColor yellowColor];
}

#pragma mark - 旋转屏有关
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (_isLandScape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataTitleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSVideoControlCellID];
    if (indexPath.section < [_dataTitleArr count]) {
        NSArray * sectionArr = _dataTitleArr[indexPath.section];
        if (indexPath.row < [sectionArr count]) {
            cell.textLabel.text = sectionArr[indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - YSVideoPlayerViewDelegate
- (void)clickSpaceBtn
{
    _isLandScape = !_isLandScape;
    [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithIsLandScape:_isLandScape];
    
    if (!_isLandScape) {
        // 缩小
        [self showSmallWindow];
    }
    else {
        // 全屏
        [self showFullWindow];
    }
}

- (void)clickTapGesure
{
    
}

- (void)showSmallWindow
{
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationUnknown]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    [UIView animateWithDuration:0.5 animations:^{
        
        [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithFrame:CGRectMake(0, 0, kScreenWidth, 0.75*kScreenWidth)];
        [self.view bringSubviewToFront:[YSVideoPlayerView shareVideoPlayerView]];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showFullWindow
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationUnknown]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithFrame:self.view.bounds];
        [self.view bringSubviewToFront:[YSVideoPlayerView shareVideoPlayerView]];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

@end
