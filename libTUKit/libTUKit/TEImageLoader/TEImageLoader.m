//
//  TEImageLoader.m
//
//  Created by GDX on 12/3/21.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEImageLoader.h"
#import "TEArcCompatible.h"
#import "NSString+URLEncode.h"

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
NSInteger ImageLoaderImageFileNotSupported = 1;

/* Path schema types */
typedef enum {
    ImagePathTypeNotSupported,
    ImagePathTypeFileSystem,
    ImagePathTypeHttpUrl,
    ImagePathTypeHttpsUrl
} ImagePathType;


@interface TEImageLoaderInfo : NSObject

@property (copy, nonatomic) NSString *path;
@property (WEAK, nonatomic) id <TEImageLoaderDelegate> delegate;

@end

@implementation TEImageLoaderInfo

@synthesize path = _path;
@synthesize delegate = _delegate;

@end


@interface TEImageLoader ()

/* Check path type */
- (ImagePathType)isTypeWithPath:(NSString *)path;

/* Path for image in local cache */
- (NSString *)cachePathWithImagePath:(NSString *)path error:(NSError **)error;

/* Get the cache file path and check if cache file is available */
- (BOOL)isCacheAvailable:(NSString *)path cachePath:(NSString **)cachePath;

/* Save downloaded image to local cache */
- (void)saveImageToCacheWithPath:(NSString *)path image:(UIImage *)image;

/* Get image from memory cache */
- (UIImage *)imageInMemoryCacheWithPath:(NSString *)path;

@property (nonatomic, readonly) NSString *documentPath;
@property (nonatomic, readonly) NSString *cachePath;

@end

static TEImageLoader *_imageLoader = nil;
static NSOperationQueue *_operationQueue = nil;

@implementation TEImageLoader

/* Get app's document path */
@synthesize documentPath = _documentsPath;

/* Get cache folder path */
@synthesize cachePath = _cachePath;

+ (id)sharedLoader {
    if (_imageLoader == nil) {
        _imageLoader = [TEImageLoader new];
    }
    return _imageLoader;
}

#pragma mark - Lifecycle

- (id)init {
    if ((self = [super init])) {
        if (_operationQueue == nil) {
            _operationQueue = [NSOperationQueue new];
            [_operationQueue setMaxConcurrentOperationCount:5];
        }
#if __has_feature(objc_arc)
        _documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _cachePath = [_documentsPath stringByAppendingPathComponent:kImageCacheFilder];
#else
        [_documentsPath release];
        _documentsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] retain];
        [_cachePath release];
        _cachePath = [[_documentsPath stringByAppendingPathComponent:kImageCacheFilder] retain];
#endif
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
    return self;
}

#pragma mark - Private methods

