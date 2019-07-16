//
//  MHProductCell.h
//  wgts
//
//  Created by yuhao on 2018/11/7.
//  Copyright © 2018 mhyouping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichStyleLabel.h"
#import "MHShopModel.h"

@interface MHProductCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UILabel *Originpricelabel;
@property (nonatomic, strong) UILabel *salenumlabel;
@property (nonatomic, strong) UIView  *likebg;
@property (nonatomic, strong) UIButton *Buybtn;

- (void)creatModel:(MHShopModel *)model;
@end
