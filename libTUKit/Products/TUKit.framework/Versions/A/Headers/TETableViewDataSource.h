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

@property (STRONG, atomic) NSArray *items;
@property (WEAK, nonatomic) id <TETableViewDataSourceDelegate> actionDelegate;

- (id <TETableViewItem>)itemForIndexPath:(NSIndexPath *)indexPath;

@end


@protocol TETableViewDataSourceDelegate <NSObject>

- (void)dataSource:(TETableViewDataSource *)dataSource withTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(TETableViewDataSource *)dataSource withTableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end