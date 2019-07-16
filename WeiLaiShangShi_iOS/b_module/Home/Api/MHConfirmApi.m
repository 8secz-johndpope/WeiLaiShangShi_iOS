//
//  MHConfirmApi.m
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHConfirmApi.h"
#import "NSString+WZXSSLTool.h"
#import "CTUUID.h"

@implementation MHConfirmApi{
    NSArray          *_prodArr;
    NSString        *_addressId;
    NSString        *_payType;
    NSString        *_orderType;
    NSString        *_orderTruePrice;
    NSString        *_payPassword;
}

- (instancetype)initWithArr:(NSArray *)prodArr addressId:(NSString *)addressId payType:(NSString *)payType orderType:(NSString *)orderType orderTruePrice:(NSString *)orderTruePrice  payPassword:(NSString *)payPassword{
    self = [super init];
    if (self) {
        _prodArr = prodArr;
        _addressId = addressId;
        _payType = payType;
        _orderType = orderType;
        _orderTruePrice = orderTruePrice;
        _payPassword = payPassword;
    }
    return self;
}


-(NSURLRequest *)buildCustomUrlRequest{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_prodArr forKey:@"products"];
    if (_addressId) {
          [dict setValue:_addressId forKey:@"addressId"];
    }
    if (ValidStr(_payPassword)) {
        [dict setValue:_payPassword forKey:@"payPassword"];
    }
    [dict setValue:_payType forKey:@"payType"];
    [dict setValue:_orderType forKey:@"orderType"];
    [dict setValue:_orderTruePrice forKey:@"orderTruePrice"];

//    NSDictionary *dict = [NSDictionary dictionaryWithObject:_prodArr forKey:@"products"];
    NSData*jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *timeStap = [CTUUID getTimeStamp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?appId=a2&appVer=%@&deviceId=%@&ts=%@&key=%@&phoneBrand=iPhone&osChannel=Appstore",[GVUserDefaults standardUserDefaults].hostName,ksumbit,[CTUUID getAppVersion],[CTUUID getIDFA],timeStap, [[NSString stringWithFormat:@"W9WLLhd45rX0J6%@%@",[CTUUID getIDFA],timeStap] do16MD5]]]];
    [request setHTTPMethod:@"POST"];
   
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [request addValue:[GVUserDefaults standardUserDefaults].accessToken forHTTPHeaderField:@"accessToken"];
    }
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:MHConfigServerVersion forHTTPHeaderField:@"version"];
    [request setHTTPBody:jsonData];
    return request;
}

@end
