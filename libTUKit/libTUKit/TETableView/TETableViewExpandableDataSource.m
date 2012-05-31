//
//  TETableViewExpandableDataSource.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewExpandableDataSource.h"

@implementation TETableViewExpandableDataSource

#pragma mark - Public methods

- (BOOL)didExpandWithItem:(id <TETableViewExpandableItem>)item {
    NSInteger index = [self.items indexOfObject:item];
    if (index != NSNotFound) {
        NSNumber *expanded = [_expanded objectAtIndex:index];
        return [expanded boolValue];
    }
    return NO;
}

- (void)expandItem:(id <TETableViewExpandableItem>)item {
    NSInteger index = [self.items indexOfObject:item];
    if (index != NSNotFound) {
        [_expanded replaceObjectAtIndex:index
                             withObject:[NSNumber numberWithBool:YES]];
    }
}

- (void)shrinkItem:(id <TETableViewExpandableItem>)item {
    NSInteger index = [self.items indexOfObject:item];
    if (index != NSNotFound) {
        [_expanded replaceObjectAtIndex:index
                             withObject:[NSNumber numberWithBool:NO]];
    }
}

#pragma mark - Override methods

- (void)setItems:(NSMutableArray *)items {
    [super setItems:items];
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:items.count];
    for (int i = 0; i < items.count; i++) {
        [tmp addObject:[NSNumber numberWithBool:NO]];
    }
#if !__has_feature(objc_arc)
    TERELEASE(_expanded);
#endif
    _expanded = tmp;
}

- (id <TETableViewItem>)itemForIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    NSInteger index = 0;
    NSInteger expandedCount = 0;
    for (id <TETableViewItem> item in self.items) {
        if (count == indexPath.row) {
            break;
        }
        if ([item conformsToProtocol:@protocol(TETableViewExpandableItem)]) {
            NSNumber *expanded = [_expanded objectAtIndex:index];
            if ([expanded boolValue]) {
                if (count + 1 == indexPath.row) {
                    id <TETableViewExpandableItem> expandableItem = (id <TETableViewExpandableItem>)item;
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
        index++;
    }
    return [self.items objectAtIndex:count - expandedCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    NSInteger index = 0;
    for (id item in self.items) {
        if ([item conformsToProtocol:@protocol(TETableViewExpandableItem)]) {
            NSNumber *expanded = [_expanded objectAtIndex:index];
            if ([expanded boolValue]) {
                count += 2;
            }
            else {
                count += 1;
            }
        }
        else {
            count += 1;
        }
        index++;
    }
    return count;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_expanded);
    
    [super dealloc];
}
#endif

@end
