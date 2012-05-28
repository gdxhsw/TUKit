//
//  TEGallery.h
//  1up
//
//  Created by  on 12/1/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"
#import "TEPhoto.h"

@protocol TEGalleryDataSource;
@protocol TEGalleryDelegate;
@class TEScrollView;

@interface TEGallery : UIView <UIScrollViewDelegate> {
    NSMutableArray *_photos;
    TEScrollView *_scrollView;
    BOOL _oldCenterIndex;
}

@property (assign, nonatomic) CGSize photoSize;
@property (assign, nonatomic) CGFloat spacing;
@property (assign, nonatomic) CGFloat minimumScale;
@property (assign, nonatomic) CGFloat maximumScale;
@property (assign, nonatomic) BOOL scaleEnabled;
@property (WEAK, nonatomic) id <TEGalleryDataSource> dataSource;
@property (WEAK, nonatomic) id <TEGalleryDelegate> delegate;

- (void)reloadData;
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

@end


@protocol TEGalleryDataSource <NSObject>

- (TEPhoto *)gallery:(TEGallery *)gallery photoAtIndex:(NSInteger)index;
- (NSInteger)numbersOfPhotoWithGallery:(TEGallery *)gallery;

@end


@protocol TEGalleryDelegate <NSObject>

- (void)gallery:(TEGallery *)gallery didSelectPhotoAtIndex:(NSInteger)index;
- (void)gallery:(TEGallery *)gallery didChangeCenterIndex:(NSInteger)index;

@end


@interface TEScrollView : UIScrollView {
}

@end