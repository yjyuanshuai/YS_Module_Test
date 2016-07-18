//
//  YSOtherViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSOtherViewController.h"

#import "SevenBaiduViewController.h"
#import "JianShuNavAnimationViewController.h"

static NSString * const OtherCellID = @"OtherCellID";

@interface YSOtherViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * otherTableView;

@end

@implementation YSOtherViewController
{
    NSArray * _sectionTitleArr;
    NSMutableArray * _sectionCellContent;
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
    _sectionTitleArr = @[@"1 地图", @"2 本地化", @"3 各种效果", @"4 更换头像"];
    
    NSArray * sectionOne  = @[@"原生", @"百度", @"高德"];
    NSArray * sectionTwo  = @[@"本地化"];
    NSArray * sectionThree  = @[@"导航栏效果"];
    NSArray * sectionFour   = @[@"照相机", @"相片库"];
    NSArray * sectionFive   = @[@"Quartz"];
    NSArray * sectionSix    = @[@"OpenGL"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThree, sectionFour, sectionFive, sectionSix] mutableCopy];
}

- (void)createTableView
{
    _otherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _otherTableView.delegate = self;
    _otherTableView.dataSource = self;
    [self.view addSubview:_otherTableView];
    [_otherTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //    _savedateTableView.sectionHeaderHeight = 40;
    //    _savedateTableView.sectionFooterHeight = 0.01;
    
    [_otherTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OtherCellID];
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

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                // 百度地图
                SevenBaiduViewController * baiduMapVC = [[SevenBaiduViewController alloc] init];
                [self.navigationController pushViewController:baiduMapVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                
            }
            
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0)
            {
                
            }
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0)
            {
                JianShuNavAnimationViewController * jianshuNavVC = [[JianShuNavAnimationViewController alloc] init];
                [self.navigationController pushViewController:jianshuNavVC animated:YES];
            }
        }
            break;
            
        case 3:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;

        case 4:
        {
            if (indexPath.row == 0)
            {
                
            }
        }
            break;

        case 5:
        {
            if (indexPath.row == 0)
            {
                
            }
        }
            break;
            
        default:
            break;
    }
}


@end
