//
//  ViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "OnePickerViewController.h"
#import "OneCollectionViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * otherTableView;

@end

@implementation ViewController
{
    NSArray * _sectionTitle;
    NSMutableArray * _sectionCellContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"其他";
    
    _sectionTitle = @[@"1 控件", @"2 数据持久化", @"3 iCloud", @"4 GCD", @"5 Quartz/OpenGL", @"6 手势/触摸", @"7 Location", @"8 陀螺仪/加速器", @"9 照相机/相片库", @"10 本地化"];
    
    
    NSArray * sectionOne    = @[@"Picker", @"CollectionView"];
    NSArray * sectionTwo    = @[@"沙盒", @"文件", @"归档", @"sqlite", @"CoreData"];
    NSArray * sectionThree  = @[@"使用UIDocument管理文件存储", @"添加iCloud支持"];
    NSArray * sectionFour   = @[@"GCD"];
    NSArray * sectionFive   = @[@"Quartz", @"OpenGL"];
    NSArray * sectionSix    = @[@"手势", @"触摸"];
    NSArray * sectionSeven  = @[@"原生", @"百度", @"高德"];
    NSArray * sectionEight  = @[@"陀螺仪", @"照片库"];
    NSArray * sectionNine   = @[@"照相机", @"相片库"];
    NSArray * sectionTen    = @[@"本地化"];
    
    if (_sectionCellContent == nil) {
        _sectionCellContent = [NSMutableArray array];
    }
    
    _sectionCellContent = [NSMutableArray arrayWithArray:@[sectionOne, sectionTwo, sectionThree, sectionFour, sectionFive, sectionSix, sectionSeven, sectionEight, sectionNine, sectionTen]];
    
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableView
{
    _otherTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _otherTableView.delegate = self;
    _otherTableView.dataSource = self;
    [self.view addSubview:_otherTableView];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sectionCellContent objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    NSArray * sectionContent = [_sectionCellContent objectAtIndex:indexPath.section];
    cell.textLabel.text = [sectionContent objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionTitle objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    int sectionIndex = (int)indexPath.section;
    switch (sectionIndex) {
        case 0:
        {
            if (indexPath.row == 0) {
                // "Picker"
                OnePickerViewController * pickerVC = [[OnePickerViewController alloc] init];
                pickerVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pickerVC animated:YES];
                
            } else if (indexPath.row == 1) {
                // “CollectionView”
                OneCollectionViewController * collectionVC = [[OneCollectionViewController alloc] init];
                collectionVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectionVC animated:YES];
            }
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
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
        default:
            break;
    }
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
