//
//  CustemSearchViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CustemSearchViewController.h"
#import "YSSearchBarView.h"

@interface CustemSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar * ysSearchBar;
@property (nonatomic, strong) UISearchBar * ysSearchBar2;

@end

@implementation CustemSearchViewController
{
    YSSearchBarView * _ysSearchObject;
    YSSearchBarView * _ysSearchObject2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self setupSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"右键" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setupSearchBar
{
//    _ysSearchBar = [[UISearchBar alloc] init];
//    _ysSearchBar.placeholder = @"searchbar";
//    _ysSearchBar.showsCancelButton = NO;
//    _ysSearchBar.delegate = self;
//    
//    _ysSearchObject = [[YSSearchBarView alloc] initWithSearchBar:_ysSearchBar viewController:self];
//    _ysSearchObject.isShowInNavigationBar = YES;
    
    
    _ysSearchBar2 = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 40)];
    _ysSearchBar2.placeholder = @"searchbar2";
    _ysSearchBar2.showsCancelButton = NO;
    _ysSearchBar2.delegate = self;
    
    _ysSearchObject2 = [[YSSearchBarView alloc] initWithSearchBar:_ysSearchBar2 viewController:self];
    _ysSearchObject2.isShowInNavigationBar = NO;
}

- (void)clickRightBtn
{
    NSLog(@"---------------------");
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - YSSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_ysSearchObject begainSearchAndShowPushView];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_ysSearchObject cancleSearchAndHidePushView];
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}

@end
