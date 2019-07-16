//
//  HSFriendCell.h
//  HSKD
//
//  Created by AllenQin on 2019/5/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichStyleLabel.h"
#import "HSShopItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSFriendCell : UICollectionViewCell

//@property(strong,nonatomic)UILabel *leftLine;

@property(strong,nonatomic)UILabel *ylzLabel;

@property(strong,nonatomic)RichStyleLabel *priceLabel;


- (void)createModel:(HSShopItemModel *)model;

@end

NS_ASSUME_NONNULL_END
