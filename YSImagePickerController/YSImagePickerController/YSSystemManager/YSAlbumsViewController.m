//
//  YSAlbumsViewController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAlbumsViewController.h"
#import "YSAlbumsTableViewCell.h"

static NSString * const YSAlbumsCellID = @"YSAlbumsCellID";

@interface YSAlbumsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * albumsTableView;

@property (nonatomic, strong) NSMutableArray * albumsArr;

@end

@implementation YSAlbumsViewController

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
    if (!_albumsArr) {
        _albumsArr = [@[] mutableCopy];
    }
    
    self.title = @"照片";
}

- (void)createTableView
{
    _albumsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _albumsTableView.delegate = self;
    _albumsTableView.dataSource = self;
    [self.view addSubview:_albumsTableView];
    
    [_albumsTableView registerClass:[YSAlbumsTableViewCell class] forCellReuseIdentifier:YSAlbumsCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albumsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSAlbumsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSAlbumsCellID];
    
    
    return cell;
}

@end
