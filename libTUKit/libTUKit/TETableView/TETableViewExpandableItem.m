//
//  TETableViewExpandableItem.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewExpandableItem.h"

@implementation TETableViewExpandableItem

@synthesize expanded = _expanded;
@synthesize expandItem = _expandItem;

#pragma mark - Properties

- (void)setExpandItem:(TETableViewItem *)expandItem {
    if (_expandItem != expandItem) {
        if ([expandItem isKindOfClass:[TETableViewExpandableItem class]]) {
            @throw [NSException exceptionWithName:@"Class not supported"
                                           reason:@"expandItem cannot sub-classed from TETableViewExpandableItem." 
                                         userInfo:nil];
        }
#if __has_feature(objc_arc)
        _expandItem = expandItem;
#else
        [_expandItem release];
        _expandItem = [expandItem retain];
#endif
    }
}

#pragma mark - Lifecycle

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex expandItem:(TETableViewItem *)expandItem {
    return [[TETableViewExpandableItem alloc] initWithObject:object
                                                   cellClass:cellClass
                                             reuseIdentifier:reuseIdentifier
                                                     nibName:nibName
                                                    nibIndex:nibIndex
                                                  expandItem:expandItem];
}

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName expandItem:(TETableViewItem *)expandItem {
    return [[TETableViewExpandableItem alloc] initWithObject:object
                                                   cellClass:cellClass
                                             reuseIdentifier:reuseIdentifier
                                                     nibName:nibName
                                                  expandItem:expandItem];
}

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier expandItem:(TETableViewItem *)expandItem {
    return [[TETableViewExpandableItem alloc] initWithObject:object
                                                   cellClass:cellClass
                                                       style:style
                                             reuseIdentifier:reuseIdentifier
                                                  expandItem:expandItem];
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex expandItem:(TETableViewItem *)expandItem {
    self = [super initWithObject:object
                       cellClass:cellClass
                 reuseIdentifier:reuseIdentifier
                         nibName:nibName
                        nibIndex:nibIndex];
    if (self) {
        self.expandItem = expandItem;
    }
    return self;
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName expandItem:(TETableViewItem *)expandItem {
    self = [super initWithObject:object
                       cellClass:cellClass
                 reuseIdentifier:reuseIdentifier
                         nibName:nibName];
    if (self) {
        self.expandItem = expandItem;
    }
    return self;
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier expandItem:(TETableViewItem *)expandItem {
    self = [super initWithObject:object
                       cellClass:cellClass
                           style:style
                 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandItem = expandItem;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_expandItem);
    [super dealloc];
}
#endif

@end
