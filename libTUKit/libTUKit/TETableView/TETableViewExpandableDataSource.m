//
//  TETableViewExpandableDataSource.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewExpandableDataSource.h"
#import "TETableViewExpandableItem.h"

@implementation TETableViewExpandableDataSource

#pragma mark - Override methods

- (TETableViewItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    NSInteger expandedCount = 0;
    for (TETableViewItem *item in self.items) {
        if (count == indexPath.row) {
            break;
        }
        if ([item isKindOfClass:[TETableViewExpandableItem class]]) {
            TETableViewExpandableItem *expandableItem = (TETableViewExpandableItem *)item;
            if (expandableItem.expanded) {
                if (count + 1 == indexPath.row) {
                    return [expandableItem expandItem];
                }
                expandedCount += 1;
                count += 2;
            }
            else {
                count += 1;
            }
        }
        else {
            count += 1;
        }
    }
    return [self.items objectAtIndex:count - expandedCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    for (id item in self.items) {
        if ([item isKindOfClass:[TETableViewExpandableItem class]]) {
            TETableViewExpandableItem *expandableItem = item;
            if (expandableItem.expanded) {
                count += 2;
            }
            else {
                count += 1;
            }
        }
        else {
            count += 1;
        }
    }
    return count;
}

@end
