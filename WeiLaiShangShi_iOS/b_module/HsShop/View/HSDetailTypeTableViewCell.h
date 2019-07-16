//
//  HSDetailTypeTableViewCell.h
//  HSKD
//
//  Created by AllenQin on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSShopDeatilModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSDetailTypeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel ;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *jifenLabel;

- (void)creatItemModel:(HSShopDeatilModel *)model;

@end

NS_ASSUME_NONNULL_END
