//
//  MHOrderProCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHOrderProCell : UITableViewCell

@property(strong,nonatomic) UIImageView *leftImageView;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *saleLabel;

@property(strong,nonatomic) UILabel    *priceLabel;

@property(strong,nonatomic) UILabel    *numberLabel;

@property(strong,nonatomic) NSDictionary   *dataDict;

@end
