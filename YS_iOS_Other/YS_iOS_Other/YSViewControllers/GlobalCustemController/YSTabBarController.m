//
//  YSTabBarController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSTabBarController.h"

#import "ViewController.h"
#import "YSSaveDataViewController.h"
#import "YSLanguageViewController.h"
#import "YSWebViewController.h"
#import "YSHarewareViewController.h"
#import "YSOtherViewController.h"
#import "YSNewSystemViewController.h"

NSInteger const TabBarTag = 20160715;

@interface YSTabBarController ()

@property (nonatomic, strong) NSArray * tabbarItemTitles;
@property (nonatomic, strong) NSArray * navItemTitles;

@property (nonatomic, strong) UINavigationController * uiNavCon;
@property (nonatomic, strong) UINavigationController * saveDataNavCon;
@property (nonatomic, strong) UINavigationController * languageNavCon;
@property (nonatomic, strong) UINavigationController * webNavCon;
@property (nonatomic, strong) UINavigationController * harewareNavCon;
@property (nonatomic, strong) UINavigationController * otherNavCon;
@property (nonatomic, strong) UINavigationController * iOSNewSystemCon;

@end

@implementation YSTabBarController

+ (instancetype)sharedYSTabBarController
{
    static YSTabBarController * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSTabBarController alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self createViewController];
    [self setTabbarItemTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _tabbarItemTitles = @[@"UI", @"存储", @"语言", @"网络", @"硬件", @"其他", @"新系统功能"];
    _navItemTitles = @[@"UI有关", @"存储有关", @"语言有关", @"网络有关", @"硬件有关", @"其他有关", @"系统功能"];
}

- (void)createViewController
{
    ViewController * uiVC = [[ViewController alloc] init];
    uiVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[0]
                                                    image:[self deleteMaskImage:@"tab_one_num"]
                                            selectedImage:[UIImage imageNamed:@"tab_one_sel"]];
    uiVC.tabBarItem.title = _tabbarItemTitles[0];
    _uiNavCon = [[UINavigationController alloc] initWithRootViewController:uiVC];
    _uiNavCon.navigationItem.title = _navItemTitles[0];
    
    YSSaveDataViewController * savedataVC = [[YSSaveDataViewController alloc] init];
    savedataVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[1]
                                                          image:[self deleteMaskImage:@"tab_two_num"]
                                                  selectedImage:[UIImage imageNamed:@"tab_two_sel"]];
    savedataVC.tabBarItem.title = _tabbarItemTitles[1];
    _saveDataNavCon = [[UINavigationController alloc] initWithRootViewController:savedataVC];
    _saveDataNavCon.navigationItem.title = _navItemTitles[1];
    
    YSLanguageViewController * languageVC = [[YSLanguageViewController alloc] init];
    languageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[2]
                                                          image:[self deleteMaskImage:@"tab_thr_num"]
                                                  selectedImage:[UIImage imageNamed:@"tab_thr_sel"]];
    languageVC.tabBarItem.title = _tabbarItemTitles[2];
    _languageNavCon = [[UINavigationController alloc] initWithRootViewController:languageVC];
    _languageNavCon.navigationItem.title = _navItemTitles[2];
    
    YSWebViewController * webVC = [[YSWebViewController alloc] init];
    webVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[3]
                                                     image:[self deleteMaskImage:@"tab_fou_num"]
                                             selectedImage:[UIImage imageNamed:@"tab_fou_sel"]];
    webVC.tabBarItem.title = _tabbarItemTitles[3];
    _webNavCon = [[UINavigationController alloc] initWithRootViewController:webVC];
    _webNavCon.navigationItem.title = _navItemTitles[3];
    
    YSHarewareViewController * harewareVC = [[YSHarewareViewController alloc] init];
    harewareVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[4]
                                                          image:[self deleteMaskImage:@"tab_fiv_num"]
                                                  selectedImage:[UIImage imageNamed:@"tab_fiv_sel"]];
    harewareVC.tabBarItem.title = _tabbarItemTitles[4];
    _harewareNavCon = [[UINavigationController alloc] initWithRootViewController:harewareVC];
    _harewareNavCon.navigationItem.title = _navItemTitles[4];
    
    YSOtherViewController * otherVC = [[YSOtherViewController alloc] init];
    otherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[5]
                                                       image:[self deleteMaskImage:@"tab_six_num"]
                                               selectedImage:[UIImage imageNamed:@"tab_six_sel"]];
    otherVC.tabBarItem.title = _tabbarItemTitles[5];
    _otherNavCon = [[UINavigationController alloc] initWithRootViewController:otherVC];
    _otherNavCon.navigationItem.title = _navItemTitles[5];
    
    YSNewSystemViewController * newSystemVC = [[YSNewSystemViewController alloc] init];
    newSystemVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[6]
                                                           image:[self deleteMaskImage:@"tab_one_num"]
                                                   selectedImage:[UIImage imageNamed:@"tab_one_sel"]];
    _iOSNewSystemCon = [[UINavigationController alloc] initWithRootViewController:newSystemVC];
    _iOSNewSystemCon.navigationItem.title = _navItemTitles[6];
    
    self.viewControllers = @[_uiNavCon, _saveDataNavCon, _languageNavCon, _webNavCon, _harewareNavCon, _otherNavCon, _iOSNewSystemCon];
}

- (void)setTabbarItemTitle
{
    NSArray * tabBarItems = self.tabBar.items;
    for (int i = 0; i < [tabBarItems count]; i++) {
        UITabBarItem * item = tabBarItems[i];
        item.title = _tabbarItemTitles[i];
    }
}

- (UIImage *)deleteMaskImage:(NSString *)orgImageStr
{
    UIImage * orgImage = [UIImage imageNamed:orgImageStr];
    UIImage * retImage = [orgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return retImage;
}

@end
