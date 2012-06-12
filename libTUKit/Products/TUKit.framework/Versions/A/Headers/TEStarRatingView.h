//
//  TEStarRatingView.h
//  TEStarRating
//
//  Created by GDX on 12/4/3.
//  Copyright (c) 2012年 28 interactive inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "TEArcCompatible.h"

@interface TEStarRatingView : UIView

@property (STRONG, nonatomic) UIImage *starImage;
@property (STRONG, nonatomic) UIImage *highlightedStarImage;
@property (assign, nonatomic) NSUInteger numberOfStars;
@property (assign, nonatomic) CGFloat rating;

@end
