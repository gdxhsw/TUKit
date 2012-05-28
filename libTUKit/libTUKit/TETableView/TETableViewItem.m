//
//  TETableViewItem.m
//  Sniff
//
//  Created by  on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"
#import "TETableViewCell.h"

@implementation TETableViewItem

@synthesize tag = _tag;
@synthesize object = _object;

@synthesize cellClass = _cellClass;
@synthesize cellReuseIdentifier = _cellReuseIdentifier;
@synthesize cellNibName = _cellNibName;
@synthesize cellNibIndex = _cellNibIndex;
@synthesize cellStyle = _cellStyle;

#pragma mark - Static methods

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex {
    return [[TETableViewItem alloc] initWithObject:object
                                         cellClass:cellClass
                                   reuseIdentifier:reuseIdentifier
                                           nibName:nibName
                                          nibIndex:nibIndex];
}

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName {
    return [[TETableViewItem alloc] initWithObject:object
                                         cellClass:cellClass
                                   reuseIdentifier:reuseIdentifier
                                           nibName:nibName
                                          nibIndex:0];
}

+ (id)itemWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [[TETableViewItem alloc] initWithObject:object
                                         cellClass:cellClass
                                             style:style
                                   reuseIdentifier:reuseIdentifier];
}

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self) {
        self.cellClass = [TETableViewCell class];
        self.cellStyle = UITableViewCellStyleDefault;
    }
    return self;
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName nibIndex:(NSUInteger)nibIndex {
    self = [super init];
    if (self) {
        self.cellClass = cellClass;
        self.cellReuseIdentifier = reuseIdentifier;
        self.cellNibName = nibName;
        self.cellNibIndex = nibIndex;
        self.object = object;
    }
    return self;
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName {
    return [self initWithObject:object 
                      cellClass:cellClass
                reuseIdentifier:reuseIdentifier
                        nibName:nibName
                       nibIndex:0];
}

- (id)initWithObject:(id)object cellClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        self.cellClass = cellClass;
        self.cellStyle = style;
        self.cellReuseIdentifier = reuseIdentifier;
        self.object = object;
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_object);
    TERELEASE(_cellClass);
    TERELEASE(_cellReuseIdentifier);
    TERELEASE(_cellNibName)
    [super dealloc];
}
#endif

@end
