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
    NSLog(@"");
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
    return (_operation != nil && !_operation.isFinished);
}

- (void)load {
}

- (void)__load {
    [self notifyDidStart];
    [self load];
    [self notifyDidFinishLoad];
    TERELEASE(_operation);
}

- (void)cancel {
    [_operation cancel];
    TERELEASE(_operation);
}

- (void)loadData {
    static NSOperationQueue *queue = nil;
    @synchronized (self) {
        if (queue == nil) {
            queue = [[NSOperationQueue alloc] init];
            queue.maxConcurrentOperationCount = 5;
        }
    }
    NSLog(@"7, isLoading = %@", self.isLoading ? @"YES" : @"NO");
    [_lock lock];
    if (!self.isLoading) {
        _operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                          selector:@selector(__load) 
                                                            object:nil];
        [queue addOperation:_operation];
    }
    [_lock unlock];
}

- (id)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _lock = [[NSRecursiveLock alloc] init];
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
