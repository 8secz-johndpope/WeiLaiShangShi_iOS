//
//  MHLevelRecordModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHLevelRecordModel : MHBaseModel

@property (nonatomic, strong) NSString * relationUserNickName;
@property (nonatomic, assign) CGFloat scoreRecordMoney;
@property (nonatomic, strong) NSString * userImage;
@property (nonatomic, strong) NSString * userNickName;
@property (nonatomic, strong) NSString * relationUserRole;

@end

NS_ASSUME_NONNULL_END
