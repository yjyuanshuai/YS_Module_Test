//
//  AudioAndVideoMainViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioAndVideoMainViewController.h"
#import "RightMenuViewController.h"
#import <RESideMenu.h>

@interface AudioAndVideoMainViewController () <RESideMenuDelegate>

@end

@implementation AudioAndVideoMainViewController

- (instancetype)initWithSaveNav:(UINavigationController *)saveNav
{
    if (self = [super init]) {
        
    }
    return self;
}

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
    self.title = @"音/视频主界面";
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(hideRESideMenu)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"选择"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(presentRightMenuViewController:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)hideRESideMenu
{
    RESideMenu * sideMenu = [self sideMenuViewController];
    [sideMenu hideMenuViewController];
    
    [sideMenu dismissViewControllerAnimated:YES completion:nil];
}

@end
