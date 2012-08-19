//
//  TESelectItem.h
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"
#include "TEArcCompatible.h"

@protocol TESelectItemDelegate;


@interface TESelectItem : NSObject <TETableViewItem>

@property (copy, nonatomic) NSString *title;
@property (readonly, nonatomic) NSArray *items;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) UISegmentedControlStyle segmentedControlStyle;
@property (WEAK, nonatomic) id <TESelectItemDelegate> delegate;

+ (id)itemWithTitle:(NSString *)title items:(NSArray *)items;
+ (id)itemWithTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex;
- (id)initWithTitle:(NSString *)title items:(NSArray *)items;
- (id)initWithTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex;

@end


@protocol TESelectItemDelegate <NSObject>

- (void)selectItemValueDidChanged:(TESelectItem *)item;

@end