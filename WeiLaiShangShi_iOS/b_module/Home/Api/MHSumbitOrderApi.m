//
//  MHSumbitOrderApi.m
//  mohu
//
//  Created by AllenQin on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSumbitOrderApi.h"
#import "NSString+WZXSSLTool.h"
#import "CTUUID.h"

@implementation MHSumbitOrderApi{
    NSArray          *_prod;
}

-(instancetype)initWithDict:(NSArray *)prod{
    self = [super init];
    if (self) {
        _prod = prod;
    }
    return self;
}

-(NSURLRequest *)buildCustomUrlRequest{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:_prod forKey:@"products"];
    NSData*jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *timeStap = [CTUUID getTimeStamp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?appId=a2&appVer=%@&deviceId=%@&ts=%@&key=%@&phoneBrand=iPhone&osChannel=Appstore",[GVUserDefaults standardUserDefaults].hostName,kConfirm,[CTUUID getAppVersion],[CTUUID getIDFA],timeStap,[[NSString stringWithFormat:@"W9WLLhd45rX0J6%@%@",[CTUUID getIDFA],timeStap] do16MD5]]]];
    [request setHTTPMethod:@"POST"];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [request addValue:[GVUserDefaults standardUserDefaults].accessToken forHTTPHeaderField:@"accessToken"];
    }
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:MHConfigServerVersion forHTTPHeaderField:@"version"];
    [request setHTTPBody:jsonData];
    return request;
}


-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}
@end
