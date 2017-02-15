//
//  YSImagePickerRootVC.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/15.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSImagePickerRootVC.h"
#import "YSImagePickerHead.h"

static NSInteger YSTOOLBAR_BTNTAG = 20170214;

@interface YSImagePickerRootVC ()

@property (nonatomic, strong) UIView * bottemToolBar;

@end

@implementation YSImagePickerRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self createToolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)createToolBar
{
    _bottemToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kNo64Height, kMainScreenWidth, 50)];
    [self.view addSubview:_bottemToolBar];
    
    _bottemToolBar.backgroundColor = [UIColor yellowColor];
    
    CGFloat space = (kMainScreenWidth-60*3-10*2)/2;
    
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(10, 5, 60, 40);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    editBtn.tag = YSTOOLBAR_BTNTAG + 1;
    [_bottemToolBar addSubview:editBtn];
    
    UIButton * numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    numBtn.frame = CGRectMake(CGRectGetMaxX(editBtn.frame)+space, 5, 60, 40);
    numBtn.backgroundColor = [UIColor greenColor];
    [numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    numBtn.userInteractionEnabled = NO;
    numBtn.tag = YSTOOLBAR_BTNTAG + 2;
    [_bottemToolBar addSubview:numBtn];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(numBtn.frame)+space, 5, 60, 40);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag = YSTOOLBAR_BTNTAG + 3;
    [_bottemToolBar addSubview:sureBtn];
}

- (void)initSetting
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
}

- (void)cancleClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)updateToolBar
{
    
}

- (void)showToolBarWithAniamte:(BOOL)animate
{
    if (animate) {
        [UIView animateWithDuration:0.5 animations:^{
            _bottemToolBar.frame = CGRectMake(0, kNoToolBarHeight, kMainScreenWidth, 50);
        }];
    }
    else {
        _bottemToolBar.frame = CGRectMake(0, kNoToolBarHeight, kMainScreenWidth, 50);
    }
}

- (void)hideToolBarWithAniamte:(BOOL)animate
{
    if (animate) {
        [UIView animateWithDuration:0.5 animations:^{
            _bottemToolBar.frame = CGRectMake(0, kNo64Height, kMainScreenWidth, 50);
        }];
    }
    else {
        _bottemToolBar.frame = CGRectMake(0, kNo64Height, kMainScreenWidth, 50);
    }
}

#pragma mark - 
- (void)edit
{}

- (void)sure
{}

@end
