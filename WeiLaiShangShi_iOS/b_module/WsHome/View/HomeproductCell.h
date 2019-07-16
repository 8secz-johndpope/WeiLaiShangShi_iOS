//
//  HomeproductCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHProductModel.h"
#import "RichStyleLabel.h"


typedef void(^cancelCollect)(NSInteger index);

@interface HomeproductCell : UITableViewCell
@property (nonatomic, copy) cancelCollect CancelAct;
@property (nonatomic, strong) MHProductModel *ProductModel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UILabel *Originpricelabel;
@property (nonatomic, strong) UILabel *salenumlabel;
@property (nonatomic, strong) UIView  *likebg;
@property (nonatomic, strong) UIButton *Buybtn;
@property (nonatomic, strong) UIImageView *imagebg;
//@property (nonatomic, strong) UIButton *shangjiaBtn;
@property (nonatomic, strong) RichStyleLabel *richLabel;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, strong) UIButton *cancle;
@property (nonatomic, strong) UIView  *clearView;
@end
