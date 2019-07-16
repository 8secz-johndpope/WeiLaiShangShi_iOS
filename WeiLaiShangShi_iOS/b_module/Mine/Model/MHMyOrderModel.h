//
//  MHMyOrderModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyOrderModel : MHBaseModel

@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productPrice;
@property (nonatomic, strong) NSString * productSmallImage;
@property (nonatomic, strong) NSString * productStandard;
@property (nonatomic, assign) NSInteger skuId;

@end

NS_ASSUME_NONNULL_END
