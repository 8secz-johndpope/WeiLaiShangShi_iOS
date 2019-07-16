//
//  HSRewardModel.h
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSRewardModel : MHBaseModel

@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * detail;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * flowType;
@property (nonatomic, strong) NSString * recordCode;
@property (nonatomic, strong) NSString * recordMoney;
@property (nonatomic, strong) NSString * power;
@property (nonatomic, strong) NSString * recordType;
@property (nonatomic, assign) float  deductPower;

@end

NS_ASSUME_NONNULL_END
