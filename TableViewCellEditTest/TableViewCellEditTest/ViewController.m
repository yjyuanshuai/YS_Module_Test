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
    BOOL _isEdit;
    UIButton * _rightBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    [self initData];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editCell:)];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 60, 30);
    _rightBtn.hidden = YES;
    [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_rightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
}

- (void)initData
{
    _dataArray = [NSMutableArray array];
    NSMutableArray * sectionDataArray = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {   //3段
        for (int j = 1; j <= 2; j++) {
            NSString * textStr = [NSString stringWithFormat:@"第%d段第%d行", i, j];
            [sectionDataArray addObject:textStr];
        }
        [_dataArray addObject:[NSMutableArray arrayWithArray:sectionDataArray]];
        [sectionDataArray removeAllObjects];
    }
    
    
    _isEdit = NO;
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:edit_cell_id];
}

#pragma mark - 
- (void)editCell:(UIBarButtonItem *)item
{
    if (!_isEdit) {
        _isEdit = YES;
        _rightBtn.hidden = NO;
        _tableView.editing = YES;
    }else {
        _isEdit = NO;
        _rightBtn.hidden = YES;
    }
}

- (void)done
{
    _rightBtn.hidden = YES;
    _tableView.editing = NO;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:edit_cell_id];
    return cell;
     
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 在这个里面，实现数据绑定。对变高的cell可用但没有意义。
    if (indexPath.section < [_dataArray count]) {
        if (indexPath.row < [[_dataArray objectAtIndex:indexPath.section] count]) {
            cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_dataArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray * sectionArr = [_dataArray objectAtIndex:indexPath.section];
        [sectionArr removeObjectAtIndex:indexPath.row];
        
        [_dataArray replaceObjectAtIndex:indexPath.section withObject:sectionArr];
        [_tableView reloadData];
    }
}

@end





