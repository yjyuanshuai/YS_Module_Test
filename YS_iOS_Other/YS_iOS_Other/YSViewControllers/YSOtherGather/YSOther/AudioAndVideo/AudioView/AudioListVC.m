//
//  LocalAudioPlayerVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioListVC.h"
#import "YSSongModel.h"
#import "AudioOrVideoTableViewCell.h"
#import "YSPlayViewController.h"

static NSString * const AudioListCellID = @"AudioListCellID";

@interface AudioListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * audioListTableView;

@end

@implementation AudioListVC
{
    AudioListType _type;
    NSMutableArray * _audioArr;
}

- (instancetype)initWithTitle:(NSString *)title audioListType:(AudioListType)type
{
    if (self = [super init]) {
        
        self.title = title;
        _type = type;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self analysisData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _audioArr = [@[] mutableCopy];
}

- (void)createTableView
{
    _audioListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _audioListTableView.delegate = self;
    _audioListTableView.dataSource = self;
    [self.view addSubview:_audioListTableView];
    
    [_audioListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_audioListTableView registerClass:[AudioOrVideoTableViewCell class] forCellReuseIdentifier:AudioListCellID];
}

- (void)analysisData
{
    if (_type == AudioListTypeWeb) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"WebAudioList" ofType:@"plist"];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        
        NSDictionary * webDic = [arr firstObject];
        NSArray * webArr = webDic[@"webAudioArr"];
        for (NSDictionary * audioDic in webArr) {
            YSSongModel * model = [[YSSongModel alloc] initWithWebSongDic:audioDic];
            [_audioArr addObject:model];
        }
        
    }
    else if (_type == AudioListTypeLocalPlay_Music) {
    
        NSString * path = [[NSBundle mainBundle] pathForResource:@"WebAudioList" ofType:@"plist"];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        
        NSDictionary * localDic = [arr objectAtIndex:1];
        NSArray * localArr = localDic[@"localAudioArr"];
        for (NSDictionary * audioDic in localArr) {
            YSSongModel * model = [[YSSongModel alloc] initWithWebSongDic:audioDic];
            [_audioArr addObject:model];
        }
        
    }
    else if (_type == AudioListTypeLocalPlay_SystemMusic) {
    
    }
    else if (_type == AudioListTypeLocalPlay_SystemSound) {
        
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_audioArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioOrVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AudioListCellID];
    
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_Music ||
        _type == AudioListTypeLocalPlay_SystemMusic) {
        
        YSSongModel * songModel = _audioArr[indexPath.row];
        
        [cell setCellContent:CellTypeAudio model:songModel];
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (_type) {
        case AudioListTypeLocalPlay_SystemSound:
        {
            YSPlayViewController * localMusicVC = [[YSPlayViewController alloc] initWithAudioType:AudioTypeLocal list:_audioArr currentIndex:indexPath.row];
            [self.navigationController pushViewController:localMusicVC animated:YES];
        }
            break;
        case AudioListTypeLocalPlay_Music:
        {
            YSPlayViewController * localMusicVC = [[YSPlayViewController alloc] initWithAudioType:AudioTypeLocal list:_audioArr currentIndex:indexPath.row];
            [self.navigationController pushViewController:localMusicVC animated:YES];
        }
            break;
        case AudioListTypeLocalPlay_SystemMusic:
        {
            
        }
            break;
        case AudioListTypeLoaclMake:
        {
            
        }
            break;
        case AudioListTypeWeb:
        {
            
        }
            break;
    }
}

@end
