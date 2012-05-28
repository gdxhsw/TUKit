//
//  TETableViewExpandableDelegate.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewExpandableDelegate.h"
#import "TETableViewDataSource.h"

@implementation TETableViewExpandableDelegate

@synthesize canExpandMultipleItem = _canExpandMultipleItem;

#pragma mark - Initial methods

- (id)initWithExpandMultipleItem:(BOOL)multipleItem {
    self = [super init];
    if (self) {
        _canExpandMultipleItem = multipleItem;
    }
    return self;
}

#pragma mark - Override methods

- (NSIndexPath *)expandForIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView {
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    id item = [dataSource itemForIndexPath:indexPath];
    NSIndexPath *finalIndexPath = indexPath;
    if ([item isKindOfClass:[TETableViewExpandableItem class]]) {
        TETableViewExpandableItem *expandableItem = (TETableViewExpandableItem *)item;
        NSIndexPath *expandIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1
                                                          inSection:indexPath.section];
        [tableView beginUpdates];
        expandableItem.expanded = !expandableItem.expanded;
        if (expandableItem.expanded) {
            // Expand
            if (!self.canExpandMultipleItem && _oldExpandIndexPath) {
                _oldExpandItem.expanded = NO;
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_oldExpandIndexPath]
                                 withRowAnimation:UITableViewRowAnimationTop];
                if (_oldExpandIndexPath.section == expandIndexPath.section && _oldExpandIndexPath.row < expandIndexPath.row) {
                    expandIndexPath = [NSIndexPath indexPathForRow:expandIndexPath.row - 1
                                                         inSection:expandIndexPath.section];
                    finalIndexPath = [NSIndexPath indexPathForRow:expandIndexPath.row - 1
                                                        inSection:expandIndexPath.section];
                }
            }
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:expandIndexPath]
                             withRowAnimation:UITableViewRowAnimationMiddle];
        }
        else {
            // Shrink
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:expandIndexPath]
                             withRowAnimation:UITableViewRowAnimationTop];
            expandIndexPath = nil;
            expandableItem = nil;
        }
        [tableView endUpdates];
        _oldExpandIndexPath = expandIndexPath;
        _oldExpandItem = expandableItem;
    }
    return finalIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    NSIndexPath *selectedIndexPath = [self expandForIndexPath:indexPath
                                                withTableView:tableView];
    TETableViewItem *item = [dataSource itemForIndexPath:selectedIndexPath];
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectItem:atIndexPath:)]) {
        [self.delegate tableView:tableView
                   didSelectItem:item
                     atIndexPath:selectedIndexPath];
    }
}

@end
