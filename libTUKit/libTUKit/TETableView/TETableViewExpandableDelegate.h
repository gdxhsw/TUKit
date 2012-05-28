//
//  TETableViewExpandableDelegate.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDelegate.h"
#import "TETableViewExpandableItem.h"

@interface TETableViewExpandableDelegate : TETableViewDelegate {
    TETableViewExpandableItem *_oldExpandItem;
    NSIndexPath *_oldExpandIndexPath;
}

@property (readonly, nonatomic) BOOL canExpandMultipleItem;

- (NSIndexPath *)expandForIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView;

- (id)initWithExpandMultipleItem:(BOOL)multipleItem;

@end
