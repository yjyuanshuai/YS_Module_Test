//
//  RootViewController.m
//  YiBaoHttpRequestTest
//
//  Created by YJ on 16/1/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RootViewController
{
    // test
    UITableView * _doctorList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableView
{
    _doctorList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kScreenHeightNoStatus) style:UITableViewStylePlain];
    _doctorList.delegate = self;
    _doctorList.dataSource = self;
    [self.view addSubview:_doctorList];
}

#pragma mark - test 获取我的大夫列表
- (void)testForGetDoctor
{
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
