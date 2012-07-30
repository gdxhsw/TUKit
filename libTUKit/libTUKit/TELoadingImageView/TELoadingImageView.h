//
//  TELoadingImageView.h
//
//  Created by GDX on 12/4/16.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEArcCompatible.h"
#import "TEImageLoader.h"

@interface TELoadingImageView : UIView <TEImageLoaderDelegate, NSCopying> {
    TEImageLoader *_imageLoader;
}

@property (STRONG, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *imagePath;
@property (STRONG, nonatomic) UIImage *loadFailedImage;
@property (STRONG, nonatomic) UIActivityIndicatorView *loadingIndicator;

- (id)initWithImage:(UIImage *)image;


@end
