//
//  ViewController.m
//  ios音频采集和播放Test
//
//  Created by YJ on 16/5/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController
{
    NSArray * _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _array = @[@"AudioRecoder", @"队列"];
    
    CGSize size = self.view.frame.size;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
    }
    
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FirstViewController * oneVC = [[FirstViewController alloc] init];
        [self.navigationController pushViewController:oneVC animated:YES];
        
    } else {
        SecondViewController * twoVC = [[SecondViewController alloc] init];
        [self.navigationController pushViewController:twoVC animated:YES];
        
    }
}

@end
