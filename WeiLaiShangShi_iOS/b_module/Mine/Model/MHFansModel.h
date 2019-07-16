//
//  MHFansModel.h
//  wgts
//
//  Created by AllenQin on 2018/11/13.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHFansModel : MHBaseModel

@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, assign) NSInteger userRole;
@property (nonatomic, strong) NSString * createTime;


@end

NS_ASSUME_NONNULL_END
