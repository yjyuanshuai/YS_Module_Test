//
//  JianShuNavAnimationViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JianShuNavAnimationViewController.h"
#import "NavHideViewController.h"
#import "NavHeadViewViewController.h"

@interface JianShuNavAnimationViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * jianshuTableView;
@property (nonatomic, strong) UIImageView * navBarBackImageView;

@end

@implementation JianShuNavAnimationViewController
{
    NSArray * _navAnimationArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self initTableView];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _jianshuTableView.delegate = self;  //
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _jianshuTableView.delegate = nil;   // 释放delegate
    
    // 消除此页面设置的navigationBar
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    _navBarBackImageView.backgroundColor = [UIColor clearColor];
}

- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    _navBarBackImageView = self.navigationController.navigationBar.subviews.firstObject;
    _navBarBackImageView.backgroundColor = [UIColor orangeColor];
    _navBarBackImageView.alpha = 0.0;
    
    
    _navAnimationArr = @[@"导航栏隐藏", @"导航栏头像缩放", @"导航栏隐藏"];
}

- (void)initTableView
{
    _jianshuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _jianshuTableView.delegate = self;
    _jianshuTableView.dataSource = self;
    _jianshuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_jianshuTableView];
    
    [_jianshuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    _jianshuTableView.tableHeaderView = tempView;
    tempView.backgroundColor = [UIColor redColor];

    UIImageView * imageView = [UIImageView new];
    [tempView addSubview:imageView];
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
        make.left.equalTo(tempView.mas_left).offset(0);
        make.top.equalTo(tempView.mas_top).offset(0);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_navAnimationArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = _navAnimationArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        NavHideViewController * navHideVC = [[NavHideViewController alloc] init];
        [self.navigationController pushViewController:navHideVC animated:YES];
    } else if (indexPath.row == 1) {
        NavHeadViewViewController * navHeadViewVC = [[NavHeadViewViewController alloc] init];
        [self.navigationController pushViewController:navHeadViewVC animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat miniAlphaOffset = 0;  // 下拉的高度
    CGFloat maxAlphaOffset = 50;    // 上拉的高度
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - miniAlphaOffset)/(maxAlphaOffset - miniAlphaOffset);
    
    _navBarBackImageView.alpha = alpha;
}

@end
