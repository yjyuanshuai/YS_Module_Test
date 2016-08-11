//
//  JianShuNavAnimationViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JianShuNavAnimationViewController.h"

static NSString * const preNavBarTitleTextAttributes    = @"preNavBarTitleTextAttributes";
static NSString * const preNavBarStyle                  = @"preNavBarStyle";
static NSString * const preNavBarTintColor              = @"preNavBarTintColor";
static NSString * const preNavBarbarTintColor           = @"preNavBarbarTintColor";
static NSString * const preNavBarTranslucent            = @"preNavBarTranslucent";
static NSString * const preNavBarShadowImage            = @"preNavBarShadowImage";
static NSString * const preNavBarBackIndicatorImage     = @"preNavBarBackIndicatorImage";
static NSString * const preNavBarHidden                 = @"preNavBarHidden";
static NSString * const preNavBarBackIndicatorTransitionMaskImage = @"preNavBarBackIndicatorTransitionMaskImage";

@interface JianShuNavAnimationViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * jianshuTableView;
@property (nonatomic, strong) UIImageView * navBarBackImageView;
@property (nonatomic, strong) NSMutableDictionary * preNavigationBarDic;

@end

@implementation JianShuNavAnimationViewController
{
    NSArray * _navAnimationArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self savePreNavigationBar];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _jianshuTableView.delegate = self;  //
    [self setNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _jianshuTableView.delegate = nil;   // 释放delegate
    [self resetNavigationBar];
}

#pragma mark -
// 存储上一个页面的
- (void)savePreNavigationBar
{
    
}

// 设置当前页面的
- (void)setNavigationBar
{
    
}

// 重置
- (void)resetNavigationBar
{
    
}

#pragma mark -
- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navAnimationArr = @[@"1手指-改颜色", @"2手指-隐藏", @"3手指-头像缩放"];
}

- (void)initTableView
{
    _jianshuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _jianshuTableView.delegate = self;
    _jianshuTableView.dataSource = self;
    _jianshuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_jianshuTableView];
    
    [_jianshuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
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
