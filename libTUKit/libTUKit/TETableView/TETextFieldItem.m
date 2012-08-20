//
//  TETextFieldItem.m
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TETextFieldItem.h"
#import "TETextFieldCell.h"

@implementation TETextFieldItem

@synthesize title = _title;
@synthesize text = _text;
@synthesize delegate = _delegate;

#pragma mark - Action methods

- (void)textFieldEditingChange:(id)sender {
    UITextField *textField = sender;
    self.text = textField.text;
}

#pragma mark - TETableViewItem

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView {
    TETextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TETextFieldCell"];
    if (!cell) {
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TUKitResources"
                                                                           withExtension:@"bundle"]];
        cell = [[bundle loadNibNamed:@"TETableViewCells"
                               owner:nil
                             options:nil] objectAtIndex:0];
    }
    cell.titleLabel.text = self.title;
    cell.textField.text = self.text;
    [cell.textField removeTarget:nil
                          action:nil
                forControlEvents:UIControlEventEditingChanged];
    [cell.textField addTarget:self
                       action:@selector(textFieldEditingChange:)
             forControlEvents:UIControlEventEditingChanged];
    cell.textField.delegate = self.delegate;
    
    return cell;
}

#pragma mark - Lifecycle

+ (id)itemWithTitle:(NSString *)title {
    return [TETextFieldItem itemWithTitle:title
                                     text:nil];
}

+ (id)itemWithTitle:(NSString *)title text:(NSString *)text {
    TETextFieldItem *item = [[TETextFieldItem alloc] initWithTitle:title
                                                              text:text];
#if !__has_feature(objc_arc)
    [item autorelease];
#endif
    return item;
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title
                          text:nil];
}

- (id)initWithTitle:(NSString *)title text:(NSString *)text {
    self = [super init];
    if (self) {
        self.title = title;
        self.text = text;
    }
    return self;
}

@end
