//
//  TESelectItem.m
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TESelectItem.h"
#import "TESelectCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TESelectItem

@synthesize title = _title;
@synthesize items = _items;
@synthesize selectedIndex = _selectedIndex;
@synthesize segmentedControlStyle = _segmentedControlStyle;
@synthesize delegate = _delegate;

#pragma mark - Action methods

- (void)segmentedControlValueChanged:(id)sender {
    UISegmentedControl *segmentedControl = sender;
    self.selectedIndex = segmentedControl.selectedSegmentIndex;
    if ([self.delegate respondsToSelector:@selector(selectItemValueDidChanged:)]) {
        [self.delegate selectItemValueDidChanged:self];
    }
}

#pragma mark - TETableViewItem

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView {
    TESelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TESelectCell"];
    if (!cell) {
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TUKitResources"
                                                                           withExtension:@"bundle"]];
        cell = [[bundle loadNibNamed:@"TETableViewCells"
                               owner:nil
                             options:nil] objectAtIndex:2];
    }
    cell.titleLabel.text = self.title;
    [cell.segmentedControl removeAllSegments];
    cell.segmentedControl.transform = CGAffineTransformIdentity;
    NSInteger index = 0;
    for (NSString *item in self.items) {
        [cell.segmentedControl insertSegmentWithTitle:item
                                              atIndex:index
                                             animated:NO];
        index++;
    }
    cell.segmentedControl.transform = CGAffineTransformIdentity;
    cell.segmentedControl.selectedSegmentIndex = self.selectedIndex;
    cell.segmentedControl.segmentedControlStyle = self.segmentedControlStyle;
    CGFloat ratio = 33.0f / 44.0f;
    cell.segmentedControl.layer.anchorPoint = CGPointMake(0.32f, 0.5f);
    cell.segmentedControl.transform = CGAffineTransformMakeScale(ratio, ratio);
    [cell.segmentedControl addTarget:self
                              action:@selector(segmentedControlValueChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

#pragma mark - Lifecycle

+ (id)itemWithTitle:(NSString *)title items:(NSArray *)items {
    return [TESelectItem itemWithTitle:title
                                 items:items
                         selectedIndex:0];
}

+ (id)itemWithTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex {
    TESelectItem *item = [[TESelectItem alloc] initWithTitle:title
                                                       items:items
                                               selectedIndex:selectedIndex];
#if !__has_feature(objc_arc)
    [item autorelease];
#endif
    return item;
}

- (id)initWithTitle:(NSString *)title items:(NSArray *)items {
    return [self initWithTitle:title
                         items:items
                 selectedIndex:0];
}

- (id)initWithTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex {
    self = [super init];
    if (self) {
        self.segmentedControlStyle = UISegmentedControlStyleBordered;
        _items = items;
        self.title = title;
        self.selectedIndex = selectedIndex;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

@end
