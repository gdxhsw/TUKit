//
//  NSMutableArray+WeakReference.m
//
//  Created by  on 12/7/25.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "NSMutableArray+WeakReference.h"

@implementation NSMutableArray (WeakReference)

+ (id)mutableArrayUsingWeakReferences {
    return [self mutableArrayUsingWeakReferencesWithCapacity:0];
}

+ (id)mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity {
    CFArrayCallBacks callbacks = {0, NULL, NULL, CFCopyDescription, CFEqual};
    // We create a weak reference array
    return (__bridge_transfer id)(CFArrayCreateMutable(0, capacity, &callbacks));
}

@end
