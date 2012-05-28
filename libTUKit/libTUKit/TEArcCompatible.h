//
//  TEArcCompatible.h
//  libTUKit
//
//  Created by  on 12/5/28.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#ifndef libTUKit_TEArcCompatible_h
#define libTUKit_TEArcCompatible_h

#if __has_feature(objc_arc)
#define STRONG  strong
#define WEAK    unsafe_unretained
#else
#define STRONG  retain
#define WEAK    assign
#endif

#endif
