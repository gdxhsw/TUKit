//
//  TESwitchItem.m
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TESwitchItem.h"
#import "TESwitchCell.h"

@implementation TESwitchItem

@synthesize title = _title;
@synthesize on = _on;
@synthesize delegate = _delegate;

#pragma mark - Action methods

- (void)switchValueChanged:(id)sender {
    UISwitch *sw = sender;
    self.on = sw.on;
    if ([self.delegate respondsToSelector:@selector(switchItemValueDidChanged:)]) {
        [self.delegate switchItemValueDidChanged:self];
    }
}

#pragma mark - TETableViewItem

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView {
    TESwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TESwitchCell"];
    if (!cell) {
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TUKitResources"
                                                                           withExtension:@"bundle"]];
        cell = [[bundle loadNibNamed:@"TETableViewCells"
                               owner:nil
                             options:nil] objectAtIndex:1];
    }
    cell.titleLabel.text = self.title;
    cell.optionSwitch.on = self.on;
    [cell.optionSwitch removeTarget:nil
                             action:nil
                   forControlEvents:UIControlEventValueChanged];
    [cell.optionSwitch addTarget:self
                          action:@selector(switchValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

#pragma mark - Lifecycle

+ (id)itemWithTitle:(NSString *)title {
    return [TESwitchItem itemWithTitle:title
                                    on:NO];
}

+ (id)itemWithTitle:(NSString *)title on:(BOOL)on {
    TESwitchItem *item = [[TESwitchItem alloc] initWithTitle:title
                                                          on:on];
#if !__has_feature(objc_arc)
    [item autorelease];
#endif
    return item;
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title
                            on:NO];
}

- (id)initWithTitle:(NSString *)title on:(BOOL)on {
    self = [super init];
    if (self) {
        self.title = title;
        self.on = on;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    self.delegate = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

@end
