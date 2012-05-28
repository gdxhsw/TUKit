//
//  TEPhotoView.h
//  1up
//
//  Created by  on 12/1/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEPhoto : UIView {
    UIImageView *_imageView;
}

@property (nonatomic, readonly) UIImage *image;

+ (id)photoWithImageNamed:(NSString *)name;
+ (id)photoWithImage:(UIImage *)image;

- (id)initWithImageNamed:(NSString *)name;
- (id)initWithImage:(UIImage *)image;

@end
