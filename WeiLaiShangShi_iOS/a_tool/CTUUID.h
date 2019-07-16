//
//  CTUUID.h
//  KuaiCheCaiFu
//
//  Created by AllenQin on 16/1/27.
//  Copyright © 2016年 ChangTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTUUID : NSObject

//IDFA
+(NSString *)getIDFA;

//OS Version
+(NSString *)getAppVersion;


+ (NSString *)getTimeStamp;

+ (NSString *)getKey;

@end
