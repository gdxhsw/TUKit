//
//  TEGallery.m
//  1up
//
//  Created by  on 12/1/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TEGallery.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_SPACING         10.0f
#define DEFAULT_MINIMUM_SCALE   0.8f;
#define DEFAULT_MAXIMUM_SCALE   1.0f;

@implementation TEGallery

@synthesize photoSize = _photoSize;
@synthesize spacing = _spacing;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize minimumScale = _minimumScale;
@synthesize maximumScale = _maximumScale;
@synthesize scaleEnabled = _scaleEnabled;

#pragma mark - Private methods

- (CGFloat)padding {
    return (self.frame.size.width - _photoSize.width) / 2 - _spacing; 
}

- (NSInteger)centerIndex {
    static int oldOffsetX = -1;
    static int oldIndex = -1;
    CGFloat offsetX = _scrollView.contentOffset.x;
    NSInteger index;
    if (offsetX != oldOffsetX) {
        CGFloat realWidth = _photoSize.width + _spacing;
        CGFloat relativeX = fmod(offsetX, realWidth);
        index = (int)(offsetX / realWidth);
        if (relativeX > realWidth / 2) {
            index++;
        }
        oldIndex = index;
    }
    else {
        index = oldIndex;
    }
    if (index < 0) {
        index = 0;
    }
    else if (index >= [_dataSource numbersOfPhotoWithGallery:self]) {
        index = [_dataSource numbersOfPhotoWithGallery:self] - 1;
    }
    return index;
}

- (CGFloat)countContentWidth {
    if ([_dataSource conformsToProtocol:@protocol(TEGalleryDataSource)]) {
        NSInteger photoCount = [_dataSource numbersOfPhotoWithGallery:self];
        CGFloat padding = [self padding];
        CGFloat maxWidth = (_photoSize.width + _spacing) * photoCount + _spacing + padding * 2;
        CGFloat minWidth = self.frame.size.width;
        if (maxWidth < minWidth) {
            maxWidth = minWidth;
        }
        return maxWidth;
    }
    else {
        return self.frame.size.width;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _scrollView.frame = frame;
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width,
                                         frame.size.height);
    [self reloadData];
}

