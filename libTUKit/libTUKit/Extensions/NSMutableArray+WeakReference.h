//
//  NSMutableArray+WeakReference.h
//
//  Created by  on 12/7/25.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (WeakReference)

+ (id)mutableArrayUsingWeakReferences;
+ (id)mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity;

@end
