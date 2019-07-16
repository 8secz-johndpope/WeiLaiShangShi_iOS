//
//  MHSumbitModel.h
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"
#import "MHProductDetailModel.h"

@interface MHSumbitModel : MHBaseModel

@property (nonatomic, strong) NSArray  *products;
@property (nonatomic, strong) NSString * sellerIcon;
@property (nonatomic, assign) NSString *sellerId;
@property (nonatomic, copy) NSString * leaveMessage;
@property (nonatomic, strong) NSString * sellerName;


@end
