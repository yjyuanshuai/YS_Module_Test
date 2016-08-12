//
//  JianShuNavAnimationViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JianShuNavAnimationViewController.h"
#import "UIImage+YSImageCategare.h"

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
@property (nonatomic, strong) UIImageView * headImageView;

@property (nonatomic, strong) UITableView * effectTableView;

@end

@implementation JianShuNavAnimationViewController
{
    NSArray * _navAnimationArr;
    NSInteger _touchNum;
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
    
    _jianshuTableView.delegate = self;
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
    
    _navAnimationArr = @[@"1-改颜色", @"2-隐藏", @"3-头像缩放"];
    _touchNum = 1;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"切换效果" style:UIBarButtonItemStylePlain target:self action:@selector(changeEffect)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    headView.backgroundColor = [UIColor orangeColor];
    
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"11"];
    _headImageView.layer.cornerRadius = 80/2;
    _headImageView.clipsToBounds = YES;
    [headView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(headView).bottom.with.offset(0);
        make.centerY.equalTo(headView).with.offset()0;
    }];
    
    self.navigationItem.titleView = headView;
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
    
    
    _effectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _effectTableView.delegate = self;
    _effectTableView.dataSource = self;
    _effectTableView.hidden = YES;
    _effectTableView.rowHeight = 30;
    _effectTableView.scrollEnabled = NO;
    [self.view addSubview:_effectTableView];
    [_effectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
    }];
    
    [_effectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"other_cell_id"];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _jianshuTableView) {
        return [_navAnimationArr count]*10;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _jianshuTableView) {
        static NSString * cell_id = @"cell_id";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        if (indexPath.row < 3) {
            cell.textLabel.text = _navAnimationArr[indexPath.row];
        }
        else {
            cell.textLabel.text = @"......";
        }
        return cell;
    }
    else {
        static NSString * cell_id = @"other_cell_id";
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.textLabel.text = [NSString stringWithFormat:@"效果%d", (int)indexPath.row+1];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _effectTableView) {
        
        _touchNum = (int)indexPath.row + 1;
        _effectTableView.hidden = YES;
        [UIView animateWithDuration:0.7 animations:^{
            _jianshuTableView.contentOffset = CGPointZero;
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_touchNum == 1) {
        // 颜色
        CGFloat miniAlphaOffset = 0;
        CGFloat maxAlphaOffset = 80;
        CGFloat offset = scrollView.contentOffset.y;
        offset = (offset > maxAlphaOffset) ? maxAlphaOffset : offset;
        CGFloat alpha = (maxAlphaOffset - offset)/(maxAlphaOffset - miniAlphaOffset);
        
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
    }
    else if (_touchNum == 2) {
        // 隐藏
        CGFloat offsetY = scrollView.contentOffset.y + _jianshuTableView.contentInset.top;
        CGFloat gesureY = [scrollView.panGestureRecognizer translationInView:_jianshuTableView].y;
        
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
    else {
        // 缩放
        
    }
}

#pragma mark -
- (void)changeEffect
{
    if (_effectTableView.hidden) {
        _effectTableView.hidden = NO;
        [self.view bringSubviewToFront:_effectTableView];
    }
    else {
        _effectTableView.hidden = YES;
    }
}

@end
