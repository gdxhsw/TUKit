//
//  TETableViewItem.m
//  libTUKit
//
//  Created by GDX on 12/7/16.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETableViewItem.h"

@implementation TETableViewItem

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize accessoryType = _accessoryType;
@synthesize selectionStyle = _selectionStyle;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize tag = _tag;

#pragma mark - TETableViewItem

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:_cellStyle
                                      reuseIdentifier:self.reuseIdentifier];
    }
    cell.textLabel.text = self.title;
    cell.detailTextLabel.text = self.subtitle;
    cell.accessoryType = self.accessoryType;
    cell.selectionStyle = self.selectionStyle;
    return cell;
}

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        _cellStyle = style;
        self.reuseIdentifier = reuseIdentifier;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _cellStyle = UITableViewCellStyleDefault;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

@end