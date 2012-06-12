//
//  TEStarRatingView.h
//  TEStarRating
//
//  Created by GDX on 12/4/3.
//  Copyright (c) 2012年 28 interactive inc. All rights reserved.
//

#import "TEStarRatingView.h"

@interface TEStarRatingView ()

- (void)__updateView;
- (void)updateView;

@end


NSString *kDefaultStarImageName = @"__default_star";
NSString *kDefaultHighlightedStarImageName = @"__default_highlighted_star";
NSUInteger kDefaultNumberOfStars = 5;


@implementation TEStarRatingView

@synthesize rating = _rating;
@synthesize starImage = _starImage;
@synthesize highlightedStarImage = _highlightedStarImage;
@synthesize numberOfStars = _numberOfStars;

#pragma mark - Private methods

- (void)__updateView {
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)updateView {
    if ([NSThread isMainThread]) {
        [self __updateView];
    }
    else {
        [self performSelectorOnMainThread:@selector(__updateView)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

#pragma mark - Properties

- (void)setRating:(CGFloat)rating {
    if (_rating != rating) {
        if (rating > self.numberOfStars) {
            rating = self.numberOfStars;
        }
        if (rating < 0.0f) {
            rating = 0.0f;
        }
        _rating = rating;
        [self updateView];
    }
}

#pragma mark - Override methods

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat starWidth = rect.size.width / self.numberOfStars;
    CGFloat x = (starWidth - self.starImage.size.width) / 2.0f;
    CGFloat y = -(rect.size.height - self.starImage.size.height) / 2.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.starImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    for (int i = 0; i < self.numberOfStars; i++) {
        CGFloat dist = self.rating - i;
        if (dist >= 1.0f) {
            CGRect highlitedRect = CGRectMake(x, 
                                              y, 
                                              self.highlightedStarImage.size.width, 
                                              self.highlightedStarImage.size.height);
            CGContextDrawImage(context, highlitedRect, self.highlightedStarImage.CGImage);
        }
        else if (dist <= 0.0f) {
            CGRect normalRect = CGRectMake(x, 
                                           y, 
                                           self.starImage.size.width, 
                                           self.starImage.size.height);
            CGContextDrawImage(context, normalRect, self.starImage.CGImage);
        }
        else {
            // Draw half star
            CGFloat highlitedWidth = self.starImage.size.width * dist;
            CGRect highlitedRect = CGRectMake(x, 
                                              y, 
                                              highlitedWidth, 
                                              self.highlightedStarImage.size.height);
            UIGraphicsBeginImageContextWithOptions(highlitedRect.size, 
                                                   0.0f, 
                                                   0);
            CGContextRef highlitedImageContext = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(highlitedImageContext, 0, highlitedRect.size.height);
            CGContextScaleCTM(highlitedImageContext, 1.0, -1.0);
            CGContextDrawImage(highlitedImageContext, CGRectMake(0, 
                                                                 0, 
                                                                 self.highlightedStarImage.size.width, 
                                                                 self.highlightedStarImage.size.height), 
                               self.highlightedStarImage.CGImage);
            UIImage *highlitedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            CGFloat normalWidth = self.starImage.size.width - highlitedWidth;
            CGRect normalRect = CGRectMake(x + highlitedWidth, 
                                           y, 
                                           normalWidth, 
                                           self.starImage.size.height);
            UIGraphicsBeginImageContextWithOptions(highlitedRect.size, 
                                                   0.0f, 
                                                   0);
            CGContextRef normalImageContext = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(normalImageContext, 0, highlitedRect.size.height);
            CGContextScaleCTM(normalImageContext, 1.0, -1.0);
            CGContextDrawImage(normalImageContext, CGRectMake(-highlitedWidth, 
                                                              0, 
                                                              self.starImage.size.width, 
                                                              self.starImage.size.height), 
                               self.starImage.CGImage);
            UIImage *normalImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            CGContextDrawImage(context, normalRect, normalImage.CGImage);
            CGContextDrawImage(context, highlitedRect, highlitedImage.CGImage);
        }
        x += starWidth;
    }
    UIGraphicsEndImageContext();
    
    [super drawRect:rect];
}

#pragma mark - Lifecycle

- (void)initView {
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TUKitResources" 
                                                                       withExtension:@"bundle"]];
    static UIImage *defaultStarImage = nil;
    static UIImage *defaultHighlightedStarImage = nil;
    if (defaultStarImage == nil) {
        NSString *defaultStarImageURL = [bundle pathForResource:kDefaultStarImageName 
                                                         ofType:@"png"];
        NSString *defaultHighlightedStarImageURL = [bundle pathForResource:kDefaultHighlightedStarImageName
                                                                    ofType:@"png"];
        defaultStarImage = [UIImage imageWithContentsOfFile:defaultStarImageURL];
        defaultHighlightedStarImage = [UIImage imageWithContentsOfFile:defaultHighlightedStarImageURL];
    }
    self.starImage = defaultStarImage;
    self.highlightedStarImage = defaultHighlightedStarImage;
    _rating = 0.0f;
    _numberOfStars = kDefaultNumberOfStars;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initView];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_starImage);
    TERELEASE(_highlightedStarImage);
    [super dealloc];
}
#endif

@end
