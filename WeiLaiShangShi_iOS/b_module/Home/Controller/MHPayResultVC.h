//
//  MHPayResultVC.h
//  mohu
//
//  Created by AllenQin on 2018/10/15.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHMyOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHPayResultVC : MHBaseViewController

@property (copy,nonatomic) NSString *stateStr;
@property (copy,nonatomic) NSString *typeStr;

@property (copy,nonatomic) NSString *commissionProfit;

@property (copy,nonatomic) NSString *orderCode;


@property (copy,nonatomic) NSString *orderType;

@property (copy,nonatomic) NSString *orderTruePrice;

@property (assign,nonatomic)NSInteger orderId;

//@property (strong,nonatomic) MHMyOrderListModel *model;

@end

NS_ASSUME_NONNULL_END
