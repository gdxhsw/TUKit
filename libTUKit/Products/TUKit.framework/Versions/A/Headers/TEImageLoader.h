//
//  TEImageLoader.h
//
//  Created by GDX on 12/3/21.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TEArcCompatible.h"

@protocol TEImageLoaderDelegate;

@interface TEImageLoader : NSOperation

@property (strong, nonatomic) NSString *path;
@property (WEAK, nonatomic) id <TEImageLoaderDelegate> delegate;

/* Check if image cache already exist */
+ (BOOL)hasImageWithPath:(NSString *)path error:(NSError **)error;

+ (UIImage *)imageCacheWithPath:(NSString *)path error:(NSError **)error;

/* Load image from path */
+ (UIImage *)imageWithPath:(NSString *)path error:(NSError **)error;

/* Load image from path async */
+ (TEImageLoader *)loadImageWithPath:(NSString *)path delegate:(id <TEImageLoaderDelegate>)delegate;

/* Free all cache in memory */
+ (void)clearMemoryCache;

/* Remove all cache in local file system */
+ (void)clearCacheImages;

+ (void)cancelOperationsWithDelegate:(id <TEImageLoaderDelegate>)delegate;

@end


/* TEImageLoader delegate for async image loading */
@protocol TEImageLoaderDelegate <NSObject>

/* Image load success callback */
- (void)imageLoader:(TEImageLoader *)loader loadedWithPath:(NSString *)path image:(UIImage *)image;

/* Image load fail callback */
- (void)imageLoader:(TEImageLoader *)loader loadFailedWithPath:(NSString *)path error:(NSError *)error;

@optional
/* Preprocess with loaded image */
- (UIImage *)imageLoader:(TEImageLoader *)loader preprocessWithPath:(NSString *)path image:(UIImage *)image;

@end


/* Error codes */
extern NSInteger ImageLoaderPathNotSupported;
extern NSInteger ImageLoaderImageDoesNotExist;
extern NSInteger ImageLoaderImageFileNotSupported;