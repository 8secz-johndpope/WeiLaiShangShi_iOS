//
//  MHWithDrawRecordModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/16.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWithDrawRecordModel : MHBaseModel

@property (nonatomic, strong) NSString * bankAccount;
@property (nonatomic, strong) NSString * bankType;
@property (nonatomic, strong) NSString * cardCode;
@property (nonatomic, strong) NSString * fee;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * withdrawCode;
@property (nonatomic, strong) NSString * withdrawDate;
@property (nonatomic, assign) NSInteger withdrawState;
@property (nonatomic, strong) NSString * withdrawType;


@end

NS_ASSUME_NONNULL_END
