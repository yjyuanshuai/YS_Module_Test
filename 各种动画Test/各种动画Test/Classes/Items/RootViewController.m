//
//  RootViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RootViewController.h"
#import "Masonry.h"
#import "PictureAnimateViewController.h"
#import "TwoDemotionViewController.h"
#import "ThreeDemotionViewController.h"
#import "TurnPageViewController.h"
#import "ViewSimpleViewController.h"
#import "CoreAnimationViewController.h"

static NSString * cell_id = @"CELL_ID";

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation RootViewController
{
    NSMutableArray * _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [self myData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    _tableView = [UITableView new];
//    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - 
- (void)myData
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"YSAnimation" ofType:@"plist"];
    _dataArr = [NSMutableArray arrayWithContentsOfFile:path];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //帧动画
            PictureAnimateViewController * pictureVC = [[PictureAnimateViewController alloc] init];
            [self.navigationController pushViewController:pictureVC animated:YES];
        }
            break;
        case 1:
        {
            //二维动画
            TwoDemotionViewController * twoDemVC = [[TwoDemotionViewController alloc] init];
            [self.navigationController pushViewController:twoDemVC animated:YES];
        }
            break;
        case 2:
        {
            //三维动画
            ThreeDemotionViewController * threeVC = [[ThreeDemotionViewController alloc] init];
            [self.navigationController pushViewController:threeVC animated:YES];
        }
            break;
        case 3:
        {
            //翻页动画
            TurnPageViewController * turnVC = [[TurnPageViewController alloc] init];
            [self.navigationController pushViewController:turnVC animated:YES];
        }
            break;
        case 4:
        {
            // UIView 简单动画
            ViewSimpleViewController * simpleVC = [[ViewSimpleViewController alloc] init];
            [self.navigationController pushViewController:simpleVC animated:YES];
        }
            break;
        case 5:
        {
            // 核心动画
            CoreAnimationViewController * coreAnimationVC = [[CoreAnimationViewController alloc] init];
            [self.navigationController pushViewController:coreAnimationVC animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
