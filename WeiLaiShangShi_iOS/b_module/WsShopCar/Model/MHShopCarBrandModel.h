//
//  MHShopCarBrandModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHShopCarProductModel.h"
@interface MHShopCarBrandModel : NSObject

@property (nonatomic, copy) NSString *sellerId;
@property (nonatomic, strong) NSMutableArray<MHShopCarProductModel *> *products;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *sellerIcon;
@property (nonatomic, assign)BOOL isSelected; //记录相应section是否全选（自定义）
@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品（自定义）
@property (nonatomic, copy) NSString *moneyDesc;
@end
