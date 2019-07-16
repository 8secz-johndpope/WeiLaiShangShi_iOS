//
//  MHHost3Api.m
//  wgts
//
//  Created by AllenQin on 2018/11/22.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHHost3Api.h"
#import "CTUUID.h"

@implementation MHHost3Api

- (id)initWithHost3{
    self = [super init];
    if (self) {
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodHEAD;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/rest/active",kMHHost1];
}


-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}

- (id)requestArgument {
    return @{ @"version": [CTUUID getAppVersion]};
}


@end
