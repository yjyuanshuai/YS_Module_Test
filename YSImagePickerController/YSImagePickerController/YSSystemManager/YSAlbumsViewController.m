//
//  YSAlbumsViewController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAlbumsViewController.h"
#import "YSAlbumsTableViewCell.h"
#import "MediaLibraryManager.h"
#import "YSPhotosModel.h"
#import "YSImagePickerHead.h"
#import "YSImagePickerController.h"
#import "YSPhotosViewController.h"

static NSString * const YSAlbumsCellID = @"YSAlbumsCellID";

@interface YSAlbumsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * albumsTableView;

@end

@implementation YSAlbumsViewController
{
    NSMutableArray * _albumsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self getAllAlbums];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _albumsArr = [@[] mutableCopy];
    self.title = @"照片";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
}

- (void)cancleClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTableView
{
    _albumsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNo64Height) style:UITableViewStylePlain];
    _albumsTableView.delegate = self;
    _albumsTableView.dataSource = self;
    _albumsTableView.tableFooterView = [UIView new];
    [self.view addSubview:_albumsTableView];
    
    [_albumsTableView registerClass:[YSAlbumsTableViewCell class] forCellReuseIdentifier:YSAlbumsCellID];
}

- (void)getAllAlbums
{
    [[MediaLibraryManager sharedMediaLibrary] getAllAlbums:^(NSMutableArray *retAlbumsArr) {
        _albumsArr = [NSMutableArray arrayWithArray:retAlbumsArr];
        [_albumsTableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albumsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSAlbumsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSAlbumsCellID];
    
    YSAlbumsModel * albumModel = _albumsArr[indexPath.row];
    CGSize size = CGSizeMake(thumbImageWidth, thumbImageWidth);
    
    [[MediaLibraryManager sharedMediaLibrary] getAlbumPostImage:albumModel size:size resizeMode:PHImageRequestOptionsResizeModeFast postBlock:^(YSPhotosModel *model, UIImage *postImage, NSDictionary *info) {
        
        if (albumModel.count > 0) {
            [cell setYSAlbumsCellContent:postImage albumName:albumModel.name photosNumber:albumModel.count];
        }
        else {
            [cell setYSAlbumsCellContent:nil albumName:albumModel.name photosNumber:albumModel.count];
        }
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return thumbImageWidth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转到具体相册
    YSImagePickerController * imagePickerVC = (YSImagePickerController *)self.navigationController;
    
    if (imagePickerVC) {
        
        if ([imagePickerVC.viewControllers count] > 1) {
            YSPhotosViewController * photosVC = imagePickerVC.viewControllers[1];
            [imagePickerVC pushViewController:photosVC animated:YES];
        }
        else {
            YSPhotosViewController * photosVC = [[YSPhotosViewController alloc] initWithAlbum:_albumsArr[indexPath.row] horNum:imagePickerVC.columentNum];
            [imagePickerVC pushViewController:photosVC animated:YES];
        }
    }
}

@end
