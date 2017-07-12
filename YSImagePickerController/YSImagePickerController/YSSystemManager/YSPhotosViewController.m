//
//  YSPhotosViewController.m
//  YSImagePickerController
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSPhotosViewController.h"
#import "YSPhotosCollectionViewCell.h"
#import "YSImagePickerHead.h"
#import "YSPhotosModel.h"
#import "MediaLibraryManager.h"

static NSString * const YSPhotosCollectionCellID = @"YSPhotosCollectionCellID";

@interface YSPhotosViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * photoCollectionView;

@end

@implementation YSPhotosViewController
{
    YSAlbumsModel * _albumModel;
    NSInteger _horNum;
    NSMutableArray *_photos;
}

- (instancetype)initWithAlbum:(YSAlbumsModel *)album
                       horNum:(NSInteger)horNum
{
    if (self = [super init]) {
        _albumModel = album;
        _horNum = horNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createCollectionView];
    [self getPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    if (!_albumModel) {
        self.title = @"相册的名字";
        
        __block YSAlbumsModel * tempModel = nil;
        [[MediaLibraryManager sharedMediaLibrary] getAlbum:@"相机胶卷" albumBlock:^(YSAlbumsModel * model) {
            tempModel = model;
        }];
        
        _albumModel = tempModel;
    }
    else {
        self.title = _albumModel.name;
    }
    
    _photos = [@[] mutableCopy];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) collectionViewLayout:flowLayout];
    _photoCollectionView.backgroundColor = [UIColor whiteColor];
    _photoCollectionView.delegate = self;
    _photoCollectionView.dataSource = self;
    [self.view addSubview:_photoCollectionView];
    
    [_photoCollectionView registerClass:[YSPhotosCollectionViewCell class] forCellWithReuseIdentifier:YSPhotosCollectionCellID];
}

- (void)getPhotos
{
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSPhotosCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSPhotosCollectionCellID forIndexPath:indexPath];
    
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kMainScreenWidth - 20 - (_horNum-1)*10)/_horNum;
    return CGSizeMake(width, width);
}

@end
