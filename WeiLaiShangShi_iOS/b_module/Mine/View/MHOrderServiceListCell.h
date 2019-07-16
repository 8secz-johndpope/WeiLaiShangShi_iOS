//
//  MHOrderServiceListCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/19.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHOrderServiceListCell : UITableViewCell

@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic) UILabel *label;
@property(strong,nonatomic) UILabel *label2;
@property(strong,nonatomic) UILabel *label3;
@property(strong,nonatomic)NSDictionary  *dict;

@end

NS_ASSUME_NONNULL_END
