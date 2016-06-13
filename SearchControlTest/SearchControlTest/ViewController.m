//
//  ViewController.m
//  SearchControlTest
//
//  Created by YJ on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultTableViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController
{
    NSArray *        _allData;          //全体数据
    NSArray *        _historyData;      //历史搜索
    NSMutableArray * _searchResultArr;  //搜索结果
    BOOL             _isShowHistory;     //是否展示历史
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    [self createSearchControl];
    [self createTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_searchController.active) {
        _searchController.active = NO;
        [_searchController.searchBar removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)initData
{
    _allData = @[@"eqr", @"121c", @"vf4", @"avr2", @"aew35", @"mhhu", @"tr5",@"et7844",@"搜索历史1", @"搜索历史2", @"搜索历史3"];
    _historyData = @[@"搜索历史1", @"搜索历史2", @"搜索历史3"];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell  class] forCellReuseIdentifier:@"CELL_ID"];
    
    _tableView.tableHeaderView = _searchController.searchBar;
}

- (void)createSearchControl
{
    SearchResultTableViewController * searchResultVC = [[SearchResultTableViewController alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _searchController.searchResultsUpdater = self;
    
    
    //搜索时，背景变暗色，默认是 YES
    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊，默认是 YES
//    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏，默认是 YES
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    [_searchController.searchBar sizeToFit];
    
    _searchController.searchBar.delegate = self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isShowHistory) {
        return [_historyData count];
    }
    return [_allData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cell_ID = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    
    NSString * text = _allData[indexPath.row];
    if (_isShowHistory) {
        text = _historyData[indexPath.row];
    }
    
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isShowHistory) {
        NSString * historyStr = _historyData[indexPath.row];
        _searchController.searchBar.text = historyStr;
        if ([self respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
            [self updateSearchResultsForSearchController:_searchController];
        }
    } else {
        // 跳转到相应界面
    }
}

#pragma mark - UISearchResultsUpdating -

// UISearchController的searchBar中的内容一旦发生变化, 就会调用该方法.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self showResult:_searchController.searchBar.text];
}

#pragma mark - 
- (void)showResult:(NSString *)searchStr
{
    NSPredicate * searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchStr];
    NSArray * predicateArr = [_allData filteredArrayUsingPredicate:searchPredicate];
    
    if (_searchResultArr != nil) {
        [_searchResultArr removeAllObjects];
    }
    _searchResultArr = [NSMutableArray arrayWithArray:predicateArr];
    
    SearchResultTableViewController * searchResultVC = (SearchResultTableViewController *)_searchController.searchResultsController;
    searchResultVC.resultArr = _searchResultArr;
    dispatch_async(dispatch_get_main_queue(), ^{
       [searchResultVC.resultTableView reloadData];
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
    _isShowHistory = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isShowHistory = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
