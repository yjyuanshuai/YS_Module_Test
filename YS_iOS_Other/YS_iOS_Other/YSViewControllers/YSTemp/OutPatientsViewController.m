//
//  OutPatientsViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OutPatientsViewController.h"

@interface OutPatientsViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UISearchBar * ysSearchBar;
@property (nonatomic, strong) UISearchDisplayController * ysSearchDisCon;
@property (nonatomic, strong) UICollectionView * opCollectionView;

@end

@implementation OutPatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithUIAndData
{
    self.title = @"预约挂号";
}

- (void)createSearchView
{
    _ysSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _ysSearchBar.delegate = self;
    _ysSearchBar.showsCancelButton = NO;
    _ysSearchBar.placeholder = @"按科室名称或医生姓名搜索";
    _ysSearchBar.tintColor = [UIColor lightGrayColor];
    _ysSearchBar.barTintColor = [UIColor lightGrayColor];
    [self.view addSubview:_ysSearchBar];
    
    _ysSearchDisCon = [[UISearchDisplayController alloc] initWithSearchBar:_ysSearchBar contentsController:self];
    _ysSearchDisCon.delegate = self;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _opCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeightNo64 - 44) collectionViewLayout:flowLayout];
    _opCollectionView.delegate = self;
    _opCollectionView.dataSource = self;
    [self.view addSubview:_opCollectionView];
}


#pragma mark - UISearchBarDelegate

#pragma mark - UISearchDisplayDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

@end