- (ImagePathType)isTypeWithPath:(NSString *)path {
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

- (NSString *)cachePathWithImagePath:(NSString *)path error:(NSError **)error {
    ImagePathType type = [self isTypeWithPath:path];
    error = nil;
    switch (type) {
        case ImagePathTypeFileSystem:
            return path;
            break;
        case ImagePathTypeHttpUrl:
        case ImagePathTypeHttpsUrl:
            return [self.cachePath stringByAppendingPathComponent:[path urlencode]];
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

- (UIImage *)imageInMemoryCacheWithPath:(NSString *)path {
    return [_memoryCache objectForKey:path];
}

- (void)saveImageToMemoryCacheWithPath:(NSString *)path image:(UIImage *)image {
    [_memoryCache setObject:image
                     forKey:path];
}

- (BOOL)isCacheAvailable:(NSString *)path cachePath:(NSString **)cachePath {
    *cachePath = [self cachePathWithImagePath:path
                                        error:nil];
    if (*cachePath != nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager fileExistsAtPath:*cachePath];
    }
    return NO;
}

- (void)saveImageToCacheWithPath:(NSString *)path image:(UIImage *)image {
    ImagePathType type = [self isTypeWithPath:path];
    NSError *error;
    switch (type) {
        case ImagePathTypeHttpUrl:
        case ImagePathTypeHttpsUrl:
            [UIImagePNGRepresentation(image) writeToFile:[self cachePathWithImagePath:path
                                                                                error:&error]
                                              atomically:YES];
            break;
        default:
            break;
    }
}

- (void)startLoadImageWithInfo:(id)loaderInfo {
    TEImageLoaderInfo *info = loaderInfo;
    NSError *error;
    NSString *cachePath = nil;
    if ([self isCacheAvailable:info.path cachePath:&cachePath]) {
        if ([info.delegate respondsToSelector:@selector(imageLoader:loadedWithPath:image:)]) {
            UIImage *image = [self imageInMemoryCacheWithPath:info.path];
            if (image == nil) {
                image = [self imageWithPath:cachePath
                                      error:nil];
                [self saveImageToMemoryCacheWithPath:info.path
                                         image:image];
            }
            [info.delegate imageLoader:self
                        loadedWithPath:info.path 
                                 image:image];
        }
    }
    else {
        UIImage *image = [self imageWithPath:info.path
                                       error:&error];
        if (error == nil) {
            if ([info.delegate respondsToSelector:@selector(imageLoader:preprocessWithPath:image:)]) {
                image = [info.delegate imageLoader:self
                                preprocessWithPath:info.path
                                             image:image];
            }
            [self saveImageToCacheWithPath:info.path
                                     image:image];
            if ([info.delegate respondsToSelector:@selector(imageLoader:loadedWithPath:image:)]) {
                [info.delegate imageLoader:self
                            loadedWithPath:info.path
                                     image:image];
            }
        }
        else {
            if ([info.delegate respondsToSelector:@selector(imageLoader:loadFailedWithPath:error:)]) {
                [info.delegate imageLoader:self
                        loadFailedWithPath:info.path
                                     error:error];
            }
        }
    }
}

#pragma mark - Public methods

- (BOOL)hasImageWithPath:(NSString *)path error:(NSError **)error {
    return !![self cachePathWithImagePath:path
                                    error:error];
}

- (UIImage *)imageCacheWithPath:(NSString *)path error:(NSError **)error {
    UIImage *image = nil;
    NSString *cachePath = nil;
    if ([self isCacheAvailable:path cachePath:&cachePath]) {
        image = [self imageInMemoryCacheWithPath:path];
        if (image == nil) {
            image = [self imageWithPath:cachePath
                                  error:nil];
            [self saveImageToMemoryCacheWithPath:path
                                           image:image];
        }
    }
    return image;
}

- (UIImage *)imageWithPath:(NSString *)path error:(NSError **)error {
    NSURL *url = [NSURL URLWithString:path];
    NSData *imageData = [NSData dataWithContentsOfURL:url
                                              options:NSDataReadingUncached
                                                error:error];
    UIImage *image = nil;
    if (!error) {
        image = [UIImage imageWithData:imageData];
    }
    return image;
}

- (void)loadImageWithPath:(NSString *)path delegate:(id <TEImageLoaderDelegate>)delegate {
    TEImageLoaderInfo *info = [TEImageLoaderInfo new];
    info.path = path;
    info.delegate = delegate;
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(startLoadImageWithInfo:) 
                                                                              object:info];
    NSMutableArray *operations = [_operationDelegates objectForKey:delegate];
    if (operations == nil) {
        operations = [NSMutableArray new];
        [_operationDelegates setObject:operations
                                forKey:delegate];
#if !__has_feature(objc_arc)
        [operations release];
#endif
    }
    [operations addObject:operation];
    [_operationQueue addOperation:operation];
#if !__has_feature(objc_arc)
    [operation release];
#endif
}

- (void)cancelOperationForDelegate:(id <TEImageLoaderDelegate>)delegate {
    NSMutableArray *operations = [_operationDelegates objectForKey:delegate];
    for (NSInvocationOperation *operation in operations) {
        [operation cancel];
    }
    [operations removeAllObjects];
}

- (void)cancelAllOperations {
    [_operationQueue cancelAllOperations];
}

- (void)clearMemoryCache {
    [_memoryCache removeAllObjects];
}

- (void)clearCacheImages {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:self.cachePath
                                                           error:nil];
    for (NSString *fileName in cacheFiles) {
        [fileManager removeItemAtPath:[self.cachePath stringByAppendingPathComponent:fileName]
                                error:nil];
    }
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_documentsPath);
    TERELEASE(_cachePath);
    TERELEASE(_memoryCache);
    TERELEASE(_operationDelegates);
    [super dealloc];
}
#endif

@end
