//
//  TETableViewExpandableItem.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"

@interface TETableViewExpandableItem : TETableViewItem

@property (assign, nonatomic) BOOL expanded;
@property (STRONG, nonatomic) TETableViewItem *expandItem;

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex expandItem:(TETableViewItem *)expandItem;
+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName expandItem:(TETableViewItem *)expandItem;
+ (id)itemWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier expandItem:(TETableViewItem *)expandItem;

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex expandItem:(TETableViewItem *)expandItem;
- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName expandItem:(TETableViewItem *)expandItem;
- (id)initWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier expandItem:(TETableViewItem *)expandItem;

@end