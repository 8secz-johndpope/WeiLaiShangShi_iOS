//
//  MHShopSumbitModel.h
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHShopSumbitModel : MHBaseModel

@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString * area;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * details;
@property (nonatomic, copy) NSString * orderDisCountTip;
@property (nonatomic, copy) NSString * orderDiscountPrice;
@property (nonatomic, copy) NSString * orderPrice;
@property (nonatomic, copy) NSString * orderSendPrice;
@property (nonatomic, copy) NSString * orderTruePrice;
@property (nonatomic, copy) NSString * orderType;
@property (nonatomic, copy) NSString * productCount;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userPhone;
@property (nonatomic, copy) NSString * payType;
@property (nonatomic, copy) NSString * orderState;
@property (nonatomic, copy) NSString * orderTradeState;
@property (nonatomic, copy) NSString * availableBalance;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * payTime;
@property (nonatomic, copy) NSString * commissionProfit;
@property (nonatomic, copy) NSString * totalProducts;
@property (nonatomic, copy) NSString * orderCommissionProfit;
@property (nonatomic, copy) NSString * orderCode;
@property (nonatomic, copy) NSString * expressType;
@property (nonatomic, copy) NSString * expressCode;
@property (nonatomic, assign) NSInteger orderId;


@end
