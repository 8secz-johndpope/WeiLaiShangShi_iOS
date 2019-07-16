//
//  MHShopCarProductModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHShopCarProductModel : MHBaseModel
/*
 * 商品规格
 */
@property (nonatomic, assign) NSInteger specWidth;      //宽
@property (nonatomic, assign) NSInteger specHeight;     //高
@property (nonatomic, assign) NSInteger specLength;     //长
@property (nonatomic, copy) NSString *productStandard;
/*
 * 商品规格id
 */

@property (nonatomic, copy) NSString *skuId;
/*
 * 商品状态 ACTIVE：激活，其他状态表示商品已下架
 */
@property (nonatomic, copy) NSString *status;

/*
 * 商品描述
 */
@property (nonatomic, copy) NSString *productStyle;

/*
 * 商品描述
 */
@property (nonatomic, copy) NSString *cartId;

/*
 * 品牌图片
 */
@property (nonatomic, copy) NSString *brandPicUri;
/*
 * 商品id
 */
@property (nonatomic, copy) NSString *productId;
/*
 * 商品类型
 */
@property (nonatomic, copy) NSString *productType;
/*
 * 品牌名
 */
@property (nonatomic, copy) NSString *brandName;
/*
 * 品牌id
 */
@property (nonatomic, copy) NSString *brandId;
/*
 * 商品库存
 */
@property (nonatomic, assign) long skuAmount;
/*
 * 
 */
@property (nonatomic, strong) NSString *activitySkuId;


/*
 * 商品数量
 */
@property (nonatomic, strong) NSString *productCount;

/*
 * 商品原价
 */
@property (nonatomic, strong) NSString *originPrice;
/*
 * 商品价格
 */
@property (nonatomic, copy) NSString * productPrice;
/*
 * 会员用户商品价格
 */
@property (nonatomic, copy) NSString *productVipPrice;

/*
 * 商品名称
 */
@property (nonatomic, copy) NSString *productName;
/*
 * 商品图片
 */
@property (nonatomic, copy) NSString *productPicUri;
/*
 * 商品图片
 */
@property (nonatomic, copy) NSString *productSmallImage;





@property (nonatomic, copy) NSString *retailPrice;

@property (nonatomic, copy) NSString *productUrl;


@property(nonatomic, assign)BOOL isSelected;    //记录相应row是否选中（自定义）


@end
