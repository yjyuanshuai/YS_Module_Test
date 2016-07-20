//
//  YSDefaultsViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSDefaultsViewController.h"
#import "YSUserDefaults.h"
#import "NSString+BreakLine.h"

@interface YSDefaultsViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * ysNameTextFeild;
@property (nonatomic, strong) UITextField * ysPassTextFeild;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIButton * saveBtn;
@property (nonatomic, strong) UIButton * readBtn;

@end

@implementation YSDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"偏好设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _ysNameTextFeild = [UITextField new];
    [self.view addSubview:_ysNameTextFeild];
    _ysNameTextFeild.delegate = self;
    _ysNameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    /*
    [_ysNameTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
     */
    
    _ysPassTextFeild = [UITextField new];
    [self.view addSubview:_ysPassTextFeild];
    _ysPassTextFeild.delegate = self;
    _ysPassTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    /*
    [_ysPassTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
        make.top.mas_equalTo(_ysNameTextFeild.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
     */
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _saveBtn.layer.borderWidth = 1;
    [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(clickToSave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    /*
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.top.mas_equalTo(_ysPassTextFeild.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
     */
    
    _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _readBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _readBtn.layer.borderWidth = 1;
    [_readBtn setTitle:@"read" forState:UIControlStateNormal];
    [_readBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_readBtn addTarget:self action:@selector(clickToRead) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_readBtn];
    /*
    [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.top.mas_equalTo(_ysPassTextFeild.mas_bottom).with.offset(10);
        make.left.mas_equalTo(saveBtn.mas_right).with.offset(kScreenWidth - 20 - 80*2);
    }];
     */
    
    _detailLabel = [UILabel new];
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = [UIFont systemFontOfSize:16.0];
    _detailLabel.layer.borderWidth = 1.0;
    _detailLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_detailLabel];
    /*
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(CGRectGetMaxY(saveBtn.frame), 10, 10, 10));
    }];
     */
}

- (void)addConstraintWithVFL
{
    NSDictionary * metricsDic = @{};
    NSDictionary * viewsDic = @{@"_ysNameTextFeild":_ysNameTextFeild, @"_ysPassTextFeild":_ysPassTextFeild, @"_saveBtn":_saveBtn, @"_readBtn":_readBtn, @"_detailLabel":_detailLabel};
    
    
    
}

- (void)clickToSave
{
    [self.view endEditing:YES];
    
    YSUserDefaults * ysdefault = [YSUserDefaults shareUserDefualts];
    ysdefault.userName = _ysNameTextFeild.text;
    ysdefault.passWord = _ysPassTextFeild.text;
    [ysdefault saveUserDefaults];
}

- (void)clickToRead
{
    [self.view endEditing:YES];
    
    YSUserDefaults * ysdefault = [YSUserDefaults shareUserDefualts];
    [ysdefault readUserDefaults];
    NSMutableString * tempStr = [NSMutableString string];
    [tempStr appendFormat:@"userName: %@\npassword: %@", ysdefault.userName, ysdefault.passWord];
    
    _detailLabel.text = [tempStr analyseBreakLine];
}

@end
