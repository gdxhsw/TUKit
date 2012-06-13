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
    if ([self.delegate respondsToSelector:@selector(didStartLoadWithModel:)]) {
        [self.delegate didStartLoadWithModel:self];
    }
}

- (void)notifyDidCancel {
    if ([self.delegate respondsToSelector:@selector(didCancelLoadWithModel:)]) {
        [self.delegate didCancelLoadWithModel:self];
    }
}

- (void)notifyDidFinishLoad {
    if ([self.delegate respondsToSelector:@selector(didFinishLoadWithModel:)]) {
        [self.delegate didFinishLoadWithModel:self];
    }
}

- (void)notifyDidUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didUpdateModel:withObject:atIndexPath:)]) {
        [self.delegate didUpdateModel:self
                           withObject:object
                          atIndexPath:indexPath];
    }
}

- (void)notifyDidInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didInsertModel:withObject:atIndexPath:)]) {
        [self.delegate didInsertModel:self
                           withObject:object
                          atIndexPath:indexPath];
    }
}

- (void)notifyDidDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didDeleteModel:withObject:atIndexPath:)]) {
        [self.delegate didDeleteModel:self
                           withObject:object
                          atIndexPath:indexPath];
    }
}

- (void)notifyBeginUpdates {
    if ([self.delegate respondsToSelector:@selector(beginUpdatesWithModel:)]) {
        [self.delegate beginUpdatesWithModel:self];
    }
}

- (void)notifyEndUpdates {
    if ([self.delegate respondsToSelector:@selector(endUpdatesWithModel:)]) {
        [self.delegate endUpdatesWithModel:self];
    }
}

#pragma mark - Properties

- (BOOL)isLoading {
    return (_loadingThread != nil && _loadingThread.isExecuting);
}

- (void)load {
}

- (void)__load {
    [self notifyDidStart];
    [self load];
    if ([NSThread currentThread].isCancelled) {
        [self notifyDidCancel];
    }
    else {
        [self notifyDidFinishLoad];
    }
}

- (void)cancel {
    [_loadingThread cancel];
    TERELEASE(_loadingThread);
}

- (void)loadData {
    [self cancel];
    if (!_loadingThread) {
        _loadingThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(__load) 
                                                   object:nil];
        [_loadingThread start];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        TERELEASE(_loadingThread);
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    _delegate = nil;
    TERELEASE(_loadingThread);
    [super dealloc];
}
#endif

@end
