//
//  TEViewController.h
//  TUKitSample
//
//  Created by  on 12/5/28.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <TUKit/TUKit.h>

@interface TEViewController : UITableViewController <TETableViewActionDelegate> {
    TETableViewSectionDataSource *_dataSource;
    TETableViewDelegate *_delegate;
}

@end
