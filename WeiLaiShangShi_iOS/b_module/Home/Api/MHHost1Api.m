//
//  MHHost1Api.m
//  wgts
//
//  Created by AllenQin on 2018/11/14.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHHost1Api.h"
#import "CTUUID.h"


@implementation MHHost1Api

- (id)initWithHost1{
    self = [super init];
    if (self) {
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl {
    return  [NSString stringWithFormat:@"%@/rest/active/version",[GVUserDefaults standardUserDefaults].hostName];
}


-(NSTimeInterval)requestTimeoutInterval{
    return 2;
}

- (id)requestArgument {
    return @{@"version": [CTUUID getAppVersion],@"osChannel": @"Appstore",@"os": @"IOS"};
}


@end
