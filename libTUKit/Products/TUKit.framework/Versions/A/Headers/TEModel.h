//
//  TEModal.h
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TEArcCompatible.h"

@protocol TEModelDelegate;

@interface TEModel : NSObject

@property (WEAK, nonatomic) id <TEModelDelegate> delegate;

- (void)loadMore:(BOOL)more;
- (void)cancel;

- (void)notifyDidStart;
- (void)notifyDidCancel;
- (void)notifyDidFinishLoadWithResult:(id)result;
- (void)notifyDidFailWithError:(NSError *)error;
- (void)notifyDidUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyDidInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyDidDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)notifyBeginUpdates;
- (void)notifyEndUpdates;

@property (readonly, nonatomic) BOOL isLoading;
@property (readonly, nonatomic) BOOL isLoaded;
@property (readonly, nonatomic) BOOL hasMore;

@end


@protocol TEModelDelegate <NSObject>

@optional
- (void)modelDidStartLoad:(TEModel *)model;
- (void)model:(TEModel *)model didFinishLoadWithResult:(id)result;
- (void)modelDidCancelLoad:(TEModel *)model;
- (void)model:(TEModel *)model didFailLoadWithError:(NSError *)error;

- (void)model:(TEModel *)model didUpdateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)model:(TEModel *)model didInsertWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)model:(TEModel *)model didDeleteWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (void)modelBeginUpdates:(TEModel *)model;
- (void)modelEndUpdates:(TEModel *)model;

@end