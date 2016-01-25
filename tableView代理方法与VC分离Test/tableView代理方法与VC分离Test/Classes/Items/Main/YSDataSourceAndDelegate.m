//
//  YSDataSourceAndDelegate.m
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSDataSourceAndDelegate.h"

@implementation YSDataSourceAndDelegate

- (instancetype)initWithData:(NSArray *)data
                   identifer:(NSArray *)identifer
{
    if (self = [super init]) {
        self.dataArr = data;
        self.identiferArr = identifer;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.identiferArr[0]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identiferArr[0]];
    }
//    NSLog(@"---------- %@", [self.dataArr objectAtIndex:indexPath.row]);
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

@end
