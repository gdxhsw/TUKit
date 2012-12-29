//
//  TEModal.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEModel.h"

@implementation TEModel

@synthesize delegate = _delegate;

#pragma mark - Private methods

- (void)notifyDidStart {
    if ([self.delegate respondsToSelector:@selector(modelDidStartLoad:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate modelDidStartLoad:self];
        });
    }
}

- (void)notifyDidCancel {
    if ([self.delegate respondsToSelector:@selector(modelDidCancelLoad:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate modelDidCancelLoad:self];
        });
    }
}

- (void)notifyDidFinishLoadWithResult:(id)result {
    if ([self.delegate respondsToSelector:@selector(model:didFinishLoadWithResult:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate model:self didFinishLoadWithResult:result];
        });
    }
}

- (void)notifyDidUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(model:didUpdateWithObject:atIndexPath:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate model:self didUpdateWithObject:object atIndexPath:indexPath];
        });
    }
}

- (void)notifyDidInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(model:didInsertWithObject:atIndexPath:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate model:self didInsertWithObject:object atIndexPath:indexPath];
        });
    }
}

- (void)notifyDidDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(model:didDeleteWithObject:atIndexPath:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate model:self didDeleteWithObject:object atIndexPath:indexPath];
        });
    }
}

- (void)notifyBeginUpdates {
    if ([self.delegate respondsToSelector:@selector(modelBeginUpdates:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate modelBeginUpdates:self];
        });
    }
}

- (void)notifyEndUpdates {
    if ([self.delegate respondsToSelector:@selector(modelEndUpdates:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate modelEndUpdates:self];
        });
    }
}

- (void)notifyDidFailWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(model:didFailLoadWithError:)]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate model:self didFailLoadWithError:error];
        });
    }
}

#pragma mark - Properties

- (BOOL)isLoading {
    return NO;
}

- (BOOL)isLoaded {
    return NO;
}

- (BOOL)hasMore {
    return NO;
}

- (void)cancel {
}

- (void)loadMore:(BOOL)more {
}

- (id)init {
    self = [super init];
    if (self) {
        _delegate = nil;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    _delegate = nil;
    TERELEASE(_lock);
    TERELEASE(_loadingThread);
    [super dealloc];
}
#endif

@end
