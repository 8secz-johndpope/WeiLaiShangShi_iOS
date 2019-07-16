//
//  MHWithDrawPayCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHWithDrawListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWithDrawPayCell : UITableViewCell

@property (nonatomic,strong) UILabel  *titleLabel;

@property (nonatomic,strong) UILabel  *rightLabel;

@property (nonatomic,strong) UIImageView  *leftImageView;

@property (nonatomic,strong) UIImageView  *rightImageView;


@property (nonatomic,strong) UIButton  *selectBtn;

@property (nonatomic,strong) UIButton  *editBtn;

-(void)createModel:(MHWithDrawListModel *)model;

@end

NS_ASSUME_NONNULL_END
