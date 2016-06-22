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

@property (nonatomic, strong) UISearchController * navigationSearchCon;
@property (nonatomic, strong) UISearchController * ysSearchCon;

@end

@implementation OneSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent = NO;
    
    SearchResultViewController * searchResultVC = [[SearchResultViewController alloc] init];

    // 导航栏上的搜索
    _navigationSearchCon = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _navigationSearchCon.searchResultsUpdater = self;
    _navigationSearchCon.dimsBackgroundDuringPresentation = NO;
    _navigationSearchCon.hidesNavigationBarDuringPresentation = NO;
//    _navigationSearchCon.searchBar.frame = CGRectMake(0, 0, kScreenWidth, 44);
    [_navigationSearchCon.searchBar sizeToFit];
    _navigationSearchCon.searchBar.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = _navigationSearchCon.searchBar;

    

    // view上的搜索
    _ysSearchCon = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _ysSearchCon.searchResultsUpdater = self;
    _ysSearchCon.searchBar.delegate = self;
//    _ysSearchCon.dimsBackgroundDuringPresentation = NO;         //搜索时，背景变暗色，默认是 YES
//    _ysSearchCon.obscuresBackgroundDuringPresentation = NO;     //搜索时，背景变模糊，默认是 YES
//    _ysSearchCon.hidesNavigationBarDuringPresentation = NO;     //隐藏导航栏，默认是 YES
//    [_ysSearchCon.searchBar sizeToFit];
    _ysSearchCon.searchBar.frame = CGRectMake(0, 64, kScreenWidth, 44);
    [self.view addSubview:_ysSearchCon.searchBar];
    self.definesPresentationContext = YES;
    
    
    
    UILabel * tempLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 44+64, kScreenWidth, 90)];
    tempLable.backgroundColor = [UIColor greenColor];
    [self.view addSubview:tempLable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
