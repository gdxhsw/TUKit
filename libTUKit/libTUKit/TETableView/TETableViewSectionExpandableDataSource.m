//
//  TETableViewSectionExpandableDataSource.m
//  eTag
//
//  Created by  on 12/5/27.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewSectionExpandableDataSource.h"
#import "TETableViewExpandableItem.h"
#import "TETableViewSectionDataSource.h"

@implementation TETableViewSectionExpandableDataSource

#pragma mark - Override methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <TETableViewItem> item = [self itemForIndexPath:indexPath];
    return [item cellWithTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TETableViewSection *s = [self.items objectAtIndex:section];
    return s.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    TETableViewSection *s = (TETableViewSection *)[self.items objectAtIndex:section];
    return s.footer;
}

- (id <TETableViewItem>)itemForIndexPath:(NSIndexPath *)indexPath {
    TETableViewSection *sec = [self.items objectAtIndex:indexPath.section];
    NSInteger count = 0;
    NSInteger expandedCount = 0;
    for (id <TETableViewItem> item in sec.items) {
        if (count == indexPath.row) {
            break;
        }
        if ([item conformsToProtocol:@protocol(TETableViewExpandableItem)]) {
            id <TETableViewExpandableItem> expandableItem = (id <TETableViewExpandableItem>)item;
            if ([self didExpandWithItem:expandableItem]) {
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
    return [sec.items objectAtIndex:count - expandedCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TETableViewSection *sec = [self.items objectAtIndex:section];
    NSInteger count = 0;
    for (id item in sec.items) {
        if ([item conformsToProtocol:@protocol(TETableViewExpandableItem)]) {
            id <TETableViewExpandableItem> expandableItem = item;
            if ([self didExpandWithItem:expandableItem]) {
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
