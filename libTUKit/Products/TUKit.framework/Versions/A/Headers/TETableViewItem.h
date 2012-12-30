//
//  TETableViewItem.h
//  libTUKit
//
//  Created by GDX on 12/4/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TETableViewItem <NSObject>

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView;

@optional
- (CGFloat)cellHeightWithTableView:(UITableView *)tableView;

@end

@interface TETableViewItem : NSObject <TETableViewItem> {
    UITableViewCellStyle _cellStyle;
}

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (assign, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (assign, nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (copy, nonatomic) NSString *reuseIdentifier;
@property (assign, nonatomic) NSInteger tag;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


@protocol TETableViewSelectableItem <TETableViewItem>

@required
@property (assign, nonatomic) BOOL selected;

@end