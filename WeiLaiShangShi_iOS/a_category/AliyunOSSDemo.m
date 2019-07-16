//
//  oss_ios_demo.m
//  oss_ios_demo
//
//  Created by zhouzhuo on 9/16/15.
//  Copyright (c) 2015 zhouzhuo. All rights reserved.
//

#import "AliyunOSSDemo.h"
#import <AliyunOSSiOS/OSSService.h>

NSString * const endPoint = @"https://oss-cn-hangzhou.aliyuncs.com";

OSSClient * client;
static dispatch_queue_t queue4demo;

@implementation AliyunOSSDemo

+ (instancetype)sharedInstance {
    static AliyunOSSDemo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AliyunOSSDemo new];
    });
    return instance;
}

- (void)uploadObjectAsync:(NSData *)picData destinName:(NSString *)name withComplete:(urlBlock)complete {
    
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:@"LTAIslISBdY6KvpB" secretKeyId:@"VJe1EYChW00OFARPeLvvODgtnTei0W" securityToken:@""];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"hskd-user";
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*nowDate = [NSString stringWithFormat:@"%0.f", a];
    int num = (arc4random() % 10000);
    NSString *fileName = [NSString stringWithFormat:@"%@/%@%d.jpg",name, nowDate,num];
    put.objectKey =  fileName;
    NSString *picUrl  = [NSString stringWithFormat:@"http://hskd-user.oss-cn-hangzhou.aliyuncs.com/%@",fileName];
    put.uploadingData = picData;
    
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        //                NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
         
            OSSPutObjectResult *getResult = task.result;
            NSLog(@"%@",getResult.serverReturnJsonString);
            complete(picUrl,nil);
            //                    NSLog(@"success");
        } else {
            complete(nil,task.error);
            //                    NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}





@end
