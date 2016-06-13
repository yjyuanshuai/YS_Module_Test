//
//  YSRootViewController.m
//  DZNEmptyDataViewTest
//
//  Created by YJ on 16/1/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"
#import "UIScrollView+EmptyDataSet.h"

//设备屏幕frame
#define kMainScreenFrameRect   [[UIScreen mainScreen] bounds]
#define kScreenHeightNoStatusAndNoNaviBarHeight  (kMainScreenFrameRect.size.height - 20.0f -44.0f)
#define kMainScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define HEL_16  [UIFont fontWithName:@"Helvetica" size:16]



@interface YSRootViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation YSRootViewController
{
    UITableView * _tableView;
    BOOL _loading;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - DZNEmptyDataSetSource
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSAttributedString * str = [[NSAttributedString alloc] initWithString:@"此功能暂未开通，敬请关注~" attributes:@{NSFontAttributeName:HEL_16, NSForegroundColorAttributeName:[UIColor blackColor]}];
//    return str;
//}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:@"此功能暂未开通，敬请关注~" attributes:@{NSFontAttributeName:HEL_16, NSForegroundColorAttributeName:[UIColor blackColor]}];
    return str;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"HX_Art_circle_default"];
}

//- (CAAnimation *) imageAnimationForEmptyDataSet:(UIScrollView *) scrollView
//{
//
//}


#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = @"111111111111111";
    return cell;
}


@end
