//
//  RootViewController.m
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"
#import "YSEmptyDataSourceAndDelegate.h"
#import "YSDataSourceAndDelegate.h"

@interface RootViewController ()
@end

@implementation RootViewController
{
    YSDataSourceAndDelegate * _dataSource;
    UITableView * _tableView;
    YSEmptyDataSourceAndDelegate * _emptyDelegate;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initYSDelegate];
    [self initYSEmptyDelegate];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    UIButton * one = [UIButton buttonWithType:UIButtonTypeCustom];
    one.frame = CGRectMake(10, 20, 100, 30);
    one.backgroundColor = [UIColor blackColor];
    [self.view addSubview:one];
    
    UIButton * two = [UIButton buttonWithType:UIButtonTypeCustom];
    two.frame = CGRectMake(120, 20, 100, 30);
    two.backgroundColor = [UIColor blueColor];
    [self.view addSubview:two];
}



- (void)initTableView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel * noMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 30)];
    noMsg.text = @"您暂未发起留言，请找大夫留言";
    noMsg.textColor = [UIColor lightGrayColor];
    noMsg.textAlignment = NSTextAlignmentCenter;
    noMsg.font = [UIFont systemFontOfSize:18.0];
    [view addSubview:noMsg];
    
    UIButton * findDoctorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    findDoctorBtn.frame = CGRectMake((320-160)/2, 160, 160, 40);
    [findDoctorBtn setTitle:@"找大夫" forState:UIControlStateNormal];
    [findDoctorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [findDoctorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [findDoctorBtn setBackgroundImage:[UIImage imageNamed:@"ly_default"] forState:UIControlStateNormal];
    [findDoctorBtn setBackgroundImage:[UIImage imageNamed:@"ly_click"] forState:UIControlStateHighlighted];
    [findDoctorBtn addTarget:self action:@selector(findDoctorAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:findDoctorBtn];
    
    
    

    _emptyDelegate = [YSEmptyDataSourceAndDelegate emptyDataSetWithCustom:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + 30, 320, 480) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.delegate = _dataSource;
//    _tableView.dataSource = _dataSource;
    _tableView.emptyDataSetSource = _emptyDelegate;
//    _tableView.emptyDataSetDelegate = _emptyDelegate;
    
    [self.view addSubview:_tableView];

}

- (void)initYSDelegate
{
    // 数据
    NSArray * data = @[@"11111111",@"22222222222",@"33333333"];
    
    //
    _dataSource = [[YSDataSourceAndDelegate alloc] initWithData:data identifer:@[@"CELL_ID"]];

}

- (void)initYSEmptyDelegate
{
    //
//    _emptyDelegate = [[YSEmptyDataSourceAndDelegate alloc] initWithTitle:@"这是背景的标题" description:@"这是背景的描述"];
//    _emptyDelegate = [[YSEmptyDataSourceAndDelegate alloc] initWithImage:nil title:@"这是背景的标题" description:@"这是背景的描述"];

//    _emptyDelegate = [YSEmptyDataSourceAndDelegate emptyDataSetWithImage:nil title:@"这是背景的标题" description:@"这是背景的描述"];
    
    // @"这是背景的标题"
    // @"这是背景的描述"
}

- (void)findDoctorAction
{
    NSLog(@"--------- 点击了btn");
}


@end
