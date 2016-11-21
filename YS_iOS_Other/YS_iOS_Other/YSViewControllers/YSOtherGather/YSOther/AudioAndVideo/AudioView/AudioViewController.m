//
//  AudioViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioOrVideoTableViewCell.h"
#import "YSPlayViewController.h"
#import "YSSongModel.h"

static NSString * const autioTableViewCellID = @"autioTableViewCellID";

@interface AudioViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * audioTableView;

@end

@implementation AudioViewController
{
    NSMutableArray * _webAudiosArr;
    NSMutableArray * _localAudiosArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self analysisData];
    [self createAudioTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"音频";
    
    _webAudiosArr = [@[] mutableCopy];
    _localAudiosArr = [@[] mutableCopy];
}

- (void)createAudioTableView
{
    _audioTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _audioTableView.delegate = self;
    _audioTableView.dataSource = self;
    _audioTableView.showsVerticalScrollIndicator = NO;
    _audioTableView.tableFooterView = [UIView new];
    _audioTableView.rowHeight = UITableViewAutomaticDimension;
    _audioTableView.estimatedRowHeight = 44;
    [self.view addSubview:_audioTableView];
    
    [_audioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_audioTableView registerClass:[AudioOrVideoTableViewCell class] forCellReuseIdentifier:autioTableViewCellID];
}

- (void)analysisData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"WebAudioList" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    
    NSDictionary * webDic = [arr firstObject];
    NSArray * webArr = webDic[@"webAudioArr"];
    for (NSDictionary * audioDic in webArr) {
        YSSongModel * model = [[YSSongModel alloc] initWithWebSongDic:audioDic];
        [_webAudiosArr addObject:model];
    }
    
    NSDictionary * localDic = [arr lastObject];
    NSArray * localArr = localDic[@"localAudioArr"];
    for (NSDictionary * audioDic in localArr) {
        YSSongModel * model = [[YSSongModel alloc] initWithWebSongDic:audioDic];
        [_localAudiosArr addObject:model];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_webAudiosArr count] + 1;
    }
    return [_localAudiosArr count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioOrVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:autioTableViewCellID];
    
    YSSongModel * model = nil;
    if (indexPath.section == 0) {
        if (indexPath.row < [_webAudiosArr count]) {
            model = _webAudiosArr[indexPath.row];
            [cell setCellContent:CellTypeAudio model:model];
        }
        else {
            cell.audioNameLabel.text = @"未知列表播放";
        }
    }
    else{
        if (indexPath.row < [_localAudiosArr count]) {
            model = _localAudiosArr[indexPath.row];
            [cell setCellContent:CellTypeAudio model:model];
        }
        else {
            cell.audioNameLabel.text = @"本地列表播放";
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"网络资源";
    }
    return @"本地资源";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray * audioArr = [@[] mutableCopy];
    
    if (indexPath.section == 0) {
        if (indexPath.row < [_webAudiosArr count]) {
            YSSongModel * model = _webAudiosArr[indexPath.row];
            audioArr = [@[model] mutableCopy];
        }
        else {
            audioArr = _webAudiosArr;
        }
        
        YSPlayViewController * ysPlayAudioVC = [[YSPlayViewController alloc] initWithAudioType:AudioTypeWeb  list:audioArr];
        [self.navigationController pushViewController:ysPlayAudioVC animated:YES];
    }
    else {
        if (indexPath.row < [_webAudiosArr count]) {
            YSSongModel * model = _localAudiosArr[indexPath.row];
            audioArr = [@[model] mutableCopy];
        }
        else {
            audioArr = _localAudiosArr;
        }
        
        YSPlayViewController * ysPlayAudioVC = [[YSPlayViewController alloc] initWithAudioType:AudioTypeLocal list:audioArr];
        [self.navigationController pushViewController:ysPlayAudioVC animated:YES];
    }
}

@end
