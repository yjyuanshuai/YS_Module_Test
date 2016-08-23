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
#import "YSButton.h"
#import "NSDate+Utilities.h"

@interface ChooseDateViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView * cdTableView;
@property (nonatomic, strong) UIView * cdView;
@property (nonatomic, strong) YSButton * frontBtn;
@property (nonatomic, strong) YSButton * nextBtn;
@property (nonatomic, strong) UILabel * dataLabel;

@end

@implementation ChooseDateViewController
{
    NSInteger _currentPage;
    BOOL _isShow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"选择日期";

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
    
    if (cell.cdPageControl) {
        [cell.cdPageControl addTarget:self action:@selector(clickToPageControl:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.section == 0) {
        [cell setChooseDataIntroduce:@"这里是介绍- (void)setChooseDataIntroduce:(NSString *)introduceStr- (void)setChooseDataIntroduce:(NSString *)introduceStr- (void)setChooseDataIntroduce:(NSString *)introduceStr- (void)setChooseDataIntroduce:(NSString *)introduceStr- (void)setChooseDataIntroduce:(NSString *)introduceStr"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    else {
        return itemSize * 4 + 20;
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
        showBtn.backgroundColor = YSColorDefault;
        [showBtn addTarget:self action:@selector(clickToShowOrHide:) forControlEvents:UIControlEventTouchUpInside];
        [introduceView addSubview:showBtn];
        
        return introduceView;
    }
    else {
        CGFloat sectionHeight = 30;
        
        UIView * weekChooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
        weekChooseView.backgroundColor = YSColorDefault;

        _frontBtn = [[YSButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _frontBtn.btnTitle.text = @"上一周";
        _frontBtn.btnImageView.image = [UIImage imageNamed:@"tab_one_num"];
        _frontBtn.tintColor = [UIColor whiteColor];
        _frontBtn.hidden = YES;
        [_frontBtn addTarget:self action:@selector(clickToFrontWeek:) forControlEvents:UIControlEventTouchUpInside];
        [weekChooseView addSubview:_frontBtn];
        
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 200, sectionHeight)];
        _dataLabel.text = [ChooseDataCollectionViewCell getSectionTitleDateDay:0];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        [weekChooseView addSubview:_dataLabel];
        
        _nextBtn = [[YSButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, sectionHeight)];
        _nextBtn.imagePostion = ImagePostionRight;
        _nextBtn.btnTitle.text = @"下一周";
        _nextBtn.btnImageView.image = [UIImage imageNamed:@"tab_one_num"];
        _nextBtn.ysTintColor = [UIColor whiteColor];
        [_nextBtn addTarget:self action:@selector(clickToNextWeek:) forControlEvents:UIControlEventTouchUpInside];
        [weekChooseView addSubview:_nextBtn];
        
        return weekChooseView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
// Item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemSize, itemSize);
}

// 上左下右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero; //UIEdgeInsetsMake(itemSpace, 0, itemSpace, 0);
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
//    if (section % 7 == 0) {
//        return CGSizeMake(itemSize, 4*itemSize);
//    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 14;
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

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
//        CDCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cdCollectionViewSectionHead" forIndexPath:indexPath];
//        
//        return headerView;
//    }
//    else {
//        UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"cdCollectionViewSectionFoot" forIndexPath:indexPath];
//        footerView.backgroundColor = [UIColor lightGrayColor];
//        return footerView;
//    }
//    return nil;
//}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSLog(@"------------- click index:%d, %d", indexPath.section, indexPath.row);
    
    NSDate * currentDate = [ChooseDataCollectionViewCell getDateDayDetail:indexPath.section];
    NSString * dateStr = [currentDate stringFromFormatterString:@"yyyy-MM-dd"];
    
    if (indexPath.row == 1) {
        dateStr = [NSString stringWithFormat:@"%@ %@", dateStr, @"上午"];
    }
    else if (indexPath.row == 2) {
        dateStr = [NSString stringWithFormat:@"%@ %@", dateStr, @"下午"];
    }
    else if (indexPath.row == 3) {
        dateStr = [NSString stringWithFormat:@"%@ %@", dateStr, @"夜间"];
    }
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ChooseDataTableViewCell * cell = (ChooseDataTableViewCell *)[_cdTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    if (cell.cdCollectionView == scrollView) {
        if (cell.cdPageControl) {
            
            CGFloat contentOffSet = scrollView.contentOffset.x;
            if (contentOffSet <= kScreenWidth/2) {
                // 第一周
                cell.cdPageControl.currentPage = 0;
                _frontBtn.hidden = YES;
                _nextBtn.hidden = NO;
                _dataLabel.text = [ChooseDataCollectionViewCell getSectionTitleDateDay:0];
            }
            else {
                // 第二周
                cell.cdPageControl.currentPage = 1;
                _frontBtn.hidden = NO;
                _nextBtn.hidden = YES;
                // 第二周的月份，由第二页的周日的日期决定
                _dataLabel.text = [ChooseDataCollectionViewCell getSectionTitleDateDay:7];
            }
        }
    }
}

#pragma mark -
- (void)clickToPageControl:(id)sender
{
    UIPageControl * pageCon = (UIPageControl *)sender;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    ChooseDataTableViewCell * cell = (ChooseDataTableViewCell *)[_cdTableView cellForRowAtIndexPath:indexPath];
    
    switch (pageCon.currentPage) {
        case 0:
        {
            _frontBtn.hidden = YES;
            _nextBtn.hidden = NO;
            _dataLabel.text = [ChooseDataCollectionViewCell getSectionTitleDateDay:0];
            cell.cdCollectionView.contentOffset = CGPointMake(0, 0);
        }
            break;
        case 1:
        {
            _frontBtn.hidden = NO;
            _nextBtn.hidden = YES;
            _dataLabel.text = [ChooseDataCollectionViewCell getSectionTitleDateDay:7];
            cell.cdCollectionView.contentOffset = CGPointMake(cell.cdCollectionView.frame.size.width, 0);
        }
            break;
    }
}

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
    if (cell.cdCollectionView) {
        [UIView animateWithDuration:0.3 animations:^{
            _frontBtn.hidden = YES;
            _nextBtn.hidden = NO;
            cell.cdCollectionView.contentOffset = CGPointMake(0, 0);
        }];
    }
}

- (void)clickToNextWeek:(id)sender
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    ChooseDataTableViewCell * cell = (ChooseDataTableViewCell *)[_cdTableView cellForRowAtIndexPath:indexPath];
    if (cell.cdCollectionView) {
        [UIView animateWithDuration:0.3 animations:^{
            _frontBtn.hidden = NO;
            _nextBtn.hidden = YES;
            cell.cdCollectionView.contentOffset = CGPointMake(cell.cdCollectionView.frame.size.width, 0);
        }];
    }
}
 

@end
