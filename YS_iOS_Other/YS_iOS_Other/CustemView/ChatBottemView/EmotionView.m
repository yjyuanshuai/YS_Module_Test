//
//  EmotionView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "EmotionView.h"
#import "EmotionCollectionViewCell.h"
#import "EmotionModel.h"

@implementation EmotionView

static NSString * const CellID = @"CellID";
static EmotionView * instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareEmotionView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.frame = CGRectMake(0, kScreenHeightNo64 - 170, kScreenWidth, 170);
        
        [instance analysisEmoData];
        [instance createSubViews];
    });
    return instance;
}

- (CGFloat)getEmotionViewHeight
{
    return (30*3+10*4) + 40;
}

#pragma mark -
- (void)createSubViews
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.emotionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30*3+10*4) collectionViewLayout:flowLayout];
    self.emotionCollectionView.delegate = self;
    self.emotionCollectionView.dataSource = self;
    self.emotionCollectionView.backgroundColor = YSDefaultGrayColor;
    [self addSubview:self.emotionCollectionView];
    
    [self.emotionCollectionView registerClass:[EmotionCollectionViewCell class] forCellWithReuseIdentifier:CellID];
    
    self.selectEmotionView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, kScreenWidth, 40)];
    self.selectEmotionView.backgroundColor = YSDefaultGrayColor;
    [self addSubview:self.selectEmotionView];
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.selectEmotionView.frame) - 40, 0, 40, 40)];
    [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"DeleteEmoticonBtn_ios7"] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectEmotionView addSubview:self.sendBtn];
}

- (void)sendMessage:(UIButton *)sendBtn
{
    
}

- (void)analysisEmoData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (!_emotionsArr) {
        _emotionsArr = [@[] mutableCopy];
    }
    
    // 枚举
    NSString * key;
    NSEnumerator * enumerator = [[dict allKeys] objectEnumerator];
    while (key = [enumerator nextObject]) {
        EmotionModel * model = [[EmotionModel alloc] init];
        model.cht = key;
        model.emo = dict[key];
        
        [_emotionsArr addObject:model];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmotionModel * model = _emotionsArr[indexPath.row];
    if (_returnSelectBlock) {
        _returnSelectBlock(model.cht);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_emotionsArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmotionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    EmotionModel * model = _emotionsArr[indexPath.row];
    [cell setEmoImageView:model.emo];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, (kScreenWidth - 30*7)/8, 10, (kScreenWidth - 30*7)/8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (kScreenWidth - 30*7)/8;
}

@end
