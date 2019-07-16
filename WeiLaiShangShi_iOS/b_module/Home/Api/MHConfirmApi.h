//
//  MHConfirmApi.h
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseRequest.h"

@interface MHConfirmApi : MHBaseRequest

- (instancetype)initWithArr:(NSArray *)prodArr addressId:(NSString *)addressId payType:(NSString *)payType orderType:(NSString *)orderType orderTruePrice:(NSString *)orderTruePrice  payPassword:(NSString *)payPassword;

@end
