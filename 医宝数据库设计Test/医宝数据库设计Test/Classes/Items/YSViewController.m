//
//  YSViewController.m
//  医宝数据库设计Test
//
//  Created by YJ on 16/3/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSViewController.h"
#import "DBManger.h"

@interface YSViewController ()

@end

@implementation YSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DBManger * ysdb = [[DBManger alloc] init];
    
    [ysdb selectData];
    
    //创建表
    [ysdb createTable];
    
    //插入数据
    [ysdb insertData];
    
    //查询
    [ysdb selectData];
    
    //删除表
    [ysdb dropTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
