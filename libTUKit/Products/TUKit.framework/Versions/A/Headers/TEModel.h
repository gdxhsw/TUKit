//
//  TEModal.h
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"

@protocol TEModelDelegate;

@interface TEModel : NSObject {
    NSThread *_loadingThread;
}

@property (WEAK, nonatomic) id <TEModelDelegate> delegate;

- (void)load;
- (void)loadData;
- (void)cancel;

- (void)notifyDidStart;
- (void)notifyDidCancel;
- (void)notifyDidFinishLoad;
- (void)notifyDidUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyDidInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyDidDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyBeginUpdates;
- (void)notifyEndUpdates;

@property (readonly, nonatomic) BOOL isLoading;

@end


@protocol TEModelDelegate <NSObject>

@optional
- (void)didStartLoadWithModel:(TEModel *)model;
- (void)didFinishLoadWithModel:(TEModel *)model;
- (void)didCancelLoadWithModel:(TEModel *)model;

- (void)didUpdateModel:(TEModel *)model withObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)didInsertModel:(TEModel *)model withObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)didDeleteModel:(TEModel *)model withObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (void)beginUpdatesWithModel:(TEModel *)model;
- (void)endUpdatesWithModel:(TEModel *)model;

@end