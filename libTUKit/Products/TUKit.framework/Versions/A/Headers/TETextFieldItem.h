//
//  TETextFieldItem.h
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"
#include "TEArcCompatible.h"

@interface TETextFieldItem : NSObject <TETableViewItem>

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *text;
@property (WEAK, nonatomic) id <UITextFieldDelegate> delegate;

+ (id)itemWithTitle:(NSString *)title;
+ (id)itemWithTitle:(NSString *)title text:(NSString *)text;
- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title text:(NSString *)text;

@end
