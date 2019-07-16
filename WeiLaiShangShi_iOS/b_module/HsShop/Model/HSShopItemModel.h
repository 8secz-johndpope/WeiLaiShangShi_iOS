//
//  HSShopItemModel.h
//  HSKD
//
//  Created by AllenQin on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSShopItemModel : MHBaseModel

@property (nonatomic, strong) NSString * marketPrice;
@property (nonatomic, strong) NSString * parameter;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productSmallImage;
@property (nonatomic, strong) NSString * productStandard;
@property (nonatomic, strong) NSString * productSubtitle;
@property (nonatomic, strong) NSString * productType;
@property (nonatomic, strong) NSString * retailPrice;
@property (nonatomic, assign) BOOL select;
@end

NS_ASSUME_NONNULL_END
