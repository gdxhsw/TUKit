//
//  TETableViewItem.h
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"

@interface TETableViewItem : NSObject

@property (assign, nonatomic) NSInteger tag;
@property (STRONG, nonatomic) id object;

@property (STRONG, nonatomic) Class cellClass;
@property (copy, nonatomic) NSString *cellReuseIdentifier;
@property (copy, nonatomic) NSString *cellNibName;
@property (assign, nonatomic) NSUInteger cellNibIndex;
@property (assign, nonatomic) UITableViewCellStyle cellStyle;

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex;
+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName;
+ (id)itemWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex;
- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName;
- (id)initWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
