//
//  TEExpandableTableViewController.m
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEExpandableTableViewController.h"

@interface TEExpandableTableViewController ()

@end

@implementation TEExpandableTableViewController

#pragma mark - Private methods

- (void)initTableView {
    _dataSource = [TETableViewExpandableDataSource new];
    self.tableView.dataSource = _dataSource;
    
    _delegate = [TETableViewExpandableDelegate new];
    self.tableView.delegate = _delegate;
    
    PostItem *item = [[PostItem alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:nil];
    item.title = @"我是標題一";
    item.content = @"我是內容";
    
    PostItem *item2 = [[PostItem alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
    item2.title = @"我是標題二";
    item2.content = @"我是內容二我是內容二我是內容二我是內容二";
    
    _dataSource.items = @[
    item,
    item2
    ];
    
    [self.tableView reloadData];
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

@end


@implementation PostItem

- (id <TETableViewItem>)expandItem {
    TETableViewItem *item = [[TETableViewItem alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:nil];
    item.subtitle = self.content;
    return item;
}

@end