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
#import "YSFileManager.h"
#import "AudioPlayerVC.h"

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
    [self obtainDataFromSandBox];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _audioArr = [@[] mutableCopy];
    
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_SystemMusic ||
        _type == AudioListTypeLocalPlay_Music) {
        
        UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"正在播放" style:UIBarButtonItemStylePlain target:self action:@selector(currentPlay)];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
}

- (void)createTableView
{
    _audioListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _audioListTableView.delegate = self;
    _audioListTableView.dataSource = self;
    _audioListTableView.tableFooterView = [UIView new];
    [self.view addSubview:_audioListTableView];
    
    [_audioListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MASAttachKeys(_audioListTableView);
    
    [_audioListTableView registerClass:[AudioOrVideoTableViewCell class] forCellReuseIdentifier:AudioListCellID];
}

- (void)analysisData
{
    if (_type == AudioListTypeWeb ||
        _type == AudioListTypeLocalPlay_Music) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"YS_iOS_Audio" ofType:@"plist"];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        
        NSDictionary * listFirstDict = [arr firstObject];
        NSArray * listFirstArr = listFirstDict[@"songlist1"];
        for (NSDictionary * audioDic in listFirstArr) {
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
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_Music ||
        _type == AudioListTypeLocalPlay_SystemMusic) {
        
        return [_audioArr count] + 1;
    }
    return [_audioArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioOrVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AudioListCellID];
    
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_Music ||
        _type == AudioListTypeLocalPlay_SystemMusic) {
        
        if (indexPath.row < [_audioArr count]) {
            YSSongModel * songModel = _audioArr[indexPath.row];
            
            [cell setCellContent:CellTypeAudio model:songModel];
            return cell;
        }
        else {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            }
            cell.textLabel.text = @"清除本地音频文件";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (_type) {
        case AudioListTypeLocalPlay_SystemSound:
        {
            
        }
            break;
        case AudioListTypeLocalPlay_Music:
        {
            if (indexPath.row < [_audioArr count]) {
                
                AudioPlayerVC * audioPlayVC = [AudioPlayerVC defaultAudioVC];
                audioPlayVC.currentIndex = indexPath.row;
                [self.navigationController pushViewController:audioPlayVC animated:YES];
                
            }
            else {
                // 清除沙盒音频文件
                BOOL deleteAll = [YSFileManager deleteAllFileOrDirectInDirect:sbMedia_AudioDir];
                if (deleteAll) {
                    DDLogInfo(@"---------- 文件删除成功！");
                }
                else {
                    DDLogInfo(@"---------- 文件删除失败！");
                }
            }
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

#pragma mark - 点击事件
- (void)currentPlay
{
    AudioPlayerVC * audioPlayVC = [AudioPlayerVC defaultAudioVC];
    [self.navigationController pushViewController:audioPlayVC animated:YES];
}

#pragma mark - 文件
- (void)obtainDataFromSandBox
{
    switch (_type) {
        case AudioListTypeLocalPlay_SystemSound:
        {
            
        }
            break;
        case AudioListTypeLocalPlay_Music:
        {
            // 将本地音频文件 写入沙盒
            [YSFileManager createDirectToPath:sbMedia_AudioDir];
            
            for (YSSongModel * songModel in _audioArr) {
                NSData * songData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:songModel.name ofType:songModel.expandType]];
                
                NSString * songPath = [NSString stringWithFormat:@"%@.%@", songModel.name, songModel.expandType];
                
                if ([YSFileManager fileHasExist:[sbMedia_AudioDir stringByAppendingPathComponent:songPath]]) {
                    DDLogInfo(@"----------- 文件已存在");
                }
                else
                {
                    [YSFileManager writeData:songData toFile:[sbMedia_AudioDir stringByAppendingPathComponent:songPath]];
                }
            }
            // 创建 歌曲分组 plist
            [YSFileManager createFiletoDes:sbMedia_AudioGroupPlist];
            
            // 创建 当前播放列表 plist
            [YSFileManager createFiletoDes:sbMedia_AudioCurrentPlist];
            
            [self writeSongsInfoToPlist];

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

- (void)writeSongsInfoToPlist
{
    // 当前播放列表 plist
    NSMutableArray * currentSongsArr = [@[] mutableCopy];
    for (YSSongModel * model in _audioArr) {
        NSData * songData = [NSKeyedArchiver archivedDataWithRootObject:model];
        [currentSongsArr addObject:songData];
    }
    
    if ([currentSongsArr count] > 0) {
        [currentSongsArr writeToFile:sbMedia_AudioCurrentPlist atomically:YES];
    }
    
    // 歌曲分组 plist
    NSArray * webPlistArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YS_iOS_Audio" ofType:@"plist"]];
    [webPlistArr writeToFile:sbMedia_AudioGroupPlist atomically:YES];
}

@end
