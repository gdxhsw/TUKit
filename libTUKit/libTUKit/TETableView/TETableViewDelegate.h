//
//  TETableViewDelegate.h
//  Sniff
//
//  Created by  on 12/4/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"
#import "TETableViewItem.h"

@protocol TETableViewActionDelegate;

@interface TETableViewDelegate : NSObject <UITableViewDelegate>

@property (WEAK, nonatomic) id <TETableViewActionDelegate> actionDelegate;

@end

@protocol TETableViewActionDelegate <UIScrollViewDelegate>

@optional
- (void)tableView:(UITableView *)tableView didSelectItem:(id <TETableViewItem>)item atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayItem:(id <TETableViewItem>)item atIndexPath:(NSIndexPath *)indexPath;

@end