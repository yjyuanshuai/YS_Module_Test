//
//  OneCollectionViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneCollectionViewController.h"
#import "OneCollectionCollectionViewCell.h"

static NSString * collection_cell_id = @"collection_cell_id";

@interface OneCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collecionView;

@end

@implementation OneCollectionViewController
{
    NSArray * _collectionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Collection";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCollectionView
{
    UICollectionViewLayout * collectionLayout = [[UICollectionViewLayout alloc] init];
    
    _collecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:collectionLayout];
    _collecionView.delegate = self;
    _collecionView.dataSource = self;
    [self.view addSubview:_collecionView];
    
    [_collecionView registerClass:[OneCollectionCollectionViewCell class] forCellWithReuseIdentifier:collection_cell_id];
}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    OneCollectionCollectionViewCell * cell = [collectionView dequeueReusableSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#> forIndexPath:<#(nonnull NSIndexPath *)#>];
    return nil;
}


@end
