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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.actionDelegate respondsToSelector:@selector(tableView:didSelectItem:atIndexPath:)]) {
        TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
        id item = [dataSource itemForIndexPath:indexPath];
        [self.actionDelegate tableView:tableView
                   didSelectItem:item
                     atIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
    id <TETableViewItem> item = [dataSource itemForIndexPath:indexPath];
    if ([item respondsToSelector:@selector(cellHeightWithTableView:)]) {
        return [item cellHeightWithTableView:tableView];
    }
    else {
        return 44.0f;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.actionDelegate respondsToSelector:@selector(tableView:willDisplayItem:atIndexPath:)]) {
        TETableViewDataSource *dataSource = (TETableViewDataSource *)tableView.dataSource;
        id <TETableViewItem> item = [dataSource itemForIndexPath:indexPath];
        [self.actionDelegate tableView:tableView
                 willDisplayItem:item
                     atIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.actionDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.actionDelegate scrollViewDidEndDragging:scrollView
                                 willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.actionDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.actionDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.actionDelegate scrollViewDidEndZooming:scrollView
                                      withView:view
                                       atScale:scale];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.actionDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.actionDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.actionDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.actionDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.actionDelegate scrollViewWillBeginZooming:scrollView
                                         withView:view];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.actionDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.actionDelegate scrollViewWillEndDragging:scrollView
                                    withVelocity:velocity
                             targetContentOffset:targetContentOffset];
    }
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    _delegate = nil;
    [super dealloc];
}
#endif

@end
