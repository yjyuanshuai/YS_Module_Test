//
//  OneSearchController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneSearchController.h"
#import "SearchResultViewController.h"
#import "UIImage+YSImageCategare.h"
#import "ApplicationSettingViewController.h"

@interface OneSearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, strong) UITableView * currentTableView;
@property (nonatomic, strong) UITableView * historyTableView;
@property (nonatomic, strong) UISearchController * navigationSearchCon;
@property (nonatomic, strong) UISearchController * ysSearchCon;
@property (nonatomic, strong) SearchResultViewController * searchResultVC;

@end

@implementation OneSearchController
{
    NSMutableArray * _dataArr;
    NSMutableArray * _historyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self initUIAndData];
    [self createSearchBarInNavBar];
    [self createSearchBarInTableView];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _dataArr = [@[@"111", @"222", @"333", @"342", @"444", @"431", @"555", @"666", @"777", @"888", @"999"] mutableCopy];
    _historyArr = [@[] mutableCopy];
}

- (void)createTableView
{
    _currentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _currentTableView.delegate = self;
    _currentTableView.dataSource = self;
     [self.view addSubview:_currentTableView];
    
    [_currentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64+44, 0, 0, 0));
    }];
    
    
    
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    _historyTableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_historyTableView];
    
    [_historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    _historyTableView.hidden = YES;
}

- (void)createSearchBarInNavBar
{
    _searchResultVC = [[SearchResultViewController alloc] init];
//    _searchResultVC.resultTableView.delegate = self;
    
    // 导航栏上的搜索
    _navigationSearchCon = [[UISearchController alloc] initWithSearchResultsController:_searchResultVC];
    _navigationSearchCon.searchResultsUpdater = self;
    _navigationSearchCon.searchBar.delegate = self;
    _navigationSearchCon.dimsBackgroundDuringPresentation = NO;
    _navigationSearchCon.hidesNavigationBarDuringPresentation = NO;
    [_navigationSearchCon.searchBar sizeToFit];
    
    self.definesPresentationContext = YES;
    
    self.navigationItem.titleView = _navigationSearchCon.searchBar;
}

- (void)createSearchBarInTableView
{
    _searchResultVC = [[SearchResultViewController alloc] init];
    
    // view上的搜索
    _ysSearchCon = [[UISearchController alloc] initWithSearchResultsController:self.searchResultVC];
    _ysSearchCon.searchResultsUpdater = self;
    _ysSearchCon.delegate = self;
    _searchResultVC.tableView.delegate = self;
    _ysSearchCon.dimsBackgroundDuringPresentation = NO;         //搜索时，背景变暗色，默认是 YES
    //    _ysSearchCon.obscuresBackgroundDuringPresentation = NO;     //搜索时，背景变模糊，默认是 YES
    //    _ysSearchCon.hidesNavigationBarDuringPresentation = NO;     //隐藏导航栏，默认是 YES
    
//    _ysSearchCon.searchBar.translucent = NO;
//    _ysSearchCon.searchBar.prompt = @"";
    _ysSearchCon.searchBar.delegate = self;
    _ysSearchCon.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [_ysSearchCon.searchBar sizeToFit];
    
//    [self.view addSubview:_ysSearchCon.searchBar];
    
    self.definesPresentationContext = YES;
//    _currentTableView.tableHeaderView = _ysSearchCon.searchBar;
    
    
    
    
    
    
    UITableView * tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tempTableView.scrollEnabled = NO;
    [self.view addSubview:tempTableView];
    
    [tempTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    tempTableView.tableHeaderView = _ysSearchCon.searchBar;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _currentTableView) {
        return [_dataArr count];
    }
    else if (tableView == _historyTableView) {
        return [_historyArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _currentTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        }
        cell.textLabel.text = _dataArr[indexPath.row];
        return cell;
    }
    else if (tableView == _historyTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCellID"];
        }
        if (indexPath.row < [_historyArr count]) {
            cell.textLabel.text = _historyArr[indexPath.row];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _historyTableView && indexPath.row < [_historyArr count]) {
        if (_ysSearchCon.active) {
            _ysSearchCon.searchBar.text = _historyArr[indexPath.row];
            
        }
        else if (_navigationSearchCon.active) {
            _navigationSearchCon.searchBar.text = _historyArr[indexPath.row];
        }
        
        _historyTableView.hidden = YES;
    }
    else {
        // 搜索结果页
        ApplicationSettingViewController * appVC = [[ApplicationSettingViewController alloc] init];
        [self.navigationController pushViewController:appVC animated:YES];
    }
}

#pragma mark - UISearchResultsUpdating -
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // UISearchController的searchBar中的内容一旦发生变化, 就会调用该方法.
    
    NSString * searchBarStr = searchController.searchBar.text;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", searchBarStr];
    
//    SearchResultViewController * searchResultVC = (SearchResultViewController *)searchController.searchResultsController;
    _searchResultVC.resultArr = [[_dataArr filteredArrayUsingPredicate:predicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [_searchResultVC.resultTableView reloadData];
        [_searchResultVC.tableView reloadData];
    });
}

#pragma mark - UISearchControllerDelegate -
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    _historyTableView.hidden = NO;
    _currentTableView.hidden = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _historyTableView.hidden = YES;
    _currentTableView.hidden = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![searchBar.text isEqualToString:@""]) {
        [_historyArr addObject:searchBar.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_historyTableView reloadData];
        });
    }
}

@end
