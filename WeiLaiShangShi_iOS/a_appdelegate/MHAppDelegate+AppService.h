//
//  MHAppDelegate+AppService.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAppDelegate.h"
#import "XHLaunchAd.h"


@interface MHAppDelegate (AppService)<UITabBarControllerDelegate,XHLaunchAdDelegate>

//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//初始化第三方账号
-(void)initThridPartConfig;

-(void)initWeChatConfig;


//tabbar 根视图
-(void)initTabbarRootViewController;

//登录
-(void)initLoginRootViewController;

//引导图
-(void)createRootSrollViewController;

- (void)validRootViewController;


//单例
+ (MHAppDelegate *)shareAppDelegate;

@end
