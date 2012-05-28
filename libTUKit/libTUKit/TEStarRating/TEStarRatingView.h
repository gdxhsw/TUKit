//
//  TEStarRatingView.h
//  TEStarRating
//
//  Created by GDX on 12/4/3.
//  Copyright (c) 2012年 28 interactive inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEStarRatingView : UIView

#if !__has_feature(objc_arc)
@property (retain, nonatomic) UIImage *starImage;
@property (retain, nonatomic) UIImage *highlightedStarImage;
#else
@property (strong, nonatomic) UIImage *starImage;
@property (strong, nonatomic) UIImage *highlightedStarImage;
#endif
@property (assign, nonatomic) NSUInteger numberOfStars;
@property (assign, nonatomic) CGFloat rating;

@end
