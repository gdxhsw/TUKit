//
//  TETableViewSelectableDelegate.m
//  libTUKit
//
//  Created by gdx on 12/12/30.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewSelectableDelegate.h"
#import "TETableViewDataSource.h"

@implementation TETableViewSelectableDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *oldSelectedIndexPath = self.selectedIndexPath;
    
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    id <TETableViewSelectableItem> selectedItem = (id <TETableViewSelectableItem>)[dataSource itemForIndexPath:indexPath];
    
    if (!oldSelectedIndexPath || oldSelectedIndexPath.section != indexPath.section || oldSelectedIndexPath.row != indexPath.row) {
        selectedItem.selected = YES;
        self.selectedIndexPath = indexPath;
    }
    else {
        if (self.shouldDeselectItem) {
            selectedItem.selected = NO;
            self.selectedIndexPath = nil;
            oldSelectedIndexPath = nil;
        }
        else {
            return;
        }
    }
    
    if (oldSelectedIndexPath) {
        id <TETableViewSelectableItem> oldItem = [dataSource.items objectAtIndex:oldSelectedIndexPath.row];
        oldItem.selected = NO;
        [tableView reloadRowsAtIndexPaths:@[oldSelectedIndexPath, indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        [tableView reloadRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    if ([self.actionDelegate respondsToSelector:@selector(tableView:didSelectItem:atIndexPath:)]) {
        [self.actionDelegate tableView:tableView
                         didSelectItem:selectedItem
                           atIndexPath:indexPath];
    }
}

@end
