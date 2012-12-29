//
//  TEViewController.m
//  TUKitSample
//
//  Created by  on 12/5/28.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEViewController.h"

#define ITEM_TAG_IMAGELOADER_FROM_URL       1
#define ITEM_TAG_LOADING_IMAGE_VIEW         2

#define ITEM_TAG_EXPANDABLE_TABLE_VIEW      11
#define ITEM_TAG_EXPANDABLE_TABLE_VIEW_2    12

@interface TEViewController ()

@end


@implementation TEViewController

#pragma mark - Private methods

- (void)__loadMenu {
    TETableViewSection *imageLoaderSection = [TETableViewSection new];
    imageLoaderSection.title = @"TEImageLoader";
    
    TETableViewItem *loadImageFromUrlItem = [[TETableViewItem alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:nil];
    loadImageFromUrlItem.title = @"Load image from url";
    loadImageFromUrlItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    loadImageFromUrlItem.tag = ITEM_TAG_IMAGELOADER_FROM_URL;
    
    TETableViewItem *loadingImageViewItem = [[TETableViewItem alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:nil];
    loadingImageViewItem.title = @"TELoadingImageView";
    loadingImageViewItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    loadingImageViewItem.tag = ITEM_TAG_LOADING_IMAGE_VIEW;
    
    imageLoaderSection.items = @[
    loadImageFromUrlItem,
    loadingImageViewItem
    ];
    
    TETableViewSection *tableViewSection = [TETableViewSection new];
    tableViewSection.title = @"TETableView";
    
    TETableViewItem *expandableItem = [TETableViewItem new];
    expandableItem.title = @"Expandable TableView";
    expandableItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    expandableItem.tag = ITEM_TAG_EXPANDABLE_TABLE_VIEW;
    
    TETableViewItem *expandableItem2 = [TETableViewItem new];
    expandableItem2.title = @"Expandable TableView 2";
    expandableItem2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    expandableItem2.tag = ITEM_TAG_EXPANDABLE_TABLE_VIEW_2;
    
    tableViewSection.items = @[
    expandableItem,
    expandableItem2,
    ];
    
    _dataSource.items = @[
    imageLoaderSection,
    tableViewSection,
    ];
    
    [self.tableView reloadData];
}

- (void)__initTableView {
    _dataSource = [TETableViewSectionDataSource new];
    self.tableView.dataSource = _dataSource;
    
    _delegate = [TETableViewDelegate new];
    _delegate.actionDelegate = self;
    self.tableView.delegate = _delegate;
    
    [self __loadMenu];
}

#pragma mark - TETableViewActionDelegate

- (void)tableView:(UITableView *)tableView didSelectItem:(id<TETableViewItem>)item atIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if ([item isKindOfClass:[TETableViewItem class]]) {
            TETableViewItem *selectedItem = item;
            switch (selectedItem.tag) {
                case ITEM_TAG_IMAGELOADER_FROM_URL:
                    [self performSegueWithIdentifier:@"imageLoaderFromUrlSegue"
                                              sender:nil];
                    break;
                case ITEM_TAG_LOADING_IMAGE_VIEW:
                    [self performSegueWithIdentifier:@"loadingImageViewSegue"
                                              sender:nil];
                    break;
                case ITEM_TAG_EXPANDABLE_TABLE_VIEW:
                    [self performSegueWithIdentifier:@"expandableTableViewSegue"
                                              sender:nil];
                    break;
                case ITEM_TAG_EXPANDABLE_TABLE_VIEW_2:
                    [self performSegueWithIdentifier:@"expandableTableViewSegue2"
                                              sender:nil];
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self __initTableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
