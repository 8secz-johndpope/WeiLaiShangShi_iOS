//
//  HSHDModel.h
//  HSKD
//
//  Created by AllenQin on 2019/4/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSHDModel : MHBaseModel

@property (nonatomic, strong) NSString * activityType;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * url;

@end

NS_ASSUME_NONNULL_END
