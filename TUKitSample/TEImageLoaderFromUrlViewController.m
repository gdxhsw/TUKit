//
//  TEImageLoaderFromUrlViewController.m
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/25.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import "TEImageLoaderFromUrlViewController.h"

#define IMAGE_URL_MODEL @"http://camera.chinatimes.com/450Pic/20081002/4/20081002120635_0.jpg"
#define IMAGE_URL_ROCK  @"http://i.dailymail.co.uk/i/pix/2012/11/15/article-0-1609D0FF000005DC-373_964x641.jpg"
#define IMAGE_URL_AIN   @"http://images.nymag.com/news/features/spectrum121029_560.jpg"
#define IMAGE_URL_APPLE @"http://www.themobileindian.com/images/nnews/2012/10/8999/Apple-logo.jpg"

@interface TEImageLoaderFromUrlViewController ()

@end

@implementation TEImageLoaderFromUrlViewController

#pragma mark - TEImageLoaderDelegate

- (void)imageLoader:(TEImageLoader *)loader loadedWithPath:(NSString *)path image:(UIImage *)image {
    [self.imageView performSelectorOnMainThread:@selector(setImage:)
                                     withObject:image
                                  waitUntilDone:YES];
}

- (void)imageLoader:(TEImageLoader *)loader loadFailedWithPath:(NSString *)path error:(NSError *)error {
    TELOG(@"%@", error);
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
    [TEImageLoader clearCacheImages];
    [TEImageLoader loadImageWithPath:IMAGE_URL_MODEL
                            delegate:self];
    [TEImageLoader loadImageWithPath:IMAGE_URL_ROCK
                            delegate:self];
    [TEImageLoader loadImageWithPath:IMAGE_URL_AIN
                            delegate:self];
    [TEImageLoader loadImageWithPath:IMAGE_URL_APPLE
                            delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [TEImageLoader cancelOperationsWithDelegate:self];
}

@end
