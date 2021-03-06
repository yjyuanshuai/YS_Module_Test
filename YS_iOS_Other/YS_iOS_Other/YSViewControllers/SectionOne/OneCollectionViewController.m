//
//  OneCollectionViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneCollectionViewController.h"
#import "OneCollectionCollectionViewCell.h"
#import "OneCollectionReusableView.h"
#import "CollectionTestModel.h"

static NSString * collection_cell_id = @"collection_cell_id";
static NSString * collection_header = @"collection_header";
static NSString * collection_footer = @"collection_footer";

#pragma mark - OneCollectionViewController -
@interface OneCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collecionView;

@end

@implementation OneCollectionViewController
{
    ComeFromType _comefromType;
    NSArray * _collectionSectionTitles;
    NSMutableArray * _collectionArr;
}

- (instancetype)initWithType:(ComeFromType)type
{
    if (self = [super init]) {
        _comefromType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (_comefromType) {
        case ComeFromTypeOneCollection:
        {
            self.title = @"Collection";
        }
            break;
        case ComeFromTypeTwoDocument:
        {
            self.title = @"沙盒";
        }
            break;
        case ComeFromTypeTwoFile:
        {
            self.title = @"文件";
        }
            break;
        case ComeFromTypeTwoArchive:
        {
            self.title = @"归档";
        }
            break;
        case ComeFromTypeTwoSqlite:
        {
            self.title = @"Sqlite";
        }
            break;
        case ComeFromTypeTwoCoreData:
        {
            self.title = @"CoreData";
        }
            break;
            
        default:
            break;
    }
    
    [self initUIAndData];
    [self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)initUIAndData
{
    _collectionSectionTitles = @[@"第一段", @"第二段", @"第三段"];
    
    // 4    6    3
    NSMutableArray * sectionOne = [NSMutableArray arrayWithArray:@[[self getCollectionModle:@"1" title:@"主题" desc:@"详情"],
                                                            [self getCollectionModle:@"2" title:@"主题" desc:@"详情"],
                                                            [self getCollectionModle:@"3" title:@"主题" desc:@"详情"],
                                                            [self getCollectionModle:@"4" title:@"主题" desc:@"详情"]]];
    
    NSMutableArray * sectionTwo = [NSMutableArray arrayWithArray:@[[self getCollectionModle:@"5" title:@"主题" desc:@"详情"],
                                                                   [self getCollectionModle:@"6" title:@"主题" desc:@"详情"],
                                                                   [self getCollectionModle:@"7" title:@"主题" desc:@"详情"],
                                                                   [self getCollectionModle:@"8" title:@"主题" desc:@"详情"],
                                                                   [self getCollectionModle:@"9" title:@"主题" desc:@"详情"]]];
    
    NSMutableArray * sectionThree = [NSMutableArray arrayWithArray:@[[self getCollectionModle:@"10" title:@"主题" desc:@"详情"],
                                                                     [self getCollectionModle:@"11" title:@"主题" desc:@"详情"],
                                                                     [self getCollectionModle:@"12" title:@"主题" desc:@"详情"]]];
    if (_collectionArr == nil) {
        _collectionArr = [NSMutableArray arrayWithArray:@[sectionOne, sectionTwo, sectionThree]];
    }
}

- (CollectionTestModel *)getCollectionModle:(NSString *)imageName title:(NSString *)title desc:(NSString *)desc
{
    CollectionTestModel * model = [[CollectionTestModel alloc] initWithImageName:imageName title:title desc:desc];
    return model;
}

- (void)initCollectionView
{
    // 自定义布局
    UICollectionViewFlowLayout * collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _collecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:collectionLayout];
    _collecionView.backgroundColor = [UIColor whiteColor];
    _collecionView.delegate = self;
    _collecionView.dataSource = self;
    [self.view addSubview:_collecionView];
    
//    _collecionView.transform = CGAffineTransformMakeRotation(M_PI/2*3);
    
    // 注册cell
    [_collecionView registerClass:[OneCollectionCollectionViewCell class] forCellWithReuseIdentifier:collection_cell_id];
    [_collecionView registerClass:[OneCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collection_header];
    [_collecionView registerClass:[OneCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collection_footer];
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_collectionSectionTitles count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_collectionArr objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OneCollectionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collection_cell_id forIndexPath:indexPath];
    
    CollectionTestModel * model = [[_collectionArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell setContentWithModel:model];
    
    return cell;
}

// 段头 / 段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        OneCollectionReusableView * header = [_collecionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collection_header forIndexPath:indexPath];
        
        header.headerLabel.text = [_collectionSectionTitles objectAtIndex:indexPath.section];
        header.backgroundColor = [UIColor redColor];
        
        return header;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        OneCollectionReusableView * footer = [_collecionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collection_footer forIndexPath:indexPath];
        footer.backgroundColor = [UIColor orangeColor];
        return footer;
        
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

}

#pragma mark - UICollectionViewDelegate -
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    OneCollectionCollectionViewCell * cell = (OneCollectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    OneCollectionCollectionViewCell * cell = (OneCollectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"-------- 点击了 %d 段 %d 个item -----------", (int)indexPath.section, (int)indexPath.row);
}

// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        return YES;
    }
    
    return NO;
}

//
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
    {
        NSLog(@"-------------执行拷贝-------------");
        
        [collectionView performBatchUpdates:^{
            
            [[_collectionArr objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        } completion:nil];
    }
    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        NSLog(@"-------------执行粘贴-------------");
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout -

// Item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 120);
}

// section header size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){[[UIScreen mainScreen] bounds].size.width,44};
}

// section footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){[[UIScreen mainScreen] bounds].size.width,22};
}

// 上左下右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

// 上下 item 最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

// 左右 item 最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


@end
