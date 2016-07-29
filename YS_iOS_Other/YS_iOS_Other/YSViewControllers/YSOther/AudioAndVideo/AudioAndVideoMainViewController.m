//
//  AudioAndVideoMainViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioAndVideoMainViewController.h"
#import "YSPlayViewController.h"

@interface AudioAndVideoMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation AudioAndVideoMainViewController
{
    NSArray * _sectionTitle;
    NSMutableArray * _datasArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sectionTitle = @[@"网络音频", @"网络视频"];
    
    NSArray * audioArr = @[];
    NSArray * videoArr = @[];
    _datasArr = [@[audioArr, videoArr] mutableCopy];
}

- (void)createTableView
{
    _mainTableView = [UITableView new];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datasArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cell_id = @"mainCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = _datasArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSPlayViewController * playerVC = [[YSPlayViewController alloc] init];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
