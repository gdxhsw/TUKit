//
//  TEExpandableTableViewController.h
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TUKit/TETableView.h>

@class ParentItem;

@interface TEExpandableTableViewController : UIViewController {
    TETableViewExpandableDataSource *_dataSource;
    TETableViewExpandableDelegate *_delegate;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@interface PostItem : TETableViewItem <TETableViewExpandableItem>

@property (copy, nonatomic) NSString *content;

@end