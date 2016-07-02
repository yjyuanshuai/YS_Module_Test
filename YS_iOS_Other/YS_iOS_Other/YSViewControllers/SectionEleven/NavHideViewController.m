//
//  NavHideViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NavHideViewController.h"

@interface NavHideViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * navHideTableView;

@end

@implementation NavHideViewController
{
    BOOL currentNavBarHidden;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _navHideTableView.delegate = self;  //
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _navHideTableView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"导航栏显示与隐藏";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)initTableView
{
    _navHideTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _navHideTableView.delegate = self;
    _navHideTableView.dataSource = self;
    _navHideTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_navHideTableView];
    
    [_navHideTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    _navHideTableView.tableHeaderView = tempView;
    
    UIImageView * imageView = [UIImageView new];
    [tempView addSubview:imageView];
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    imageView.backgroundColor = [UIColor redColor];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
        make.left.equalTo(tempView.mas_left).offset(0);
        make.top.equalTo(tempView.mas_top).offset(0);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = @"上拉隐藏下拉显示（不松手）";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _navHideTableView.contentInset.top;
    CGFloat gesureY = [scrollView.panGestureRecognizer translationInView:_navHideTableView].y;
    
    if (offsetY > 64) {
        if (gesureY > 0) {  //下滑
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            
        } else {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
        }
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    
}

@end
