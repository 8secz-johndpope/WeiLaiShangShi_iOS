//
//  MHRefreshApi.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHRefreshApi.h"

@implementation MHRefreshApi

-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/%@",krefreshUrl,[GVUserDefaults standardUserDefaults].refreshToken];
}


#pragma mark ————— 非加密时也要传输的头部内容 也可能不需要，暂时保留 —————
-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    
    NSMutableDictionary *baseDic = [NSMutableDictionary dictionary];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [baseDic setObject:[GVUserDefaults standardUserDefaults].accessToken forKey:@"accessToken"];
    }
    [baseDic setObject:MHConfigServerVersion forKey:@"version"];
    return baseDic;
}


@end
