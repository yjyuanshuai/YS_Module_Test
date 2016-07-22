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
    UINavigationBar * navBar = self.navigationController.navigationBar;
    
    if ([navBar respondsToSelector:@selector(isHidden)]) {
        BOOL preHidden          = navBar.isHidden;
        [self insertIntoDicWithValidData:@(preHidden) key:preNavBarHidden];
    }
    
    if ([navBar respondsToSelector:@selector(isTranslucent)]) {
        BOOL preTranslucent     = navBar.translucent;
        [self insertIntoDicWithValidData:@(preTranslucent) key:preNavBarTranslucent];
    }
    
    if ([navBar respondsToSelector:@selector(barStyle)]) {
        UIBarStyle preBarStyle  = navBar.barStyle;
        [self insertIntoDicWithValidData:@(preBarStyle) key:preNavBarStyle];
    }
    
    if ([navBar respondsToSelector:@selector(titleTextAttributes)]) {
        NSDictionary * preTitleTextAttributes = navBar.titleTextAttributes;
        [self insertIntoDicWithValidData:preTitleTextAttributes key:preNavBarTranslucent];
    }
    
    if ([navBar respondsToSelector:@selector(tintColor)]) {
        UIColor * preTintColor          = navBar.tintColor ;
        [self insertIntoDicWithValidData:preTintColor key:preNavBarTintColor];
    }
    
    if ([navBar respondsToSelector:@selector(barTintColor)]) {
        UIColor * preBarTintColor       = navBar.barTintColor;
        [self insertIntoDicWithValidData:preBarTintColor key:preNavBarbarTintColor];
    }
    
    if ([navBar respondsToSelector:@selector(shadowImage)]) {
        UIImage * preShaowImage = navBar.shadowImage;
        [self insertIntoDicWithValidData:preShaowImage key:preNavBarShadowImage];
    }
    if ([navBar respondsToSelector:@selector(backIndicatorImage)]) {
        UIImage * preBackIndicatorImage = navBar.backIndicatorImage;
        [self insertIntoDicWithValidData:preBackIndicatorImage key:preNavBarBackIndicatorImage];
    }
    if ([navBar respondsToSelector:@selector(backIndicatorTransitionMaskImage)]) {
        UIImage * preBackIndicatorTransitionMaskImage = navBar.backIndicatorTransitionMaskImage;
        [self insertIntoDicWithValidData:preBackIndicatorTransitionMaskImage key:preNavBarBackIndicatorTransitionMaskImage];
    }
}

- (void)insertIntoDicWithValidData:(id)navProperty key:(NSString *)navKey
{
    if (navProperty != nil) {
        [_preNavigationBarDic setObject:navProperty forKey:navKey];
    }
}

// 设置当前页面的
- (void)setNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    _navBarBackImageView = self.navigationController.navigationBar.subviews.firstObject;
    _navBarBackImageView.backgroundColor = [UIColor orangeColor];
    _navBarBackImageView.alpha = 0.0;
}

// 重置
- (void)resetNavigationBar
{
    self.navigationController.navigationBar.hidden = [_preNavigationBarDic[preNavBarHidden] boolValue];
    self.navigationController.navigationBar.barStyle = [_preNavigationBarDic[preNavBarStyle] integerValue];
    self.navigationController.navigationBar.translucent = [_preNavigationBarDic[preNavBarTranslucent] boolValue];
    
    if (_preNavigationBarDic[preNavBarTitleTextAttributes] != nil) {
        self.navigationController.navigationBar.titleTextAttributes = _preNavigationBarDic[preNavBarTitleTextAttributes];
    }
    if (_preNavigationBarDic[preNavBarbarTintColor] != nil) {
        self.navigationController.navigationBar.barTintColor = _preNavigationBarDic[preNavBarbarTintColor];
    }
    if (_preNavigationBarDic[preNavBarTintColor] != nil) {
        self.navigationController.navigationBar.tintColor = _preNavigationBarDic[preNavBarTintColor];
    }
    if (_preNavigationBarDic[preNavBarShadowImage] != nil) {
        self.navigationController.navigationBar.shadowImage = _preNavigationBarDic[preNavBarShadowImage];
    }
    if (_preNavigationBarDic[preNavBarBackIndicatorImage] != nil) {
        self.navigationController.navigationBar.backIndicatorImage = _preNavigationBarDic[preNavBarBackIndicatorImage];
    }
    if (_preNavigationBarDic[preNavBarBackIndicatorTransitionMaskImage] != nil) {
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = _preNavigationBarDic[preNavBarBackIndicatorTransitionMaskImage];
    }
}

#pragma mark -
- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
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
