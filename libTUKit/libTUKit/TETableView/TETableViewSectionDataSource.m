//
//  TETableViewSectionDataSource.m
//
//  Created by GDX on 12/4/4.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewSectionDataSource.h"

@implementation TETableViewSection

@synthesize items = _items;
@synthesize title = _title;
@synthesize footer = _footer;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    TERELEASE(_items);
    TERELEASE(_title);
    TERELEASE(_footer);
    [super dealloc];
}
#endif

@end


@implementation TETableViewSectionDataSource

- (id)itemForIndexPath:(NSIndexPath *)indexPath {
    TETableViewSection *section = [self.items objectAtIndex:indexPath.section];
    return [section.items objectAtIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TETableViewSection *s = [self.items objectAtIndex:section];
    return [s.items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <TETableViewItem> item = [self itemForIndexPath:indexPath];
    return [item cellWithTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TETableViewSection *s = [self.items objectAtIndex:section];
    return s.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    TETableViewSection *s = (TETableViewSection *)[self.items objectAtIndex:section];
    return s.footer;
}

@end
