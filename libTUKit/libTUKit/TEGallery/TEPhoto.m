//
//  TEPhotoView.m
//  1up
//
//  Created by  on 12/1/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TEPhoto.h"

@implementation TEPhoto

#pragma mark - Properties

- (void)setFrame:(CGRect)frame {
    _imageView.frame = CGRectMake(0, 0, 
                                  frame.size.width, 
                                  frame.size.height);
    [super setFrame:frame];
}

- (UIImage *)image {
    return _imageView.image;
}

#pragma mark - Lifecycle

+ (id)photoWithImageNamed:(NSString *)name {
    TEPhoto *photo = [[TEPhoto alloc] initWithImageNamed:name];
#if !__has_feature(objc_arc)
    return [photo autorelease];
#else
    return photo;
#endif
}

+ (id)photoWithImage:(UIImage *)image {
    TEPhoto *photo = [[TEPhoto alloc] initWithImage:image];
#if !__has_feature(objc_arc)
    return [photo autorelease];
#else
    return photo;
#endif
}

- (id)initWithImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [self initWithImage:image];
}

- (id)initWithImage:(UIImage *)image {
    if ((self = [super initWithFrame:CGRectZero])) {
#if !__has_feature(objc_arc)
        [_imageView release];
#endif
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [super setFrame:_imageView.frame];
        self.backgroundColor = [UIColor clearColor];
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
#if !__has_feature(objc_arc)
        [_imageView release];
#endif
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
    
    [_imageView release];
}
#endif

@end
