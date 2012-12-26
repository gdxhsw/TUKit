//
//  TELoadingImageViewViewController.m
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/26.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TELoadingImageViewViewController.h"

@interface TELoadingImageViewViewController ()

@end

@implementation TELoadingImageViewViewController

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
    self.loadingImageView.imagePath = @"http://www.szqingren.info/tu/%E5%A4%9C%E9%B9%8F%E5%9F%8E%E5%AD%A6%E7%94%9F%E5%A6%B9-D06.jpg";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLoadingImageView:nil];
    [super viewDidUnload];
}
@end
