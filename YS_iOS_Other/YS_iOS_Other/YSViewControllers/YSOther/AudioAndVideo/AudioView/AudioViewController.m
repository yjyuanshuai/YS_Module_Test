//
//  AudioViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioOrVideoTableViewCell.h"

static NSString * const autioTableViewCellID = @"autioTableViewCellID";

@interface AudioViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * audioTableView;

@end

@implementation AudioViewController
{
    NSMutableArray * _audiosArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createAudioTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"音频";
    _audiosArr = [@[@"测试1"] mutableCopy];//[NSMutableArray array];
}

- (void)createAudioTableView
{
    _audioTableView = [UITableView new];
    _audioTableView.delegate = self;
    _audioTableView.dataSource = self;
    _audioTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_audioTableView];
    
    [_audioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_audioTableView registerClass:[AudioOrVideoTableViewCell class] forCellReuseIdentifier:autioTableViewCellID];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_audiosArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioOrVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:autioTableViewCellID];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSPlayViewController * ysPlayAudioVC = [[YSPlayViewController alloc] init];
    [self.navigationController pushViewController:ysPlayAudioVC animated:YES];
}

@end
