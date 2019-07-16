//
//  MHAppDelegate+PushService.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAppDelegate.h"
#import "JPUSHService.h"

@interface MHAppDelegate (PushService)<JPUSHRegisterDelegate>

-(void)initJPushconfig:(NSDictionary *)launchOptions;

@end
