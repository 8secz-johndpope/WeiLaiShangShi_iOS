//
//  HSShopDescCell.h
//  HSKD
//
//  Created by AllenQin on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSShopDeatilModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSShopDescCell : UITableViewCell

@property (nonatomic, strong) UILabel *descLabel;

- (void)creatItemModel:(HSShopDeatilModel *)model;

@end

NS_ASSUME_NONNULL_END
