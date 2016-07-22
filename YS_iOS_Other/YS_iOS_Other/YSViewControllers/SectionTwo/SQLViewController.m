//
//  SQLViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SQLViewController.h"

@interface SQLViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * sqlTableView;

@end

@implementation SQLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"sql语句";
}

- (void)createTableView
{
    _sqlTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _sqlTableView.delegate = self;
    _sqlTableView.dataSource = self;
    [self.view addSubview:_sqlTableView];
}

#pragma mark - UItableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
