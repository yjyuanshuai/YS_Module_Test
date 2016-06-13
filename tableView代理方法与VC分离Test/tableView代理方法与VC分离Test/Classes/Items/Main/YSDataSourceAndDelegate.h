//
//  YSDataSourceAndDelegate.h
//  tableView代理方法与VC分离Test
//
//  Created by YJ on 16/1/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YSDataSourceAndDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) NSArray * identiferArr;
//@property (nonatomic,)

- (instancetype)initWithData:(NSArray *)data
                   identifer:(NSArray *)identifer;

@end
