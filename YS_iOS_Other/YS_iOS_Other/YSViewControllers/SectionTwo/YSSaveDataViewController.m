//
//  YSSaveDataViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSaveDataViewController.h"

// 1 存储
#import "TwoDocumentViewController.h"
#import "YSDefaultsViewController.h"

// 2 数据库

// 3 其他




static NSString * const SaveDataCellID = @"SaveDataCellID";

@interface YSSaveDataViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * savedateTableView;

@end

@implementation YSSaveDataViewController
{
    NSArray * _sectionTitleArr;
    NSMutableArray * _sectionCellContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWithUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithUIAndData
{
    self.title = @"数据持久化";
    
    _sectionTitleArr = @[@"1 存储", @"2 数据库", @"3 其他"];
    
    NSArray * sectionOne    = @[@"沙盒", @"文件", @"归档", @"偏好设置", @"钥匙串"];
    NSArray * sectionTwo    = @[@"sqlite", @"CoreData"];
    NSArray * sectionThree  = @[@"使用UIDocument管理文件存储", @"添加iCloud支持"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThree] mutableCopy];
}

- (void)createTableView
{
    _savedateTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _savedateTableView.delegate = self;
    _savedateTableView.dataSource = self;
    [self.view addSubview:_savedateTableView];
    [_savedateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    _savedateTableView.sectionHeaderHeight = 40;
//    _savedateTableView.sectionFooterHeight = 0.01;
    
    [_savedateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SaveDataCellID];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sectionCellContent[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SaveDataCellID];
    cell.textLabel.text = _sectionCellContent[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                // “沙盒”
                TwoDocumentViewController * collectionVC = [[TwoDocumentViewController alloc] init];
                collectionVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectionVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
            
            }
            else if (indexPath.row == 2)
            {
            
            }
            else if (indexPath.row == 3)
            {
                // “偏好设置”
                YSDefaultsViewController * defaultVC = [[YSDefaultsViewController alloc] init];
                [self.navigationController pushViewController:defaultVC animated:YES];
            }
            else if (indexPath.row == 4)
            {
            
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
            
        default:
            break;
    }
}


@end
