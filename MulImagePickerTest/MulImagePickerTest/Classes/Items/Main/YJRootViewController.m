//
//  YJRootViewController.m
//  MulImagePickerTest
//
//  Created by YJ on 16/1/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJRootViewController.h"
#import "TZImagePickerController.h"
#import "RootVCCollectionViewCell.h"

#define SelfViewWidth [UIScreen mainScreen].bounds.size.width
#define SelfViewHeight [UIScreen mainScreen].bounds.size.height

#define collectionViewWidth [UIScreen mainScreen].bounds.size.width
static CGFloat padding_x = 4;
//    static CGFloat padding_y = 4
#define itemWidth (collectionViewWidth - 4*padding_x)/3     // 默认是3个一行
#define itemHeight itemWidth

@interface YJRootViewController ()<TZImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YJRootViewController
{
    UICollectionView * _collectionView;
    NSMutableArray * _selectedArray;    //选择的照片
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];

    _selectedArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 
- (void)initUI
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 200, 30);
    btn.center = CGPointMake(self.view.center.x, 50);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"点击选择照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    // 创建collectionView
    UICollectionViewFlowLayout * _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    _flowLayout.minimumInteritemSpacing = padding_x;
    _flowLayout.minimumLineSpacing = padding_x;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame) + 10, collectionViewWidth, SelfViewHeight - CGRectGetMaxY(btn.frame))
                                         collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[RootVCCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_ID"];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - 推出选择界面
- (void)pushToImagePickerView
{
    TZImagePickerController * imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - TZImagePickerControllerDelegate
/**
 *  选择图片
 *
 *  @param picker
 *  @param photos
 *  @param assets
 */
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
{
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    
    [_selectedArray addObjectsFromArray:photos];
    [_collectionView reloadData];
    _collectionView.contentSize = CGSizeMake(0, (_selectedArray.count + 2)/3 * itemHeight);
}

- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
                        infos:(NSArray<NSDictionary *> *)infos
{
    
}

/**
 *  选择视频
 *
 *  @param picker
 *  @param coverImage
 *  @param asset
 */
- (void)imagePickerController:(TZImagePickerController *)picker
        didFinishPickingVideo:(UIImage *)coverImage
                 sourceAssets:(id)asset
{
    [_selectedArray addObjectsFromArray:[NSArray arrayWithObjects:coverImage, nil]];
    [_collectionView reloadData];
    _collectionView.contentSize = CGSizeMake(0, (_selectedArray.count + 2)/3 * itemHeight);
}

/**
 *  取消
 */
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}


#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _selectedArray.count) { //点击的是最后一个加号
        [self pushToImagePickerView];
    }else {
        // 查看图片
        
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"------ select: %d", (int)_selectedArray.count);
    return _selectedArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RootVCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_ID" forIndexPath:indexPath];

    UIImage * image;
    if (indexPath.row == _selectedArray.count) {
        image = [UIImage imageNamed:@"AlbumAddBtn"];
    }else {
        image = _selectedArray[indexPath.row];
    }
    [cell setContentWithImage:image];
    
    return cell;
}




@end
