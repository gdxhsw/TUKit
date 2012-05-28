//
//  TETableViewDelegate.m
//  Sniff
//
//  Created by  on 12/4/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDelegate.h"
#import "TETableViewDataSource.h"
#import "TETableViewCell.h"

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
    TETableViewItem *item = [dataSource itemForIndexPath:indexPath];
    Class cellClass = [item cellClass];
    return [cellClass cellHeightWithObject:item];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    _delegate = nil;
    [super dealloc];
}
#endif

@end
