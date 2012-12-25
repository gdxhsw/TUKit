//
//  TEImageLoaderFromUrlViewController.h
//  TUKitSample
//
//  Created by gaspard.wu on 12/12/25.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TUKit/TEImageLoader.h>

@interface TEImageLoaderFromUrlViewController : UIViewController <TEImageLoaderDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
