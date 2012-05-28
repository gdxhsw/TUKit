//
//  TETableViewDataSource.h
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"
#import "TETableViewItem.h"
#import "TEModel.h"

@protocol TETableViewDataSourceDelegate;

@interface TETableViewDataSource : NSObject <UITableViewDataSource, TEModelDelegate>

@property (STRONG, nonatomic) NSMutableArray *items;
@property (STRONG, nonatomic) TEModel *model;
@property (WEAK, nonatomic) id <TETableViewDataSourceDelegate> delegate;

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView item:(TETableViewItem *)item;
- (TETableViewItem *)itemForIndexPath:(NSIndexPath *)indexPath;

@end


@protocol TETableViewDataSourceDelegate <NSObject>

- (void)itemDidChangeWithDataSource:(TETableViewDataSource *)dataSource;

@end