//
//  MHHomeGoodsHeadSortTitleView.h
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^DefaultSort)(void);
typedef void(^SaleNumSort)(NSInteger type);
typedef void(^PriceNumSort)(NSInteger type);
typedef void(^Sort)(NSInteger type);
@interface MHHomeGoodsHeadSortTitleView : UIView
@property(nonatomic ,copy)DefaultSort defaultsort;
@property(nonatomic ,copy)SaleNumSort saleNumSort;
@property(nonatomic ,copy)PriceNumSort priceNumSort;
@property(nonatomic ,copy)Sort sort;
@end
