//
//  TESwitchItem.h
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"
#include "TEArcCompatible.h"

@protocol TESwitchItemDelegate;


@interface TESwitchItem : NSObject <TETableViewItem>

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL on;
@property (WEAK, nonatomic) id <TESwitchItemDelegate> delegate;

+ (id)itemWithTitle:(NSString *)title;
+ (id)itemWithTitle:(NSString *)title on:(BOOL)on;
- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title on:(BOOL)on;

@end


@protocol TESwitchItemDelegate <NSObject>

- (void)switchItemValueDidChanged:(TESwitchItem *)item;

@end