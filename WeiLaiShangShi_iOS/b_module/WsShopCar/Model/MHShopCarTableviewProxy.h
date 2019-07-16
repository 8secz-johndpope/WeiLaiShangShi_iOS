//
//  MHShopCarTableviewProxy.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTableViewPlaceHolder.h"


@protocol ShopCarProxyFrameDelegate<NSObject>
-(void)goaround;

@end

//选中产品
typedef void (^ShopCarProxyProductSelectBlock)(BOOL isSelelct, NSIndexPath *indexPath);
//选中店铺
typedef void(^ShopcarProxyBrandSelectBlock)(BOOL isSelected, NSInteger section);
//数量改变
typedef void(^ShopCarProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);
//删除
typedef void(^ShopCarProxyDeleteBlock)(NSIndexPath *indexPath);
//显示商品详细描述
typedef void(^ShopCarProxyShowProductSizeBlock)(NSIndexPath *indexPath);
//点击查看详情
typedef void(^ShopCarProxyEnterDetail)(NSIndexPath *indexPath);
//提示去升级
typedef void(^usergotoUpgrade)(void);

@interface MHShopCarTableviewProxy : NSObject<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) id<ShopCarProxyFrameDelegate>delegate;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy)ShopCarProxyProductSelectBlock shopCarProxyProductSelectBlock;
@property (nonatomic, copy)ShopcarProxyBrandSelectBlock shopcarProxyBrandSelectBlock;
@property (nonatomic, copy)ShopCarProxyChangeCountBlock shopCarProxyChangeCountBlock;
@property (nonatomic, copy)ShopCarProxyDeleteBlock shopCarProxyDeleteBlock;
@property (nonatomic, copy)ShopCarProxyEnterDetail shopCarProxyEnterDetail;

@property (nonatomic, copy)ShopCarProxyShowProductSizeBlock shopCarProxyShowProductSizeBlock;
@property (nonatomic, copy)usergotoUpgrade UsergotoUpgrade;
@end
