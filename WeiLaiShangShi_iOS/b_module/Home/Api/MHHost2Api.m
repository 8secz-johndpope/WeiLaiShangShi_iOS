//
//  MHHost2Api.m
//  wgts
//
//  Created by AllenQin on 2018/11/14.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHHost2Api.h"
#import "CTUUID.h"

@implementation MHHost2Api

- (id)initWithHost2{
    self = [super init];
    if (self) {
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/rest/active/version",kMHHost2];
}


-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}

- (id)requestArgument {
    return @{ @"version": [CTUUID getAppVersion]};
}


@end
