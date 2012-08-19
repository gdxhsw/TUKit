//
//  TETextFieldCell.h
//  libTUKit
//
//  Created by GDX on 12/8/19.
//  Copyright (c) 2012年 28 interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../TEArcCompatible.h"

@interface TETextFieldCell : UITableViewCell

@property (STRONG, nonatomic) IBOutlet UILabel *titleLabel;
@property (STRONG, nonatomic) IBOutlet UITextField *textField;

@end
