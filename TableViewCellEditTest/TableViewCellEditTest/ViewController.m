//
//  ViewController.m
//  TableViewCellEditTest
//
//  Created by YJ on 16/1/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

static NSString * edit_cell_id = @"EDIT_CELL_ID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController
{
    NSMutableArray * _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _dataArray = [NSMutableArray array];
    NSMutableArray * sectionDataArray = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {   //3段
        for (int j = 1; j <= 5; j++) {
            NSString * textStr = [NSString stringWithFormat:@"第%d段第%d行", i, j];
            [sectionDataArray addObject:textStr];
        }
//        NSLog(@"--------- %@", sectionDataArray);
        [_dataArray addObject:[NSArray arrayWithArray:sectionDataArray]];
        [sectionDataArray removeAllObjects];
    }
//    NSLog(@"====== %@ ", _dataArray);
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:edit_cell_id];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:edit_cell_id];
    if (indexPath.section < [_dataArray count]) {
        if (indexPath.row < [[_dataArray objectAtIndex:indexPath.section] count]) {
            cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 在这个里面，实现数据绑定
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

@end





