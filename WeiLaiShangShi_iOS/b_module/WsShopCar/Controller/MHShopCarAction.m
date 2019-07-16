//  MHShopCarAction.m
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarAction.h"
#import "MHShopCarCell.h"
#import "MHShopCarProductModel.h"
#import "MHShopCarBrandModel.h"
@interface MHShopCarAction ()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;    /**< 购物车数据源 */

@end
@implementation MHShopCarAction

- (void)requestShopcartProductList {
    //在这里请求数据 当然我直接用本地数据模拟的
  
    self.shopcartListArray = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initWithShopCartListcompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
//
           
            NSMutableArray *arr =[response valueForKey:@"data"];
            for (int i = 0; i < arr.count; i ++ ) {
                MHShopCarBrandModel *brandmodel = [[MHShopCarBrandModel alloc]init];
                NSMutableArray *productArr = [NSMutableArray array];
                NSMutableArray *brr =[NSMutableArray arrayWithArray:[[arr objectAtIndex:i] valueForKey:@"products"]];
                for (int j= 0; j< brr.count ; j++) {
                    MHShopCarProductModel *model = [[MHShopCarProductModel alloc]init];
                    model.isSelected = NO;
                    model.status = [[brr objectAtIndex:j] valueForKey:@"status"];
                    model.productCount = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productCount"]];
                    model.cartId = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"cartId"]];
                    model.productSmallImage = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productSmallImage"]];
                    model.productName = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productName"]];
                    model.productStandard = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productStandard"]];
                    model.skuId = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"skuId"]];
                    model.productPrice = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productPrice"]];
                    model.skuAmount =[[NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"skuAmount"]] integerValue];
                    NSString *str = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"activitySkuId"]];
                    if (klStringisEmpty(str)) {
                        str = @"";
                    }
                    model.activitySkuId =str;
                    model.productId = [NSString stringWithFormat:@"%@",[[brr objectAtIndex:j] valueForKey:@"productId"]];
                    [productArr addObject:model];
                }
                
                brandmodel.products =productArr;
                brandmodel.sellerName = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"sellerName"]];
                brandmodel.sellerId = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"sellerId"]];
                brandmodel.sellerIcon = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"sellerIcon"]];
                brandmodel.moneyDesc = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"moneyDesc"]];
                [self.shopcartListArray addObject:brandmodel];
            }
            //成功之后回调
            [self.delegate shopcartFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
        }else{
            KLToast([response valueForKey:@"message"]);
        }
    }];
    
    
    

   
   
}

- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    
    
    MHShopCarBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    MHShopCarProductModel *productModel = brandModel.products[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (MHShopCarProductModel *aProductModel in brandModel.products) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected {
    MHShopCarBrandModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (MHShopCarProductModel *aProductModel in brandModel.products) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}


- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    
    MHShopCarBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    MHShopCarProductModel *productModel = brandModel.products[indexPath.row];
    if (count <= 0) {
        count = 1;
         KLToast(@"商品数量不可少于1");
    }
    else if (count > productModel.skuAmount) {
        KLToast(@"已超出商品库存");
        count = productModel.skuAmount;
    }
    [[MHUserService sharedInstance]initWithShopCartListProductId:productModel.cartId amount:[NSString stringWithFormat:@"%ld",count] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            //根据请求结果决定是否改变数据
            productModel.productCount =[NSString stringWithFormat:@"%ld",(long)count];
            
            [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
        }else{
            KLToast([response valueForKey:@"message"]);
        }
        
    }];
    
    
}

- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    
    MHShopCarBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    MHShopCarProductModel *productModel = brandModel.products[indexPath.row];
    
    //根据请求结果决定是否删除
    [[MHUserService sharedInstance]initWithDeleteSHopProductId:[NSString stringWithFormat:@"%@",productModel.cartId] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
             [brandModel.products removeObject:productModel];
            if (brandModel.products.count == 0) {
                [self.shopcartListArray removeObject:brandModel];
            } else {
                if (!brandModel.isSelected) {
                    BOOL isBrandSelected = YES;
                    for (MHShopCarProductModel *aProductModel in brandModel.products) {
                        if (!aProductModel.isSelected) {
                            isBrandSelected = NO;
                            break;
                        }
                    }
                    
                    if (isBrandSelected) {
                        brandModel.isSelected = YES;
                    }
                }
            }
            [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
            
            if (self.shopcartListArray.count == 0) {
                [self.delegate shopcartFormatHasDeleteAllProducts];
            }
        }else{
            KLToast(@"删除失败");
        }
        
        
    }];

    
   
    
    
}

- (void)beginToDeleteSelectedProducts {
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        for (MHShopCarProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedProducts:selectedArray];
}

- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        
        NSString *str= @"";
        for (int i = 0; i < selectedArray.count; i++) {
            MHShopCarProductModel *productModel = [selectedArray objectAtIndex:i];
            if (i== 0) {
                 str = [NSString stringWithFormat:@"%@%@",str,productModel.cartId];
            }else{
                 str = [NSString stringWithFormat:@"%@,%@",str,productModel.cartId];
            }
           
            
        }
        MHLog(@"%@",str);
        [[MHUserService sharedInstance]initWithDeleteSHopProductId:str completionBlock:^(NSDictionary *response, NSError *error) {
             if (ValidResponseDict(response)) {
                [brandModel.products removeObjectsInArray:selectedArray];
                 if (brandModel.products.count == 0) {
                     [emptyArray addObject:brandModel];
                 }
                 if (emptyArray.count) {
                     // 网络请求删除
                     [self.shopcartListArray removeObjectsInArray:emptyArray];
                 }
                 [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
                 
                 if (self.shopcartListArray.count == 0) {
                     [self.delegate shopcartFormatHasDeleteAllProducts];
                 }
             }else{
                 KLToast(@"删除失败")
             }
            
            
        }];

        
       
    }
    
   
   
}
//进入到商品详情页
- (void)enterDetailAtIndexPath:(NSIndexPath *)indexPath{
    MHShopCarBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    MHShopCarProductModel *productModel = brandModel.products[indexPath.row];
    [self.delegate shopCartFormatenteyDetailwithMHShopCarProductModel:productModel];
}

- (void)starProductAtIndexPath:(NSIndexPath *)indexPath {
    //这里写收藏的网络请求
    
}

- (void)starSelectedProducts {
    //这里写批量收藏的网络请求
    
}

- (void)selectAllProductWithStatus:(BOOL)isSelected {
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (MHShopCarProductModel *productModel in brandModel.products) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)settleSelectedProducts {
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (MHShopCarProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
        
        brandModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
    }
    
    [self.delegate shopcartFormatSettleForSelectedProducts:settleArray];
}
- (void)showProductSizeDes
{
    
}



#pragma mark private methods
- (float)accountTotalPrice {
    float totalPrice = 0.f;
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        for (MHShopCarProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                NSInteger num  = [productModel.productCount integerValue];
                CGFloat siger = [productModel.productPrice floatValue];
                totalPrice += siger * num;
            }
        }
    }
    
    return totalPrice;
}

- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        for (MHShopCarProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                NSInteger num  = [productModel.productCount integerValue];
                totalCount += num;
            }
        }
    }
    
    return totalCount;
}

- (BOOL)isAllSelected {
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (MHShopCarBrandModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}

@end
