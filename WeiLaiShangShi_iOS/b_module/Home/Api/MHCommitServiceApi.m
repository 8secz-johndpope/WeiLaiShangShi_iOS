//
//  MHCommitServiceApi.m
//  mohu
//
//  Created by AllenQin on 2018/10/16.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHCommitServiceApi.h"
#import "CTUUID.h"

@implementation MHCommitServiceApi{
    NSDictionary          *_prod;
}

-(instancetype)initWithDict:(NSDictionary *)prod{
    self = [super init];
    if (self) {
        _prod = prod;
    }
    return self;
}


-(NSURLRequest *)buildCustomUrlRequest{
    
    NSData*jsonData = [NSJSONSerialization dataWithJSONObject:_prod options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?appId=a2&appVer=%@&deviceId=%@&ts=%@&key=%@&phoneBrand=iPhone&osChannel=Appstore",[GVUserDefaults standardUserDefaults].hostName,kServiceList,[CTUUID getAppVersion],[CTUUID getIDFA],[CTUUID getTimeStamp],[CTUUID getKey]]]];
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
