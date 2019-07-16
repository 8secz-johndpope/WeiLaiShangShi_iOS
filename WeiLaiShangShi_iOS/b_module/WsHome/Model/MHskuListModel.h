//
//  MHskuListModel.h
//  mohu
//
//  Created by yuhao on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHskuListModel : MHBaseModel
//商品规格id
@property (nonatomic, strong)NSString *id;
//商品属性key 规则：（商品id|属性名id|属性值|属性名id|属性值...）
@property (nonatomic, strong)NSString *key;
//商品id
@property (nonatomic, strong)NSString *productId;
//库存
@property (nonatomic, strong)NSString *amount;
//价格
@property (nonatomic, strong)NSNumber *retailPrice;
//图片
@property (nonatomic, strong)NSString *image;
//属性（白色 15.4英寸）
@property (nonatomic, strong)NSString *attribute;
//
@property (nonatomic, strong)NSString *activitySkuId;

@property (nonatomic, strong)NSString *marketPrice;
@end
