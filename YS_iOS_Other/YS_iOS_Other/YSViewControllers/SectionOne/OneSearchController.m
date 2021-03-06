//
//  OneSearchController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneSearchController.h"
#import "SearchResultViewController.h"

@interface OneSearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView * currentTableView;
@property (nonatomic, strong) UISearchController * navigationSearchCon;
@property (nonatomic, strong) UISearchController * ysSearchCon;

@end

@implementation OneSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    [self createSearchBarInNavBar];
    [self createSearchBarInTableView];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    _currentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _currentTableView.delegate = self;
    _currentTableView.dataSource = self;
     [self.view addSubview:_currentTableView];
    
    [_currentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void)createSearchBarInNavBar
{
    SearchResultViewController * searchResultVC = [[SearchResultViewController alloc] init];
    
    // 导航栏上的搜索
    _navigationSearchCon = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _navigationSearchCon.searchResultsUpdater = self;
    _navigationSearchCon.dimsBackgroundDuringPresentation = NO;
    _navigationSearchCon.hidesNavigationBarDuringPresentation = NO;
    [_navigationSearchCon.searchBar sizeToFit];
    self.navigationItem.titleView = _navigationSearchCon.searchBar;
}

- (void)createSearchBarInTableView
{
    SearchResultViewController * searchResultVC = [[SearchResultViewController alloc] init];
    // view上的搜索
    _ysSearchCon = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _ysSearchCon.searchResultsUpdater = self;
    _ysSearchCon.searchBar.delegate = self;
    //    _ysSearchCon.dimsBackgroundDuringPresentation = NO;         //搜索时，背景变暗色，默认是 YES
    //    _ysSearchCon.obscuresBackgroundDuringPresentation = NO;     //搜索时，背景变模糊，默认是 YES
    //    _ysSearchCon.hidesNavigationBarDuringPresentation = NO;     //隐藏导航栏，默认是 YES
    //    [_ysSearchCon.searchBar sizeToFit];
    _ysSearchCon.searchBar.frame = CGRectMake(0, 64, kScreenWidth, 44);
//    [self.view addSubview:_ysSearchCon.searchBar];
//    self.definesPresentationContext = YES;
    
    _currentTableView.tableHeaderView = _ysSearchCon.searchBar;
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate -

#pragma mark - UISearchResultsUpdating -
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // UISearchController的searchBar中的内容一旦发生变化, 就会调用该方法.
}

#pragma mark - UISearchControllerDelegate -
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

#pragma mark - UISearchBarDelegate -
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

@end
