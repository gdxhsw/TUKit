//
//  TELoadingImageView.m
//
//  Created by GDX on 12/4/16.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TELoadingImageView.h"

@implementation TELoadingImageView

@synthesize imagePath = _imagePath;
@synthesize loadFailedImage = _loadFailedImage;
@synthesize loadingIndicator = _loadingIndicator;
@synthesize image = _image;

#pragma mark - Private methods

- (void)stopLoadingAndSetImage:(UIImage *)image {
    if ([NSThread isMainThread]) {
        [_loadingIndicator stopAnimating];
        self.image = image;
    }
    else {
        [_loadingIndicator performSelectorOnMainThread:@selector(stopAnimating) 
                                            withObject:nil
                                         waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(setImage:) 
                               withObject:image
                            waitUntilDone:YES];
    }
}

#pragma mark - Properties

- (void)setImagePath:(NSString *)imagePath {
    if (![_imagePath isEqualToString:imagePath]) {
#if !__has_feature(objc_arc)
        [_imagePath release];
#endif
        _imagePath = [imagePath copy];
        UIImage *image = [TEImageLoader imageCacheWithPath:imagePath
                                                     error:nil];
        if (image) {
            [self stopLoadingAndSetImage:image];
        }
        else {
            self.image = nil;
            if ([NSThread isMainThread]) {
                [_loadingIndicator startAnimating];
            }
            else {
                [_loadingIndicator performSelectorOnMainThread:@selector(startAnimating) 
                                                    withObject:nil
                                                 waitUntilDone:NO];
            }
            [_imageLoader cancel];
            _imageLoader = [TEImageLoader loadImageWithPath:_imagePath
                                                   delegate:self];
        }
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
#if __has_feature(objc_arc)
        _image = image;
#else
        [_image release];
        _image = [image retain];
#endif
        if ([NSThread isMainThread]) {
            [self setNeedsDisplay];
        }
        else {
            [self performSelectorOnMainThread:@selector(setNeedsDisplay) 
                                   withObject:nil
                                waitUntilDone:NO];
        }
    }
}

#pragma mark - TEImageLoaderDelegate

- (void)imageLoader:(TEImageLoader *)loader loadedWithPath:(NSString *)path image:(UIImage *)image {
    if ([self.imagePath isEqualToString:path]) {
        [self stopLoadingAndSetImage:image];
        _imageLoader = nil;
    }
}

- (void)imageLoader:(TEImageLoader *)loader loadFailedWithPath:(NSString *)path error:(NSError *)error {
    if ([self.imagePath isEqualToString:path]) {
        [self stopLoadingAndSetImage:self.loadFailedImage];
        _imageLoader = nil;
    }
}

#pragma mark - Override methods

- (void)layoutSubviews {
    [super layoutSubviews];
    _loadingIndicator.frame = CGRectMake((self.bounds.size.width - _loadingIndicator.bounds.size.width) / 2.0f,
                                         (self.bounds.size.height - _loadingIndicator.bounds.size.height) / 2.0f, 
                                         _loadingIndicator.bounds.size.width, 
                                         _loadingIndicator.bounds.size.height);
}

- (void)drawRect:(CGRect)rect {
    [self.image drawInRect:rect];
}

#pragma mark - Lifecycle

- (void)loadSubview {
    self.backgroundColor = [UIColor clearColor];
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingIndicator.hidesWhenStopped = YES;
    [self addSubview:_loadingIndicator];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_image);
    TERELEASE(_imagePath);
    TERELEASE(_loadFailedImage);
    TERELEASE(_loadingIndicator);
    [super dealloc];
}
#else
- (void)dealloc {
    [_imageLoader cancel];
}
#endif

@end
