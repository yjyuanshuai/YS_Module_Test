//
//  ChooseDateViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChooseDateViewController.h"
#import "ChooseDataTableViewCell.h"
#import "ChooseDataCollectionViewCell.h"

@interface ChooseDateViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView * cdTableView;
@property (nonatomic, strong) UIView * cdView;
@property (nonatomic, strong) UIButton * frontBtn;
@property (nonatomic, strong) UIButton * nextBtn;

@end

@implementation ChooseDateViewController
{
    CGFloat _itemSize;
    NSInteger _currentPage;
    BOOL _isShow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createLines];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"选择日期";
    
    _itemSize = (kScreenWidth)/7;
    _isShow = NO;
    _currentPage = 0;
}

- (void)createTableView
{
    _cdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64) style:UITableViewStyleGrouped];
    _cdTableView.delegate = self;
    _cdTableView.dataSource = self;
    _cdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cdTableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (_isShow) {
            return 1;
        }
        else {
            return 0;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cell_id = [NSString stringWithFormat:@"cell_id_%d", (int)indexPath.section];
    ChooseDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[ChooseDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id indexPath:indexPath];
    }
    
    if (cell.cdCollectionView != nil) {
        cell.cdCollectionView.delegate = self;
        cell.cdCollectionView.dataSource = self;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    else {
        return _itemSize * 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        CGFloat introduceHeight = 44;
        
        UIView * introduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, introduceHeight)];
        
        UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.frame = CGRectMake(kScreenWidth - introduceHeight, 0, introduceHeight, introduceHeight);
        showBtn.backgroundColor = [UIColor blueColor];
        [showBtn addTarget:self action:@selector(clickToShowOrHide:) forControlEvents:UIControlEventTouchUpInside];
        [introduceView addSubview:showBtn];
        
        return introduceView;
    }
    else {
        CGFloat sectionHeight = 30;
        
        UIView * weekChooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
        weekChooseView.backgroundColor = [UIColor blueColor];
        
        _frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _frontBtn.frame = CGRectMake(0, 0, 100, 30);
        [_frontBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_frontBtn setTitle:@"上一周" forState:UIControlStateNormal];
        [_frontBtn addTarget:self action:@selector(clickToFrontWeek:) forControlEvents:UIControlEventTouchUpInside];
        [weekChooseView addSubview:_frontBtn];
        
        UILabel * dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 200, sectionHeight)];
        dataLabel.text = @"xxxx年xx月";
        dataLabel.textAlignment = NSTextAlignmentCenter;
        [weekChooseView addSubview:dataLabel];
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(kScreenWidth - 100, 0, 100, sectionHeight);
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一周" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(clickToNextWeek:) forControlEvents:UIControlEventTouchUpInside];
        [weekChooseView addSubview:_nextBtn];
        
        return weekChooseView;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
// Item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_itemSize, _itemSize);
}

// 上左下右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 上下 item 最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

// 左右 item 最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseDataCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cdCollectionViewCellID" forIndexPath:indexPath];
    [cell setCDCellContent:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)clickToShowOrHide:(id)sender
{
    _isShow = !_isShow;
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
    [_cdTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)clickToFrontWeek:(id)sender
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    ChooseDataTableViewCell * cell = (ChooseDataTableViewCell *)[_cdTableView cellForRowAtIndexPath:indexPath];
    
}

- (void)clickToNextWeek:(id)sender
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    ChooseDataTableViewCell * cell = (ChooseDataTableViewCell *)[_cdTableView cellForRowAtIndexPath:indexPath];
    
}

@end
