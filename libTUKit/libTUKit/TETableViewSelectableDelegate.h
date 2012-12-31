//
//  TETableViewSelectableDelegate.h
//  libTUKit
//
//  Created by gdx on 12/12/30.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDelegate.h"

@interface TETableViewSelectableDelegate : TETableViewDelegate

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (assign, nonatomic) BOOL shouldDeselectItem;

@end
