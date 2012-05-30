//
//  TEDebug.h
//  libTUKit
//
//  Created by  on 12/5/28.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#ifndef libTUKit_TEDebug_h
#define libTUKit_TEDebug_h

#ifdef DEBUG
#define TELOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define TELOG(xx, ...)  ((void)0)
#endif

#if !__has_feature(objc_arc)
#define TERELEASE(__POINTER) [__POINTER release], __POINTER = nil;
#else
#define TERELEASE(__POINTER) __POINTER = nil;
#endif

#endif
