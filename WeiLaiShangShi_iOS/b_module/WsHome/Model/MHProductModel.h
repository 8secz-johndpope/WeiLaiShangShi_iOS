//
//  MHProductModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHProductModel : MHBaseModel
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productSmallImage;
@property (nonatomic, copy) NSString * productImage;
@property (nonatomic, copy) NSString * marketPrice;
@property (nonatomic, copy) NSString * retailPrice;
@property (nonatomic, copy) NSString * sellCount;
@property (nonatomic, copy) NSString * productUrl;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, assign)NSInteger updown;

@end
