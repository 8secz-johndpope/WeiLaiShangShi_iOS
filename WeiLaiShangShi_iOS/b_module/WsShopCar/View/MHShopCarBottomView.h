//
//  MHShopCarBottomView.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ShopCarBotttomViewAllSelectBlock)(BOOL isSelected);
typedef void(^ShopCarBotttomViewSettleBlock)(void);
//暂未使用
typedef void(^ShopCarBotttomViewStarBlock)(void);
typedef void(^ShopCarBotttomViewDeleteBlock)(void);
@interface MHShopCarBottomView : UIView
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalPriceLable;
@property (nonatomic, strong) UIButton *settleButton;
@property (nonatomic, strong) UIButton *starButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic, copy) ShopCarBotttomViewAllSelectBlock shopcartBotttomViewAllSelectBlock;
@property (nonatomic, copy) ShopCarBotttomViewSettleBlock shopcartBotttomViewSettleBlock;
@property (nonatomic, copy) ShopCarBotttomViewStarBlock shopcartBotttomViewStarBlock;
@property (nonatomic, copy) ShopCarBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;

- (void)changeShopcartBottomViewWithStatus:(BOOL)status;
@end
