//
//  MHUrlArgumentsFilter.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHUrlArgumentsFilter.h"
#import "AFURLRequestSerialization.h"
#import "CTUUID.h"
#import "NSString+WZXSSLTool.h"

@implementation MHUrlArgumentsFilter{
    NSDictionary *_arguments;
}

+ (MHUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *timeStap = [CTUUID getTimeStamp];
    [dict setValue:timeStap forKey:@"ts"];
    [dict setValue:[[NSString stringWithFormat:@"W9WLLhd45rX0J6%@%@",[CTUUID getIDFA],timeStap] do16MD5] forKey:@"key"];
    NSString *paraUrlString = AFQueryStringFromParameters(dict);
    
    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }
    
    BOOL useDummyUrl = NO;
    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];
    
    components.query = newQueryString;
    
    if (useDummyUrl) {
        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
    } else {
        return components.URL.absoluteString;
    }
}


@end
