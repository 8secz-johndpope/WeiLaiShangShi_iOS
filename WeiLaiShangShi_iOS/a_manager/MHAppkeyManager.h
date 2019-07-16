//
//  MHAppkeyManager.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHAppkeyManager : NSObject

//友盟 key
extern NSString *const MHConfigJPushKey;

//渠道
extern NSString *const MHConfigChannel;

//微信分享appid
extern NSString *const MHConfigWeChatAPPID;

//微信分享app secret
extern NSString *const MHConfigWeChatAPPSecret;

//支付宝appid
extern NSString *const MHConfigAlipayAPPID;

//bugly分享app key
extern NSString *const MHConfigBuglyAPPKey;

//
extern NSString *const MHConfigUmengAPPKey;

extern NSString *const MHConfigServerVersion;


extern NSString *const MHConfigQQAPPID;

extern NSString *const MHConfigQQAPPSecret;


extern NSString *const MHConfigSinaAPPID;

extern NSString *const MHConfigSinaAPPSecret;



@end
