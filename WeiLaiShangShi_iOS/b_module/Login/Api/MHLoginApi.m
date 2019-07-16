//
//  MHLoginApi.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHLoginApi.h"

@implementation MHLoginApi{
    
    NSString *_account;
    NSString *_smsCode;
    
}

- (id)initWithLogin:(NSString *)username
                sms:(NSString *)smsCode{
    self = [super init];
    if (self) {
        _account = username;
        _smsCode = smsCode;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return kLoginUrl;
}

- (id)requestArgument {
     return @{ @"account": _account,@"password": _smsCode};
}

- (NSInteger )errcode {
    return [[[self responseJSONObject] objectForKey:@"code"] integerValue];
}


@end
