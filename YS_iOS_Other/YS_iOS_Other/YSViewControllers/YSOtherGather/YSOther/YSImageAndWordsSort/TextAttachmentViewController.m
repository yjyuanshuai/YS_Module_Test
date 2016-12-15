//
//  TextAttachmentViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TextAttachmentViewController.h"

@interface TextAttachmentViewController ()

@end

@implementation TextAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*****
 1、组装表情和文字对应的 plist 文件
 2、解析转化为 数组
 3、创建 NSMutableAttributedString
 4、通过正则表达式匹配字符串，NSRegularExpression
 5、将特殊字符与对应表情关联
 6、将特殊字符替换成图片
 
 ****/

- (void)analysePList
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray * emoArr = [NSArray arrayWithContentsOfFile:path];
}

@end
