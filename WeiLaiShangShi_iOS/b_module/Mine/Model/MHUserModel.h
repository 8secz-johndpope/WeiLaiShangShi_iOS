//
//  MHUserModel.h
//  wgts
//
//  Created by AllenQin on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHUserModel : MHBaseModel

@property (nonatomic, copy) NSString * availableBalance;
@property (nonatomic, copy) NSString * todayIncome;
@property (nonatomic, copy) NSString * totalIncome;
@property (nonatomic, copy) NSString * totalWithdraw;
@property (nonatomic, copy) NSString * userCode;
@property (nonatomic, copy) NSString * userImage;
@property (nonatomic, copy) NSString * userNickName;
@property (nonatomic, copy) NSString * userPhone;
@property (nonatomic, copy) NSString * frozenAsset;
@property (nonatomic, assign) NSInteger userRole;
@property (nonatomic, assign) NSInteger vipFansCount;
@property (nonatomic, assign) NSInteger svipFansCount;
@property (nonatomic, copy) NSString * illegal;
@end

NS_ASSUME_NONNULL_END
