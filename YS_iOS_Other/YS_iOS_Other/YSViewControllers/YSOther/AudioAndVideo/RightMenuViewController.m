//
//  RightMenuViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RightMenuViewController.h"
#import "AudioViewController.h"
#import "VideoViewController.h"
#import <RESideMenu.h>

@interface RightMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * rightMenuTableView;

@end

@implementation RightMenuViewController
{
    NSArray * _titleArr;
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
    self.view.backgroundColor = [UIColor clearColor];
    
    _titleArr = @[@"音频", @"视频"];
}

- (void)createTableView
{
    _rightMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.width - 54*2)/2.0f, self.view.frame.size.width, 54*2) style:UITableViewStylePlain];
    _rightMenuTableView.delegate = self;
    _rightMenuTableView.dataSource = self;
    _rightMenuTableView.backgroundColor = [UIColor clearColor];
    _rightMenuTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_rightMenuTableView];

    
    /*
    NSDictionary * metricsDic = @{@"space":@54};
    NSDictionary * viewsDic = @{@"_rightMenuTableView":_rightMenuTableView};
    
    NSString * vfl1 = @"H:|-0-[_rightMenuTableView]-0|";
    NSString * vfl2 = @"V:|-space-[_rightMenuTableView]-space-|";
    
    NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    [self.view addConstraints:c1];
    [self.view addConstraints:c2];
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AudioViewController * audioVC = [[AudioViewController alloc] init];
        UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:audioVC];
        [self.sideMenuViewController setContentViewController:leftNav];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (indexPath.row == 1) {
        VideoViewController * videoVC = [[VideoViewController alloc] init];
        UINavigationController * rightNav = [[UINavigationController alloc] initWithRootViewController:videoVC];
        
        [self.sideMenuViewController setContentViewController:rightNav];
        [self.sideMenuViewController hideMenuViewController];
    }
}

@end
