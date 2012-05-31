//
//  TETableViewExpandableDelegate.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewExpandableDelegate.h"
#import "TETableViewExpandableDataSource.m"

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
    TETableViewExpandableDataSource *dataSource = (TETableViewExpandableDataSource *)tableView.dataSource;
    id item = [dataSource itemForIndexPath:indexPath];
    NSIndexPath *finalIndexPath = indexPath;
    if ([item conformsToProtocol:@protocol(TETableViewExpandableItem)]) {
        id <TETableViewExpandableItem> expandableItem = (id <TETableViewExpandableItem>)item;
        NSIndexPath *expandIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1
                                                          inSection:indexPath.section];
        [tableView beginUpdates];
        BOOL expanded = [dataSource didExpandWithItem:expandableItem];
        if (expanded) {
            [dataSource shrinkItem:expandableItem];
        }
        else {
            [dataSource expandItem:expandableItem];
        }
        expanded = !expanded;
        if (expanded) {
            // Expand
            if (!self.canExpandMultipleItem && _oldExpandIndexPath) {
                [dataSource shrinkItem:_oldExpandItem];
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
#if __has_feature(objc_arc)
        _oldExpandIndexPath = expandIndexPath;
        _oldExpandItem = expandableItem;
#else
        [_oldExpandIndexPath release];
        _oldExpandIndexPath = [expandIndexPath retain];
        [_oldExpandItem release];
        _oldExpandItem = [expandableItem retain];
#endif
    }
    return finalIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    NSIndexPath *selectedIndexPath = [self expandForIndexPath:indexPath
                                                withTableView:tableView];
    id <TETableViewItem> item = [dataSource itemForIndexPath:selectedIndexPath];
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectItem:atIndexPath:)]) {
        [self.delegate tableView:tableView
                   didSelectItem:item
                     atIndexPath:selectedIndexPath];
    }
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_oldExpandItem);
    TERELEASE(_oldExpandItem);
    
    [super dealloc];
}
#endif

@end
