//
//  TEModal.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEModel.h"

@implementation TEModel

@synthesize delegates = _delegates;

#pragma mark - Private methods

- (void)notifyDidStart {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didStartLoadWithModel:)]) {
            [delegate didStartLoadWithModel:self];
        }
    }
}

- (void)notifyDidCancel {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didCancelLoadWithModel:)]) {
            [delegate didCancelLoadWithModel:self];
        }
    }
}

- (void)notifyDidFinishLoad {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didFinishLoadWithModel:)]) {
            [delegate didFinishLoadWithModel:self];
        }
    }
}

- (void)notifyDidUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didUpdateModel:withObject:atIndexPath:)]) {
            [delegate didUpdateModel:self
                          withObject:object
                         atIndexPath:indexPath];
        }
    }
}

- (void)notifyDidInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didInsertModel:withObject:atIndexPath:)]) {
            [delegate didInsertModel:self
                          withObject:object
                         atIndexPath:indexPath];
        }
    }
}

- (void)notifyDidDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didDeleteModel:withObject:atIndexPath:)]) {
            [delegate didDeleteModel:self
                          withObject:object
                         atIndexPath:indexPath];
        }
    }
}

- (void)notifyBeginUpdates {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(beginUpdatesWithModel:)]) {
            [delegate beginUpdatesWithModel:self];
        }
    }
}

- (void)notifyEndUpdates {
    for (id <TEModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(endUpdatesWithModel:)]) {
            [delegate endUpdatesWithModel:self];
        }
    }
}

#pragma mark - Properties

- (BOOL)isLoading {
    return !!_loadingThread;
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
    _loadingThread = nil;
}

- (void)cancel {
    [_loadingThread cancel];
    _loadingThread = nil;
}

- (void)loadData {
    [self cancel];
    _loadingThread = [[NSThread alloc] initWithTarget:self
                                             selector:@selector(__load) 
                                               object:nil];
    [_loadingThread start];
}

- (id)init {
    self = [super init];
    if (self) {
        _delegates = [NSMutableArray new];
        _loadingThread = nil;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_delegates);
    TERELEASE(_loadingThread);
    [super dealloc];
}
#endif

@end
