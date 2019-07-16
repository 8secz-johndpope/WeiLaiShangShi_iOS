//
//  HSDTModel.h
//  HSKD
//
//  Created by AllenQin on 2019/5/7.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSDTModel : MHBaseModel

@property (nonatomic, strong) NSArray * cover;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * url;


@end

NS_ASSUME_NONNULL_END
