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

@interface TETableViewDataSource : NSObject <UITableViewDataSource, TEModelDelegate>

@property (STRONG, atomic) NSArray *items;

- (id <TETableViewItem>)itemForIndexPath:(NSIndexPath *)indexPath;

@end


@protocol TETableViewDataSourceDelegate <NSObject>

- (void)itemDidChangeWithDataSource:(TETableViewDataSource *)dataSource;

@end