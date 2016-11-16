//
//  YSOtherViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSOtherViewController.h"


// test


// 1
#import "SevenBaiduViewController.h"

// 3
#import "YSCoreTextViewController.h"

// 4
#import <QBImagePickerController/QBImagePickerController.h>
#import "ImagesShowViewController.h"
#import "CanlenderViewController.h"


// 5
#import <RESideMenu.h>
#import "RightMenuViewController.h"
#import "AudioAndVideoMainViewController.h"
#import "AudioViewController.h"
#import "VideoViewController.h"

// 6


// 7

// 8

// 9

static NSString * const OtherCellID = @"OtherCellID";

@interface YSOtherViewController () <UITableViewDataSource, UITableViewDelegate, QBImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView * otherTableView;

@end

@implementation YSOtherViewController
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
    self.title = @"其他";
    
    _sectionTitleArr = @[@"1 地图", @"2 本地化", @"3 图文混排", @"4 系统功能调用", @"5 音/视频", @"6 支付", @"7 Quartz", @"8 OpenGL", @"9 暂时"];
    
    NSArray * sectionOne    = @[@"原生", @"百度", @"高德"];
    NSArray * sectionTwo    = @[@"本地化"];
    NSArray * sectionThree  = @[@"CoreText"];
    NSArray * sectionFour   = @[@"照相机", @"相片库", @"日历事件"];
    NSArray * audioArr      = @[@"主界面", @"音频", @"视频"];
    NSArray * payArr        = @[@"招行一网通"];
    NSArray * sectionFive   = @[@"Quartz"];
    NSArray * sectionSix    = @[@"OpenGL"];
    NSArray * tempArr       = @[@"temp1"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThree, sectionFour, audioArr, payArr, sectionFive, sectionSix, tempArr] mutableCopy];
}

- (void)createTableView
{
    _otherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _otherTableView.delegate = self;
    _otherTableView.dataSource = self;
    [self.view addSubview:_otherTableView];
    [_otherTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //    _savedateTableView.sectionHeaderHeight = 40;
    //    _savedateTableView.sectionFooterHeight = 0.01;
    
    [_otherTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
}

#pragma mark - UITableViewDataSource
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OtherCellID];
    cell.textLabel.text = _sectionCellContent[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                // 原生地图
                
            }
            else if (indexPath.row == 1)
            {
                // 百度地图
                SevenBaiduViewController * baiduMapVC = [[SevenBaiduViewController alloc] init];
                baiduMapVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:baiduMapVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                // 高德
            }
            
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0)
            {
                // 本地化
            }
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0) {
                
                // CoreText 图文混排
                YSCoreTextViewController * coreTextVC = [[YSCoreTextViewController alloc] init];
                coreTextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:coreTextVC animated:YES];
                
            }
        }
            break;
            
        case 3:
        {
            if (indexPath.row == 0)
            {
                // 照相机
                
            }
            else if (indexPath.row == 1)
            {
                // 相片库
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
            else if (indexPath.row == 2) {
                
                // 日历事件
                CanlenderViewController * canlenderVC = [[CanlenderViewController alloc] init];
                canlenderVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:canlenderVC animated:YES];
                
            }
        }
            break;

        case 4:
        {
            if (indexPath.row == 0)
            {
                // 主界面
                AudioAndVideoMainViewController * mainVC = [[AudioAndVideoMainViewController alloc] init];
                
                RightMenuViewController * rightVC = [[RightMenuViewController alloc] init];
                
                RESideMenu * sideMenuVC = [[RESideMenu alloc] initWithContentViewController:mainVC
                                                                     leftMenuViewController:nil
                                                                    rightMenuViewController:rightVC];
                sideMenuVC.backgroundImage = [UIImage imageNamed:@"Stars"];
                sideMenuVC.hidesBottomBarWhenPushed = YES;
                sideMenuVC.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
//                sideMenuVC.contentViewShadowColor = [UIColor blackColor];
//                sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
//                sideMenuVC.contentViewShadowOpacity = 0.6;
//                sideMenuVC.contentViewShadowRadius = 12;
//                sideMenuVC.contentViewShadowEnabled = YES;
                
                sideMenuVC.title = @"音/视频主界面";
                sideMenuVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右滑"
                                                                                                style:UIBarButtonItemStylePlain
                                                                                               target:sideMenuVC
                                                                                               action:@selector(presentRightMenuViewController)];
                [self.navigationController pushViewController:sideMenuVC animated:YES];
                
            }
            else if (indexPath.row == 1) {
                // 音频
                AudioViewController * audioVC = [[AudioViewController alloc] init];
                audioVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:audioVC animated:YES];
            }
            else if (indexPath.row == 2) {
                // 视频
                VideoViewController * videoVC = [[VideoViewController alloc] init];
                videoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:videoVC animated:YES];
            }
        }
            break;

        case 5:
        {
            if (indexPath.row == 0)
            {
                
            }
        }
            break;
        case 8:
        {
            
        }
            break;
            
        default:
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
