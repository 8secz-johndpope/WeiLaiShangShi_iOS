//
//  MHBaseRequest.h
//  mohu
//
//  Created by AllenQin on 2018/8/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface MHBaseRequest : YTKRequest

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary;

- (instancetype)initWithUrl:(NSString *)url
                baseRequest:(YTKRequestMethod )method
                    isCache:(BOOL)isCache
                  withParam:(id )dict;
- (instancetype)initWithUrl:(NSString *)url
                baseRequest:(YTKRequestMethod )method
                    isCache:(BOOL)isCache
                  withParam:(id )dict
                    Version:(NSString *)version;


- (void)startWithRefreshCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                                           failure:(YTKRequestCompletionBlock)failure;



@end
