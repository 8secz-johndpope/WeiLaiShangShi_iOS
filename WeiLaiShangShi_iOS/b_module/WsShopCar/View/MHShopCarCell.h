//
//  MHShopCarCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@class MHShopCarProductModel;
typedef void (^ShopCarCellBlock)(BOOL isSelelct);
typedef void (^ShopCarCellEditBlock)(NSInteger count);
typedef void (^ShopCarCellShowSizeBlock)(NSString *des);
@interface MHShopCarCell : MGSwipeTableCell
@property (nonatomic, strong)MHShopCarProductModel *model;
@property (nonatomic, copy)ShopCarCellBlock shopCarCellBlock;
@property (nonatomic, copy)ShopCarCellEditBlock shopCarCellEditBlock;
@property (nonatomic, copy)ShopCarCellShowSizeBlock shopCarCellShowSizeBlock;
- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                                productSize:(NSString *)productSize
                               productPrice:(NSString *)productPrice
                               productCount:(NSInteger)productCount
                               productStock:(NSInteger)productStock
                            productSelected:(BOOL)productSelected
                            isEdit:(BOOL)isEdit;
@property (nonatomic, strong)UIView *viewline;
@end
