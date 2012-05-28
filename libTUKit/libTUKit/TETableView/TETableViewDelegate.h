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

@property (WEAK, nonatomic) id <TETableViewActionDelegate> delegate;

@end

@protocol TETableViewActionDelegate <NSObject>

@optional
- (void)tableView:(UITableView *)tableView didSelectItem:(TETableViewItem *)item atIndexPath:(NSIndexPath *)indexPath;

@end