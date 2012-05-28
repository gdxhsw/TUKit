//
//  TETableViewCell.h
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "TEArcCompatible.h"

@interface TETableViewCell : UITableViewCell

@property (STRONG, nonatomic) id object;

- (void)loadView;
+ (CGFloat)cellHeightWithObject:(id)object;

@end
