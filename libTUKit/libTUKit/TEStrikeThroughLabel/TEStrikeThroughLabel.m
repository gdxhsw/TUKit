//
//  TELabelStrikeThrough.m
//
//  Created by GDX on 12/4/1.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEStrikeThroughLabel.h"

@implementation TEStrikeThroughLabel

@synthesize strikeThroughEnabled = _strikeThroughEnabled;
@synthesize strikeThroughColor = _strikeThroughColor;
@synthesize strikeThroughWidth = _strikeThroughWidth;
@synthesize strikeThroughStyle = _strikeThroughStyle;
    
- (void)initStrikeThrough {
    self.strikeThroughEnabled = YES;
    self.strikeThroughColor = nil;
    self.strikeThroughWidth = 2.0f;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initStrikeThrough];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initStrikeThrough];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initStrikeThrough];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.strikeThroughEnabled) {
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        if (self.strikeThroughColor == nil) {
            CGContextSetStrokeColorWithColor(c, [self.textColor CGColor]);
        }
        else {
            CGContextSetStrokeColorWithColor(c, [self.strikeThroughColor CGColor]);
        }
        CGContextSetLineWidth(c, self.strikeThroughWidth);
        CGContextBeginPath(c);
        CGSize textSize = [self.text sizeWithFont:self.font
                                constrainedToSize:self.frame.size];
        CGFloat halfWayUp = textSize.height / 2.0f + 1.0f;
        CGFloat xOffset = self.bounds.origin.x;
        switch (self.textAlignment) {
            case UITextAlignmentCenter:
                xOffset += (self.bounds.size.width - textSize.width) / 2.0f;
                break;
            case UITextAlignmentRight:
                xOffset += self.bounds.size.width - textSize.width;
                break;
            default:
                xOffset += 0.0f;
        }
        if (self.strikeThroughStyle == TEStrikeThroughLabelStyleSlash) {
            CGContextMoveToPoint(c, xOffset, self.bounds.origin.y + 5.0f);
            CGContextAddLineToPoint(c, xOffset + textSize.width, self.bounds.origin.y + textSize.height - 5.0f);
        }
        else {
            CGContextMoveToPoint(c, xOffset, halfWayUp);
            CGContextAddLineToPoint(c, xOffset + textSize.width, halfWayUp);
        }
        CGContextStrokePath(c);
    }
    
    [super drawRect:rect];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_strikeThroughColor);
    [super dealloc];
}
#endif

@end
