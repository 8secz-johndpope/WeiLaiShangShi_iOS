//
//  MHChildOrderTableViewCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMyOrderListModel.h"
#import "RichStyleLabel.h"

@interface MHChildOrderTableViewCell : UITableViewCell


@property(strong,nonatomic) UIImageView *leftImageView;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *dataLabel;

@property(strong,nonatomic) UILabel    *dingdanLabel;

@property(strong,nonatomic) UILabel    *stateLabel;



//@property(strong,nonatomic) RichStyleLabel    *priceLabel;

@property(strong,nonatomic) UILabel    *numberLabel;

@property(strong,nonatomic) UILabel *moneyLabel;

@property(strong,nonatomic) UILabel *alllabel;

@property(nonatomic, strong) NSArray *ActivityArr;

@property(nonatomic, strong)UIView *bgView;


@property(nonatomic, strong)MHMyOrderListModel *model;


@property(nonatomic, strong)UIViewController *superVC;

@property (nonatomic,copy) void(^cancleClick)(void);


-(void)createModel:(MHMyOrderListModel *)model;

@end
