//
//  TETableViewDataSource.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDataSource.h"
#import "TETableViewCell.h"

NSString *kTEInvalidClass = @"invalidClass";

@implementation TETableViewDataSource

@synthesize items = _items;
@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
#if !__has_feature(objc_arc)
        [_items release];
#endif
        _items = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Properties

- (void)setItems:(NSMutableArray *)items {
#if __has_feature(objc_arc)
    _items = items;
#else
    TERELEASE(_items);
    _items = [items retain];
#endif
    if ([self.delegate respondsToSelector:@selector(itemDidChangeWithDataSource:)]) {
        [self.delegate itemDidChangeWithDataSource:self];
    }
}

#pragma mark - Public methods

- (TETableViewItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView item:(TETableViewItem *)item {
    Class cellClass = item.cellClass;
    if (![cellClass isSubclassOfClass:[TETableViewCell class]]) {
        @throw [NSException exceptionWithName:kTEInvalidClass
                                       reason:@"Cell's class should be subclass of TETableViewCell" 
                                     userInfo:nil];
    }
    NSString *reuseIdentifier = nil;
    BOOL useNib = (item.cellNibName != nil);
    if (useNib) {
        reuseIdentifier = item.cellReuseIdentifier;
    }
    else {
        reuseIdentifier = NSStringFromClass([TETableViewCell class]);
    }
    TETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        if (useNib) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:item.cellNibName
                                                         owner:nil
                                                       options:nil];
            cell = [nib objectAtIndex:item.cellNibIndex];
            [cell loadView];
        }
        else {
            cell = [[cellClass alloc] initWithStyle:item.cellStyle
                                    reuseIdentifier:reuseIdentifier];
#if !__has_feature(objc_arc)
            [cell autorelease];
#endif
            [cell loadView];
        }
    }
    cell.object = item;
    return cell;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TETableViewItem *item = [self itemForIndexPath:indexPath];
    return [self cellWithTableView:tableView
                              item:item];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_items);
    _delegate = nil;
    [super dealloc];
}
#endif

@end
