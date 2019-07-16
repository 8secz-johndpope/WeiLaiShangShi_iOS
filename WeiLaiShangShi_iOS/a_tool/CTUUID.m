//
//  CTUUID.m
//  KuaiCheCaiFu
//
//  Created by AllenQin on 16/1/27.
//  Copyright © 2016年 ChangTian. All rights reserved.
//

#import "CTUUID.h"
#import <AdSupport/AdSupport.h>
#import <Foundation/Foundation.h>
#import "NSString+WZXSSLTool.h"


@implementation CTUUID


+ (NSString *)getIDFA{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}




+(NSString *)getAppVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getTimeStamp{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
    
}



+ (NSString *)getKey{
    //secret+salt+deviceId+timestamp
    NSString *saltKey = [NSString stringWithFormat:@"W9WLLhd45rX0J6%@%@",[self getIDFA],[self getTimeStamp]];
    return  [saltKey do16MD5];
}




@end
