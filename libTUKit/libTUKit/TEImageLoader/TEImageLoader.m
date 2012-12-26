//
//  TEImageLoader.m
//
//  Created by GDX on 12/3/21.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEImageLoader.h"
#import "TEArcCompatible.h"
#import "NSString+URLEncode.h"
#import "ARCSingleton.h"

static NSString *kImageLoaderErrorDomain = @"imageLoaderErrorDomain";

/* Supported path schema */
static NSString *kPathSchemaFileSystem = @"/";
static NSString *kPathSchemaHttpUrl = @"http:";
static NSString *kPathSchemaHttpsUrl = @"https:";

static NSString *kImagePath = @"imagePath";
static NSString *kImageLoaderDelegate = @"imageLoaderDelegate";
static NSString *kImageCacheFilder = @"__image_cache__";

/* Error codes */
NSInteger ImageLoaderPathNotSupported = 0;
NSInteger ImageLoaderImageDoesNotExist = 1;
NSInteger ImageLoaderImageFileNotSupported = 2;
NSInteger ImageLoaderUnknownError = 3;

/* Path schema types */
typedef enum {
    ImagePathTypeNotSupported,
    ImagePathTypeFileSystem,
    ImagePathTypeHttpUrl,
    ImagePathTypeHttpsUrl
} ImagePathType;


@interface TEImageLoader ()

/* Check path type */
+ (ImagePathType)isTypeWithPath:(NSString *)path;

/* Path for image in local cache */
+ (NSString *)cachePathWithImagePath:(NSString *)path error:(NSError **)error;

/* Get the cache file path and check if cache file is available */
+ (BOOL)isCacheAvailable:(NSString *)path cachePath:(NSString **)cachePath;

/* Save downloaded image to local cache */
+ (void)saveImageToCacheWithPath:(NSString *)path image:(UIImage *)image;

/* Get image from memory cache */
+ (UIImage *)imageInMemoryCacheWithPath:(NSString *)path;

@property (nonatomic, readonly) NSString *documentPath;
@property (nonatomic, readonly) NSString *cachePath;

@end

static NSOperationQueue *_operationQueue = nil;
static NSString *_documentsPath = nil;
static NSString *_cachePath = nil;
static NSMutableDictionary *_memoryCache = nil;
static NSMutableDictionary *_operationDelegates = nil;

@implementation TEImageLoader

@synthesize path = _path;
@synthesize delegate = _delegate;

#pragma mark - Private methods

+ (ImagePathType)isTypeWithPath:(NSString *)path {
    NSArray *components = [path pathComponents];
    if (components.count == 0) {
        return ImageLoaderPathNotSupported;
    }
    NSString *schema = [[path pathComponents] objectAtIndex:0];
    if ([schema isEqualToString:kPathSchemaFileSystem]) {
        return ImagePathTypeFileSystem;
    }
    else if ([schema isEqualToString:kPathSchemaHttpUrl]) {
        return ImagePathTypeHttpUrl;
    }
    else if ([schema isEqualToString:kPathSchemaHttpsUrl]) {
        return ImagePathTypeHttpsUrl;
    }
    else {
        return ImagePathTypeNotSupported;
    }
}

+ (NSString *)cachePathWithImagePath:(NSString *)path error:(NSError **)error {
    ImagePathType type = [TEImageLoader isTypeWithPath:path];
    error = nil;
    switch (type) {
        case ImagePathTypeFileSystem:
            return path;
            break;
        case ImagePathTypeHttpUrl:
        case ImagePathTypeHttpsUrl:
            return [_cachePath stringByAppendingPathComponent:[path urlencode]];
            break;
        default:
            if (error != nil) {
                *error = [[NSError alloc] initWithDomain:kImageLoaderErrorDomain
                                                    code:ImageLoaderPathNotSupported
                                                userInfo:nil];
            }
            return nil;
    }
}

+ (UIImage *)imageInMemoryCacheWithPath:(NSString *)path {
    return [_memoryCache objectForKey:path];
}

+ (void)saveImageToMemoryCacheWithPath:(NSString *)path image:(UIImage *)image {
    [_memoryCache setObject:image
                     forKey:path];
}

+ (BOOL)isCacheAvailable:(NSString *)path cachePath:(NSString **)cachePath {
    *cachePath = [TEImageLoader cachePathWithImagePath:path
                                                 error:nil];
    if (*cachePath != nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager fileExistsAtPath:*cachePath];
    }
    return NO;
}

+ (void)saveImageToCacheWithPath:(NSString *)path image:(UIImage *)image {
    ImagePathType type = [TEImageLoader isTypeWithPath:path];
    NSError *error;
    switch (type) {
        case ImagePathTypeHttpUrl:
        case ImagePathTypeHttpsUrl:
            [UIImagePNGRepresentation(image) writeToFile:[TEImageLoader cachePathWithImagePath:path
                                                                                         error:&error]
                                              atomically:YES];
            break;
        default:
            break;
    }
}

#pragma mark - NSOperation

