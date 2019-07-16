//
//  MHAssestCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHShopAssetModel.h"


@interface MHAssestCell : UITableViewCell

@property(strong,nonatomic)UILabel *timeLabel;

@property(strong,nonatomic)UILabel *dataLabel;


@property(strong,nonatomic)UILabel *titlesLabel;


@property(strong,nonatomic)UILabel *moneyLabel;

@property(strong,nonatomic)UILabel *descLabel;

@property(strong,nonatomic)UIView  *bgView;

- (void)createModel:(MHShopAssetModel *)model;

@end
