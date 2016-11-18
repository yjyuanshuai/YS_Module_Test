//
//  YSHarewareViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSHarewareViewController.h"

// 1-1 相机&照相
#import <QBImagePickerController/QBImagePickerController.h>
#import "ImagesShowViewController.h"
#import "CanlenderViewController.h"

static NSString * const HarewareCellID = @"HarewareCellID";

@interface YSHarewareViewController ()<UITableViewDelegate, UITableViewDataSource, QBImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView * harewareTableView;

@end

@implementation YSHarewareViewController
{
    NSArray * _sectionTitleArr;
    NSMutableArray * _sectionCellContent;
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
    self.title = @"系统功能与硬件";
    
    _sectionTitleArr = @[@"1 系统功能", @"2 其他"];
    
    NSArray * sectionOne  = @[@"相册", @"相机", @"闹钟", @"健康", @"日历", @"硬件连接", @"蓝牙", @"耳机", @"麦克风", @"邮件"];
    NSArray * sectionTwo  = @[@"陀螺仪", @"加速器"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo] mutableCopy];
}

- (void)createTableView
{
    _harewareTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _harewareTableView.delegate = self;
    _harewareTableView.dataSource = self;
    [self.view addSubview:_harewareTableView];
    [_harewareTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _harewareTableView.sectionHeaderHeight = 40;
    _harewareTableView.sectionFooterHeight = 0.01;
    
    [_harewareTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HarewareCellID];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sectionCellContent[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HarewareCellID];
    cell.textLabel.text = _sectionCellContent[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    QBImagePickerController * QBImagePC = [[QBImagePickerController alloc] init];
                    QBImagePC.delegate = self;
                    QBImagePC.allowsMultipleSelection = YES;        // 默认是NO
                    QBImagePC.minimumNumberOfSelection = 1;         // 最小选择数
                    QBImagePC.maximumNumberOfSelection = 9;         // 最大选择数
                    QBImagePC.showsNumberOfSelectedAssets = YES;    //
                    QBImagePC.mediaType = QBImagePickerMediaTypeImage;  // 类型
                    //                QBImagePC.prompt = @"选择照片";
                    QBImagePC.numberOfColumnsInPortrait = 4;        // 竖屏时一排数
                    QBImagePC.numberOfColumnsInLandscape = 7;       // 横屏时一排数
                    QBImagePC.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeSmartAlbumUserLibrary), // 相机胶卷
                                                          @(PHAssetCollectionSubtypeAlbumMyPhotoStream),    // 照片流
                                                          @(PHAssetCollectionSubtypeSmartAlbumPanoramas),   // 全景图片
                                                          @(PHAssetCollectionSubtypeSmartAlbumVideos),      // 视频
                                                          @(PHAssetCollectionSubtypeSmartAlbumBursts)       // 连拍快照
                                                          ];
                    [self presentViewController:QBImagePC animated:YES completion:nil];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    // 日历事件
                    CanlenderViewController * canlenderVC = [[CanlenderViewController alloc] init];
                    canlenderVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:canlenderVC animated:YES];
                }
                    break;
                case 5:
                {
                    
                }
                    break;
                case 6:
                {
                    
                }
                    break;
                    
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
    }
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    // 完成选择
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    ImagesShowViewController * imagePC = [[ImagesShowViewController alloc] initWithImageAsset:assets];
    [self.navigationController pushViewController:imagePC animated:YES];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    // 取消
    
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)qb_imagePickerController:(QBImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset
{
    return YES;
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset
{
    
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset
{
    
}

@end
