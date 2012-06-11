//
//  TERoundedCornerImageView.m
//
//  Created by GDX on 12/4/16.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TERoundedCornerImageView.h"

@implementation TERoundedCornerImageView

@synthesize cornerRadius = _cornerRadius;

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - Lifecycle

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, self.cornerRadius, self.cornerRadius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    [self.image drawInRect:rect];
}

- (void)drawRect:(CGRect)rect forViewPrintFormatter:(UIViewPrintFormatter *)formatter {
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cornerRadius = 9.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cornerRadius = 9.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cornerRadius = 9.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        self.cornerRadius = 9.0f;
    }
    return self;
}

@end
