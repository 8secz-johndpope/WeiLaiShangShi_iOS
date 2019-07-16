//
//  MHHost4Api.m
//  wgts
//
//  Created by AllenQin on 2018/11/28.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHHost4Api.h"
#import "CTUUID.h"

@implementation MHHost4Api

- (id)initWithHost4{
    self = [super init];
    if (self) {
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodHEAD;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/rest/active",kMHHost2];
}

- (id)requestArgument {
    return @{ @"version": [CTUUID getAppVersion]};
}


-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}

@end