- (void)doScale {
    NSInteger centerIndex = [self centerIndex];
    NSInteger count = [_dataSource numbersOfPhotoWithGallery:self];
    CGFloat scaleWidth = (_photoSize.width) / 2.0f;
    CGFloat span = (_maximumScale - _minimumScale) / scaleWidth;
    for (TEPhoto *photo in _photos) {
        photo.transform = CGAffineTransformMakeScale(1, 1);
        CGFloat originalScale = _photoSize.width / photo.frame.size.width;
        photo.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(originalScale, originalScale), CGAffineTransformMakeScale(_minimumScale, _minimumScale));
    }
    if (centerIndex >= 0 && centerIndex < count) {
        TEPhoto *photo = [_photos objectAtIndex:centerIndex];
        photo.transform = CGAffineTransformMakeScale(1, 1);
        CGFloat centerX = photo.frame.origin.x + photo.frame.size.width / 2 - _scrollView.contentOffset.x;
        centerX = fmodf(centerX, self.frame.size.width);
        CGFloat originalScale = _photoSize.width / photo.frame.size.width;
        CGFloat center = self.frame.size.width / 2;
        CGFloat min = center - scaleWidth;
        CGFloat max = center + scaleWidth;
        CGFloat scale;
        if (centerX >= min && centerX < center) {
            scale = _minimumScale + (span * (centerX - min));
        }
        else if (centerX > center && centerX <= max) {
            scale = _minimumScale + (span * (max - centerX));
        }
        else if (centerX == center) {
            scale = _maximumScale;
        }
        else {
            scale = _minimumScale;
        }
        photo.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(originalScale, 
                                                                             originalScale),
                                                  CGAffineTransformMakeScale(scale,
                                                                             scale));
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger centerIndex = [self centerIndex];
    if (centerIndex != _oldCenterIndex) {
        if ([_delegate respondsToSelector:@selector(gallery:didChangeCenterIndex:)]) {
            [_delegate gallery:self didChangeCenterIndex:centerIndex];
        }
        _oldCenterIndex = centerIndex;
    }
    if (_scaleEnabled) {
        [self doScale];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        NSInteger index = [self centerIndex];
        [self scrollToIndex:index
                   animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = [self centerIndex];
    if (index == 0 || index == [_dataSource numbersOfPhotoWithGallery:self] - 1) {
    }
    else {
        [self scrollToIndex:index
                   animated:YES];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
}

#pragma mark - Public methods

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    NSInteger count = [_dataSource numbersOfPhotoWithGallery:self];
    if (index < 0) {
        index = 0;
    }
    else if (index >= count) {
        index = count - 1;
    }
    TEPhoto *photo = [_photos objectAtIndex:index];
    photo.transform = CGAffineTransformMakeScale(1, 1);
    CGFloat centerX = photo.frame.origin.x + photo.image.size.width / 2;
    if (_scaleEnabled) {
        [self doScale];
    }
    [_scrollView scrollRectToVisible:CGRectMake(centerX - self.frame.size.width / 2,
                                                0, 
                                                self.frame.size.width, 
                                                self.frame.size.height) 
                            animated:animated];
}

- (void)reloadData {
    _scrollView.contentSize = CGSizeMake([self countContentWidth],
                                         self.frame.size.height);
    for (TEPhoto *photo in _photos) {
        [photo removeFromSuperview];
    }
    [_photos removeAllObjects];
    NSInteger photoCount = [_dataSource numbersOfPhotoWithGallery:self];
    CGFloat left = (self.frame.size.width - _photoSize.width) / 2;
    CGFloat top = (self.frame.size.height - _photoSize.height) / 2;
    for (int i = 0; i < photoCount; i++) {
        TEPhoto *photo = [_dataSource gallery:self
                                 photoAtIndex:i];
        photo.frame = CGRectMake(left - (photo.frame.size.width - _photoSize.width) / 2, 
                                 top - (photo.frame.size.height - _photoSize.height) / 2, 
                                 photo.frame.size.width, 
                                 photo.frame.size.height);
        CGFloat scale = _photoSize.width / photo.frame.size.width;
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        photo.transform = transform;
        [_scrollView addSubview:photo];
        [_photos addObject:photo];
        left += _photoSize.width + _spacing;
    }
    if (_scaleEnabled) {
        [self doScale];
    }
    _oldCenterIndex = [self centerIndex];
    [_delegate gallery:self didChangeCenterIndex:_oldCenterIndex];
}

#pragma mark - Properties

- (void)setDataSource:(id <TEGalleryDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setScaleEnabled:(BOOL)scaleEnabled {
    _scaleEnabled = scaleEnabled;
    
}

#pragma mark - Touch events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger index = [self centerIndex];
    TEPhoto *photo = [_photos objectAtIndex:index];
    CGAffineTransform oldTransform = photo.transform;
    photo.transform = CGAffineTransformMakeScale(1, 1);
    CGFloat centerX = photo.frame.origin.x + photo.image.size.width / 2 - _scrollView.contentOffset.x;
    photo.transform = oldTransform;
    if (centerX == self.frame.size.width / 2) {
        [_delegate gallery:self didSelectPhotoAtIndex:index];
    }
    else {
        [self scrollToIndex:index
                   animated:YES];
    }
}

#pragma mark - Lifecycle

- (void)initVariables {
    _spacing = DEFAULT_SPACING;
    _photoSize = CGSizeMake(self.frame.size.width - _spacing * 2, 
                            self.frame.size.height - _spacing * 2);
    _scaleEnabled = NO;
    _minimumScale = DEFAULT_MINIMUM_SCALE;
    _maximumScale = DEFAULT_MAXIMUM_SCALE;
#if !__has_feature(objc_arc)
    [_photos release];
#endif
    _photos = [[NSMutableArray alloc] init];
}

- (void)initScrollView {
#if !__has_feature(objc_arc)
    [_scrollView release];
#endif
    _scrollView = [[TEScrollView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                 self.frame.size.width,
                                                                 self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, 
                                         self.frame.size.height);
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (void)awakeFromNib {
    [self initVariables];
    [self initScrollView];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initVariables];
        [self initScrollView];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [_photos release];
    [_scrollView release];
    [super dealloc];
}
#endif

@end


@implementation TEScrollView

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
	if (!self.dragging) {
		[self.nextResponder touchesEnded: touches withEvent:event];
	}
	[super touchesEnded: touches withEvent: event];
}

@end