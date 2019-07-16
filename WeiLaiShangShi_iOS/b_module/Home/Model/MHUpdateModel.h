//
//  MHUpdateModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHUpdateModel : MHBaseModel

@property (nonatomic, strong) NSString * channel;
@property (nonatomic, assign) NSInteger forceUpgrade;
@property (nonatomic, assign) NSInteger upgrade;
@property (nonatomic, strong) NSString * upgradeLog;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * version;
@property (nonatomic, assign) NSInteger versionCode;


@end

NS_ASSUME_NONNULL_END