- (void)main {
    if (self.isCancelled) {
        return;
    }
    
    NSError *error = nil;
    NSString *cachePath = nil;
    if ([TEImageLoader isCacheAvailable:self.path cachePath:&cachePath]) {
        if ([self.delegate respondsToSelector:@selector(imageLoader:loadedWithPath:image:)]) {
            UIImage *image = nil;
            @synchronized (self) {
                image = [TEImageLoader imageInMemoryCacheWithPath:self.path];
                if (image == nil) {
                    image = [TEImageLoader imageWithPath:cachePath
                                                   error:&error];
                    [TEImageLoader saveImageToMemoryCacheWithPath:self.path
                                                            image:image];
                }
            }
            if (!error) {
                [self.delegate imageLoader:self
                            loadedWithPath:self.path
                                     image:image];
            }
            else {
                if ([self.delegate respondsToSelector:@selector(imageLoader:loadFailedWithPath:error:)]) {
                    [self.delegate imageLoader:self
                            loadFailedWithPath:self.path
                                         error:error];
                }
            }
        }
    }
    else {
        UIImage *image = [TEImageLoader imageWithPath:self.path
                                                error:&error];
        if (error == nil && image) {
            if ([self.delegate respondsToSelector:@selector(imageLoader:preprocessWithPath:image:)]) {
                image = [self.delegate imageLoader:self
                                preprocessWithPath:self.path
                                             image:image];
            }
            [TEImageLoader saveImageToCacheWithPath:self.path
                                              image:image];
            if ([self.delegate respondsToSelector:@selector(imageLoader:loadedWithPath:image:)]) {
                [self.delegate imageLoader:self
                            loadedWithPath:self.path
                                     image:image];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(imageLoader:loadFailedWithPath:error:)]) {
                [self.delegate imageLoader:self
                        loadFailedWithPath:self.path
                                     error:error];
            }
        }
    }
}

#pragma mark - Lifecycle

+ (void)initialize {
    @synchronized (self) {
        if (_operationQueue == nil) {
            _operationQueue = [NSOperationQueue new];
            [_operationQueue setMaxConcurrentOperationCount:5];
        }
#if __has_feature(objc_arc)
        _documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *rootCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _cachePath = [rootCachePath stringByAppendingPathComponent:kImageCacheFilder];
#else
        [_documentsPath release];
        _documentsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] retain];
        NSString *rootCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [_cachePath release];
        _cachePath = [[rootCachePath stringByAppendingPathComponent:kImageCacheFilder] retain];
#endif
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:_cachePath]) {
        [fileManager createDirectoryAtPath:_cachePath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
#if !__has_feature(objc_arc)
    [_memoryCache release];
    [_operationDelegates release];
#endif
    _memoryCache = [NSMutableDictionary new];
    _operationDelegates = [NSMutableDictionary new];
}

- (void)cancel {
    self.delegate = nil;
    [super cancel];
}

#pragma mark - Public methods

+ (BOOL)hasImageWithPath:(NSString *)path error:(NSError **)error {
    return !![TEImageLoader cachePathWithImagePath:path
                                             error:error];
}

+ (UIImage *)imageCacheWithPath:(NSString *)path error:(NSError **)error {
    UIImage *image = nil;
    NSString *cachePath = nil;
    if ([TEImageLoader isCacheAvailable:path cachePath:&cachePath]) {
        image = [TEImageLoader imageInMemoryCacheWithPath:path];
        if (image == nil) {
            image = [TEImageLoader imageWithPath:cachePath
                                           error:nil];
            [TEImageLoader saveImageToMemoryCacheWithPath:path
                                                    image:image];
        }
    }
    return image;
}

+ (UIImage *)imageWithPath:(NSString *)path error:(NSError **)error {
    NSError *_error = nil;
    NSData *imageData = nil;
    ImagePathType pathType = [TEImageLoader isTypeWithPath:path];
    if (pathType == ImagePathTypeHttpsUrl || pathType == ImagePathTypeHttpUrl) {
        NSURL *url = [NSURL URLWithString:path];
        if (url) {
            imageData = [NSData dataWithContentsOfURL:url
                                              options:NSDataReadingUncached
                                                error:&_error];
        }
        else {
            _error = [NSError errorWithDomain:@"InvalidURL"
                                         code:0
                                     userInfo:nil];
        }
    }
    else if (pathType == ImagePathTypeFileSystem) {
        imageData = [NSData dataWithContentsOfFile:path
                                           options:NSDataReadingUncached
                                             error:&_error];
    }
    else {
        _error = [NSError errorWithDomain:kImageLoaderErrorDomain
                                     code:ImageLoaderPathNotSupported
                                 userInfo:nil];
    }
    UIImage *image = nil;
    if (!_error) {
        if (imageData) {
            image = [UIImage imageWithData:imageData];
        }
        if (image == nil && error) {
            *error = [NSError errorWithDomain:kImageLoaderErrorDomain
                                         code:ImageLoaderUnknownError
                                     userInfo:nil];
        }
    }
    else if (_error && error) {
        *error = _error;
    }
    return image;
}

+ (TEImageLoader *)loadImageWithPath:(NSString *)path delegate:(id <TEImageLoaderDelegate>)delegate {
    TEImageLoader *operation = [TEImageLoader new];
    operation.path = path;
    operation.delegate = delegate;
    [_operationQueue addOperation:operation];
#if !__has_feature(objc_arc)
    return [operation autorelease];
#else
    return operation;
#endif
}

+ (void)clearMemoryCache {
    [_memoryCache removeAllObjects];
}

+ (void)clearCacheImages {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:_cachePath
                                                           error:nil];
    for (NSString *fileName in cacheFiles) {
        [fileManager removeItemAtPath:[_cachePath stringByAppendingPathComponent:fileName]
                                error:nil];
    }
}

+ (void)cancelOperationsWithDelegate:(id <TEImageLoaderDelegate>)delegate {
    @synchronized (self) {
        for (TEImageLoader *loader in _operationQueue.operations) {
            if (loader.delegate == delegate) {
                [loader cancel];
            }
        }
    }
}

@end
