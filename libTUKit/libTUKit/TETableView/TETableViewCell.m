//
//  TETableViewCell.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewCell.h"

@implementation TETableViewCell

@synthesize object = _object;

#pragma mark - Public methods

- (void)loadView {
    
}

+ (CGFloat)cellHeightWithObject:(id)object {
    return 44.0f;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_object);
    [super dealloc];
}
#endif

@end
