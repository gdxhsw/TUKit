//
//  TETableViewDelegate.m
//  Sniff
//
//  Created by  on 12/4/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDelegate.h"
#import "TETableViewDataSource.h"

@implementation TETableViewDelegate

@synthesize delegate = _delegate;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectItem:atIndexPath:)]) {
        TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
        id item = [dataSource itemForIndexPath:indexPath];
        [self.delegate tableView:tableView
                   didSelectItem:item
                     atIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    id <TETableViewItem> item = [dataSource itemForIndexPath:indexPath];
    if ([item respondsToSelector:@selector(cellHeight)]) {
        return [item cellHeight];
    }
    else {
        return 44.0f;
    }
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    _delegate = nil;
    [super dealloc];
}
#endif

@end
