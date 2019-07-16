//
//  HSShopCollectionCell.h
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSShopItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSShopCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *backGroudImageView ;
@property (nonatomic, strong) UILabel *jifenLabel;



- (void)creatItemModel:(HSShopItemModel *)model;

@end

NS_ASSUME_NONNULL_END
