//
//  MHLoginApi.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseRequest.h"

@interface MHLoginApi : MHBaseRequest

- (id)initWithLogin:(NSDictionary *)username
                sms:(NSString *)smsCode;

- (NSInteger )errcode;

@end
