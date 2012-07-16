//
//  TETableViewItem.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TETableViewItem <NSObject>

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView;

@optional
- (CGFloat)cellHeightWithTableView:(UITableView *)tableView;

@end
