//
//  VideoViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "VideoViewController.h"
#import "LandScapeVideoVC.h"

static NSString * YSVideoControlCellID = @"YSVideoControlCellID";

@interface VideoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * videoTableView;

@end

@implementation VideoViewController
{
    NSArray * _dataTitleArr;
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
    self.title = @"视频";
    
    NSArray * sectionOne = @[@"视频横屏效果"];
    
    _dataTitleArr = @[sectionOne];
}

- (void)createTableView
{
    _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.tableFooterView = [UIView new];
    [self.view addSubview:_videoTableView];
    
    [_videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YSVideoControlCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for (int i = 0; i < [_dataTitleArr count]; i++) {
        if (i == section) {
            NSArray * arr = _dataTitleArr[i];
            return [arr count];
        }
    }
    return 0;
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
    if (indexPath.section == 0) {
        LandScapeVideoVC * landScapeVC = [[LandScapeVideoVC alloc] init];
        landScapeVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:landScapeVC animated:YES completion:nil];
    }
}

@end
