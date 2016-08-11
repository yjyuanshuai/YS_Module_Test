//
//  YSLanguageViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSLanguageViewController.h"

// 1
#import "YSGCDViewController.h"

// 2
#import "SixGestureViewController.h"
#import "YSCustemGesture.h"
#import "JianShuNavAnimationViewController.h"

// 3
#import "YSTouchViewController.h"

static NSString * const LanguageCellID = @"LanguageCellID";

@interface YSLanguageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * languageTableView;

@end

@implementation YSLanguageViewController
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
    self.title = @"语言";
    
    _sectionTitleArr = @[@"1 线程", @"2 触摸"];
    
    NSArray * sectionOne    = @[@"GCD"];
    NSArray * sectionTwo    = @[@"手势", @"自定义手势", @"触摸"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo] mutableCopy];
}

- (void)createTableView
{
    _languageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _languageTableView.delegate = self;
    _languageTableView.dataSource = self;
    [self.view addSubview:_languageTableView];
    [_languageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_languageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LanguageCellID];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LanguageCellID];
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
                // GCD
                YSGCDViewController * gcdVC = [[YSGCDViewController alloc] init];
                gcdVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:gcdVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                // 手势
                SixGestureViewController * gestureVC = [[SixGestureViewController alloc] init];
                gestureVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:gestureVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                // 自定义手势
                JianShuNavAnimationViewController * jianshuVC = [[JianShuNavAnimationViewController alloc] init];
                jianshuVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:jianshuVC animated:YES];
            }
            else if (indexPath.row == 2){
                // 触摸
                YSTouchViewController * touchVC = [[YSTouchViewController alloc] init];
                touchVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:touchVC animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                //
            }
            else if (indexPath.row == 1)
            {
                //
            }
        }
            break;
            
        default:
            break;
    }
}

@end
