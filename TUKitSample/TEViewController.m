//
//  TEViewController.m
//  TUKitSample
//
//  Created by  on 12/5/28.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEViewController.h"

#define ITEM_TAG_IMAGELOADER_FROM_URL   1

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
    loadImageFromUrlItem.selectionStyle = UITableViewCellSelectionStyleBlue;
    loadImageFromUrlItem.tag = ITEM_TAG_IMAGELOADER_FROM_URL;
    imageLoaderSection.items = @[loadImageFromUrlItem];
    
    _dataSource.items = @[imageLoaderSection];
    [self.tableView reloadData];
}

- (void)__initTableView {
    _dataSource = [TETableViewSectionDataSource new];
    self.tableView.dataSource = _dataSource;
    
    _delegate = [TETableViewDelegate new];
    _delegate.delegate = self;
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
