//
//  TETableViewExpandableItem.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"

@protocol TETableViewExpandableItem <TETableViewItem>

- (id <TETableViewItem>) expandItem;

@end