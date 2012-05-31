//
//  TETableViewExpandableDataSource.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDataSource.h"
#include "TEArcCompatible.h"
#import "TETableViewExpandableItem.h"

@interface TETableViewExpandableDataSource : TETableViewDataSource {
    NSMutableArray *_expanded;
}

- (BOOL)didExpandWithItem:(id <TETableViewExpandableItem>)item;
- (void)expandItem:(id <TETableViewExpandableItem>)item;
- (void)shrinkItem:(id <TETableViewExpandableItem>)item;

@end
