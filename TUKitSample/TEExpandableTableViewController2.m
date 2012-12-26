//
//  TEExpandableTableViewController2.m
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEExpandableTableViewController2.h"

@interface TEExpandableTableViewController2 ()

@end

@implementation TEExpandableTableViewController2

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
    _delegate = [[TETableViewExpandableDelegate alloc] initWithExpandMultipleItem:YES];
    self.tableView.delegate = _delegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
