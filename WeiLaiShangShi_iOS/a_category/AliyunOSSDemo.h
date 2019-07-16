//
//  oss_ios_demo.h
//  oss_ios_demo
//
//  Created by zhouzhuo on 9/16/15.
//  Copyright (c) 2015 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^urlBlock)(NSString *urlStr,NSError *error);

@interface AliyunOSSDemo : NSObject

+ (instancetype)sharedInstance;
- (void)uploadObjectAsync:(NSData *)picData destinName:(NSString *)name withComplete:(urlBlock)complete;


@end
