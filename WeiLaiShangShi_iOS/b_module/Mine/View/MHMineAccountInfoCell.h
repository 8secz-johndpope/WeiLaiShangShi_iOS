//
//  MHMineAccountInfoCell.h
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichStyleLabel.h"

@interface MHMineAccountInfoCell : UITableViewCell

@property(strong,nonatomic)RichStyleLabel *richLabel;


@property(strong,nonatomic)UILabel *addLabel;

@property(strong,nonatomic)UILabel *leftLabel;

@property(strong,nonatomic)UILabel *midLabel;

@property(strong,nonatomic)UILabel *rightLabel;

@property(strong,nonatomic)UIButton *btn;

@property(strong,nonatomic)UIViewController *superVC;


@end
