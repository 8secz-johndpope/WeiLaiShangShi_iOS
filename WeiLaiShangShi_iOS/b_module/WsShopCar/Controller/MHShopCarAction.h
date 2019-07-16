//
//  MHShopCarAction.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHShopCarProductModel;
@protocol MHShopCarActionDelegate <NSObject>
@required
- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected;
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatHasDeleteAllProducts;
- (void)shopCartFormatenteyDetailwithMHShopCarProductModel:(MHShopCarProductModel*)model;
@end


@interface MHShopCarAction : NSObject

@property(nonatomic,  weak)id<MHShopCarActionDelegate>delegate;
//请求购物车数据
- (void)requestShopcartProductList;
//选中/取消选中某个row
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
//选中/取消选中某个section
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;
//改变商品数
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
//单个删除商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
//批量删除商品
- (void)beginToDeleteSelectedProducts;
- (void)deleteSelectedProducts:(NSArray *)selectedArray;
//单个收藏商品
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
//批量收藏商品
- (void)starSelectedProducts;
//全选 or 取消全选
- (void)selectAllProductWithStatus:(BOOL)isSelected;
//结算选中商品
- (void)settleSelectedProducts;
//显示商品详细描述
- (void)showProductSizeDes;
//进入到商品详情页
- (void)enterDetailAtIndexPath:(NSIndexPath *)indexPath;


@end
