//
//  MHShopModel.h
//  wgts
//
//  Created by AllenQin on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHShopModel : MHBaseModel

@property (nonatomic, strong) NSString * marketPrice;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productSmallImage;
@property (nonatomic, strong) NSString * productType;
@property (nonatomic, strong) NSString * retailPrice;
@property (nonatomic, assign) NSInteger sellCount;
@property (nonatomic, strong) NSString *productStandard;
@end

NS_ASSUME_NONNULL_END
