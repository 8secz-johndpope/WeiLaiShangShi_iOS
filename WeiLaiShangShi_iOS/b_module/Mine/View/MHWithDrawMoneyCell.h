//
//  MHWithDrawMoneyCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMoneyTextField.h"


@interface MHWithDrawMoneyCell : UITableViewCell

@property(copy,nonatomic) NSString *maxString;

@property(strong,nonatomic) UILabel *stateLabel;

@property(strong,nonatomic)CSMoneyTextField *tf;

@end
