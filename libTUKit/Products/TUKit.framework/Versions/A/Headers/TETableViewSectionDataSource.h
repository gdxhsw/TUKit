//
//  TETableViewSectionDataSource.h
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDataSource.h"
#include "TEArcCompatible.h"

@interface TETableViewSection : NSObject

@property (STRONG, nonatomic) NSArray *items;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *footer;

@end


@interface TETableViewSectionDataSource : TETableViewDataSource

@end
