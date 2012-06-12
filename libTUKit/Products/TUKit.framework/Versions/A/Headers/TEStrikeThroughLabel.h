//
//  TELabelStrikeThrough.h
//
//  Created by GDX on 12/4/1.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEArcCompatible.h"

typedef enum {
    TEStrikeThroughLabelStyleDefault,
    TEStrikeThroughLabelStyleSlash
} TEStrikeThroughLabelStyle;

@interface TEStrikeThroughLabel : UILabel

@property (STRONG, nonatomic) UIColor *strikeThroughColor;
@property (assign, nonatomic) BOOL strikeThroughEnabled;
@property (assign, nonatomic) NSUInteger strikeThroughWidth;
@property (assign, nonatomic) TEStrikeThroughLabelStyle strikeThroughStyle;

@end
