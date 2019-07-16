//
//  AppDelegate.m
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAppDelegate.h"
#import "MHAppDelegate+AppService.h"
#import "MHAppDelegate+PushService.h"
#import "CTUUID.h"
//微信支付
#import "WXApi.h"
#import "WXApiManager.h"
#import "HSBannerModel.h"


@interface MHAppDelegate ()

@end

@implementation MHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化window
    [self initWindow];
    //极光
    [self initJPushconfig:launchOptions];
    
    //初始化app服务
    [self initService];
    //UMeng初始化
    [self initThridPartConfig];
    
    
   
    
    
    [self initWeChatConfig];
    //微信支付
    [WXApi registerApp:MHConfigWeChatAPPID];
    
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [GVUserDefaults standardUserDefaults].ShowRedMoney = @"no" ;
    }else{
        [GVUserDefaults standardUserDefaults].ShowRedMoney = @"Yes" ;
    }
    [GVUserDefaults standardUserDefaults].firstPageSelect = @"YES";
    [GVUserDefaults standardUserDefaults].ShowYaoqingalert = @"NO";
    [GVUserDefaults standardUserDefaults].Showshenjialert = @"NO";
    [GVUserDefaults standardUserDefaults].isPrivacy = @"success";
    //数据初始化
     NSMutableArray *havealertArrold = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath1]];
    NSMutableArray *havealertArrnew = [NSMutableArray array];
   
    for (int i = 0; i < havealertArrold.count; i++) {
        HSBannerModel *model  = havealertArrold[i];
        if ([model.onlyPopUpOnce isEqualToString:@"1"]) {
            [havealertArrnew addObject:model];
        }
    }
   
    [NSKeyedArchiver archiveRootObject:havealertArrnew toFile:[self filePath1]];
 

//#ifdef DEBUG
//    [[DoraemonManager shareInstance] install];
//#endif
    
    
    //    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"fe747d6fd5594418696e9ddec6814593"];   // 请将 PGY_APP_ID 换成应用的 App Key
    //  [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
    //
    //

    return YES;
}

- (NSString *)filePath1
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Havealert.plist"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//     NSLog(@"---applicationDidBecomeActive--进入前台2 --");
//    [[NSNotificationCenter defaultCenter ]postNotificationName:@"applicationDidBecomeActive" object:nil];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//      NSLog(@"---applicationDidBecomeActive--进入前台1 --");
//     [[NSNotificationCenter defaultCenter ]postNotificationName:@"applicationDidBecomeActive" object:nil];
     //进入前台
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
