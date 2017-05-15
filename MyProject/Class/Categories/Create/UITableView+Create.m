//
//  UITableView+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UITableView+Create.h"

@implementation UITableView (Create)

+ (instancetype)tableViewOfStyle:(UITableViewStyle)style
                          inView:(__kindof UIView *)inView
                  withDatasource:(id <UITableViewDataSource>)dataSource
                        delegate:(id <UITableViewDelegate>)delegate {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    if (dataSource && [dataSource conformsToProtocol:@protocol(UITableViewDataSource)]) {
        tableView.dataSource = dataSource;
    }
    if (delegate && [delegate conformsToProtocol:@protocol(UITableViewDelegate)]) {
        tableView.delegate = delegate;
    }
    return tableView;
}

@end
