//
//  TETableViewSectionExpandableDataSource.m
//  eTag
//
//  Created by  on 12/5/27.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewSectionExpandableDataSource.h"
#import "TETableViewExpandableItem.h"

@implementation TETableViewSectionExpandableDataSource

#pragma mark - Override methods

- (TETableViewItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    TETableViewSection *sec = [self.items objectAtIndex:indexPath.section];
    NSInteger count = 0;
    NSInteger expandedCount = 0;
    for (TETableViewItem *item in sec.items) {
        if (count == indexPath.row) {
            break;
        }
        if ([item isKindOfClass:[TETableViewExpandableItem class]]) {
            TETableViewExpandableItem *expandableItem = (TETableViewExpandableItem *)item;
            if (expandableItem.expanded) {
                if (count + 1 == indexPath.row) {
                    return expandableItem.expandItem;
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
    return [sec.items objectAtIndex:count - expandedCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TETableViewSection *sec = [self.items objectAtIndex:section];
    NSInteger count = 0;
    for (id item in sec.items) {
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
