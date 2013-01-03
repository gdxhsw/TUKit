//
//  TETableViewDataSource.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewDataSource.h"

NSString *kTEInvalidClass = @"invalidClass";

@implementation TETableViewDataSource

@synthesize items = _items;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Public methods

- (id <TETableViewItem>)itemForIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <TETableViewItem> item = [self itemForIndexPath:indexPath];
    return [item cellWithTableView:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.actionDelegate respondsToSelector:@selector(dataSource:withTableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.actionDelegate dataSource:self
                          withTableView:tableView
                     commitEditingStyle:editingStyle
                      forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self.actionDelegate respondsToSelector:@selector(dataSource:withTableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.actionDelegate dataSource:self
                          withTableView:tableView
                     moveRowAtIndexPath:sourceIndexPath
                            toIndexPath:destinationIndexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_items);
    
    [super dealloc];
}
#endif

@end
