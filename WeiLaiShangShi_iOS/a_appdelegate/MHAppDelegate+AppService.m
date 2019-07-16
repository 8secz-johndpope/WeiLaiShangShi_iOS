//
//  MHAppDelegate+AppService.m
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAppDelegate+AppService.h"
#import "MHHomeViewController.h"
#import "YTKNetworkConfig.h"
#import "AvoidCrash.h"
#import <Bugly/Bugly.h>
#import <UMShare/UMShare.h>
#import "CTUUID.h"
#import "MHTabbarManager.h"
#import "MHLoginViewController.h"
#import "MHUrlArgumentsFilter.h"
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "UIImage+Common.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MHPayClass.h"
#import "MHLauchImageModel.h"
#import "MHWebviewViewController.h"
#import "MHProdetailViewController.h"
#import "MHScrollViewController.h"
#import "MHLauchImageVC.h"
#import "MHBaseClass.h"
#import "HSPlusButton.h"
#import "HSTaskDetailViewViewController.h"
#import "HSTaskShareViewController.h"
@implementation MHAppDelegate (AppService)

-(void)initService{
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
    [self monitorNetworkStatus];
}

-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    
    //去除nav下面线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
   
}


-(void)initThridPartConfig{
    
    [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert =@"Yes";
    [GVUserDefaults standardUserDefaults].ShowAppUpdateWithCode = @"Yes";
    [GVUserDefaults standardUserDefaults].ShowBreakStatuWithCode = @"Yes";
    [Bugly startWithAppId:MHConfigBuglyAPPKey];
    [UMConfigure initWithAppkey:MHConfigUmengAPPKey channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_NORMAL];
    //网络初始化
    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    MHUrlArgumentsFilter *urlFilter = [MHUrlArgumentsFilter filterWithArguments:@{@"appId": @"a2",@"appVer":[CTUUID getAppVersion],@"deviceId":[CTUUID getIDFA],@"phoneBrand":@"iPhone",@"osChannel":@"Appstore"}];
    [networkConfig addUrlFilter:urlFilter];
    [AvoidCrash becomeEffective];
   
    //设置启动图为根视图
    MHLauchImageVC  *lauchImageView = [[MHLauchImageVC alloc] init];
    [self.window setRootViewController:lauchImageView];
    [self.window makeKeyAndVisible];
    // 动态切换域名
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rereshApi:) name:KNotificationRereshApi object:nil];
    
    [[MHUserService sharedInstance]initwithHost3completionBlock:^(NSDictionary *response, NSError *error) {
        
        if (error) {
            //host3 读取上次
            [[MHUserService sharedInstance]initwithHost4completionBlock:^(NSDictionary *response, NSError *error) {
                [MBProgressHUD hideHUD];
                if (error) {
                    if ([GVUserDefaults standardUserDefaults].hostName  == nil) {
                        networkConfig.baseUrl = kMHHost1;
                        [GVUserDefaults standardUserDefaults].hostName = kMHHost1;
                        [GVUserDefaults standardUserDefaults].hostWapName = kMHHostWap1;
                    }else{
                        networkConfig.baseUrl = [GVUserDefaults standardUserDefaults].hostName;
                    }
                    [self shengheRootVC];
                }else{
                    networkConfig.baseUrl = kMHHost2;
                    [GVUserDefaults standardUserDefaults].hostName = kMHHost2;
                    [GVUserDefaults standardUserDefaults].hostWapName = kMHHostWap2;
                    [self shengheRootVC];
                }
            }];
        }else{
            [MBProgressHUD hideHUD];
            networkConfig.baseUrl = kMHHost1;
            [GVUserDefaults standardUserDefaults].hostName = kMHHost1;
            [GVUserDefaults standardUserDefaults].hostWapName = kMHHostWap1;
            [self shengheRootVC];
        }
    }];
}

-(void)rereshApi:(NSNotification *)noti{
    
    
    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    
    if ([[MHBaseClass sharedInstance] isErrorNetWork] == 0) {
        if ([kMHHost1 rangeOfString:noti.userInfo[@"hostUrl"]].location !=NSNotFound) {
            networkConfig.baseUrl = kMHHost2;
            [GVUserDefaults standardUserDefaults].hostName = kMHHost2;
            [GVUserDefaults standardUserDefaults].hostWapName = kMHHostWap2;
        }else{
            networkConfig.baseUrl = kMHHost1;
            [GVUserDefaults standardUserDefaults].hostName = kMHHost1;
            [GVUserDefaults standardUserDefaults].hostWapName = kMHHostWap1;
        }
    }
}


-(void)shengheRootVC{
    
    [GVUserDefaults standardUserDefaults].shenghe = @"YES";
    [self openRootVC];
    
    //获取银行卡列表 、地区列表
    [[MHUserService sharedInstance]initwithBankListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [GVUserDefaults standardUserDefaults].bankCode = response[@"data"];
        }
    }];
    
    [[MHUserService sharedInstance]initwithCityListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [GVUserDefaults standardUserDefaults].areaList = response[@"data"];
        }
    }];
    
//
//    if ([GVUserDefaults standardUserDefaults].shenghe == nil) {
//        [[MHUserService sharedInstance]initwithHost1completionBlock:^(NSDictionary *response, NSError *error) {
//            if (error) {
//                //shengheNO
//                [GVUserDefaults standardUserDefaults].shenghe = nil;
//                [self openRootVC];
//            }else{
//                NSInteger data =  [response[@"data"] integerValue];
//                if (data == 1) {
//                    //shengheNO
//                    [GVUserDefaults standardUserDefaults].shenghe = nil;
//                    [self openRootVC];
//                }else{
//                    //shengheYES
//                    [GVUserDefaults standardUserDefaults].shenghe = @"YES";
//                    [self openRootVC];
//                }
//            }
//        }];
//    }else{
//        //shengheOK
//        [self openRootVC];
//    }
}



-(void)openRootVC{
    [self validRootViewController];
   
    [[MHUserService sharedInstance]initWithOS:@"IOS" channel:@"Appstore" version:[CTUUID getAppVersion] completionBlock:^(NSDictionary *response, NSError *error) {
        
        
    }];
    
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                [GVUserDefaults standardUserDefaults].phone = [[response objectForKey:@"data"]objectForKey:@"phone"];
                [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                if ([response[@"data"][@"expand"] integerValue]== 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
                }
            }
        }];
    }
}


- (void)validRootViewController{
    NSInteger guideInter  =[[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@guide",[CTUUID getAppVersion]]] length];
    if (guideInter) {
        //设置根视图
        [self initTabbarRootViewController];
    }else{
        [self createRootSrollViewController];
    }
}


+ (MHAppDelegate *)shareAppDelegate{
    return (MHAppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)setupLauchAD{
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    [XHLaunchAd setWaitDataDuration:2];
    [[MHUserService sharedInstance]initLaunchADWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (ValidDict(response[@"data"])) {
                MHLauchImageModel *model = [MHLauchImageModel baseModelWithDic:response[@"data"]];
                XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
                imageAdconfiguration.duration = 5;
                imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.window.bounds.size.height);
                if (isiPhoneX) {
                    imageAdconfiguration.imageNameOrURLString = model.bigImg;
                }else{
                     imageAdconfiguration.imageNameOrURLString = model.normalImg;
                }
                imageAdconfiguration.GIFImageCycleOnce = NO;
                imageAdconfiguration.openModel = model;
                imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
                imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
                imageAdconfiguration.showFinishAnimateTime = 0.8;
                imageAdconfiguration.skipButtonType = SkipTypeTimeText;
                imageAdconfiguration.showEnterForeground = NO;
                [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
            }
        }
    }];
}


- (void)createRootSrollViewController{
    
    __block  MHScrollViewController *scrollVC  = [[MHScrollViewController alloc]init];
    scrollVC.goHomeBlock  =^(){
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:[NSString stringWithFormat:@"%@guide",[CTUUID getAppVersion]]];
        scrollVC = nil;
        [self initNoHavenLauchAdRoot];
//        if ([GVUserDefaults standardUserDefaults].accessToken == nil) {
//            if ([GVUserDefaults standardUserDefaults].isPrivacy) {
//                MHLoginViewController *login = [[MHLoginViewController alloc] init];
//                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
//                UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
//                [tabBarController.selectedViewController presentViewController:userNav animated:YES completion:nil];
//                
//            }
//        }
    };
    [self.window setRootViewController:scrollVC];
    [self.window makeKeyAndVisible];
}



-(void)initNoHavenLauchAdRoot{
    //根视图
    if ([GVUserDefaults standardUserDefaults].shenghe) {
//        [HSPlusButton registerPlusButton];
    }
    MHTabbarManager *tabBarControllerConfig = [[MHTabbarManager alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    [self.window setRootViewController:tabBarController];
    tabBarController.delegate = self;
    
}

-(void)initWeChatConfig{
    
#pragma mark  umeng share
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:MHConfigWeChatAPPID appSecret:MHConfigWeChatAPPSecret redirectURL:@"http://www.hooshao.com"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:MHConfigQQAPPID appSecret:MHConfigQQAPPSecret redirectURL:@"http://www.hooshao.com"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:MHConfigSinaAPPID  appSecret:MHConfigSinaAPPSecret redirectURL:@"http://www.hooshao.com"];
}



-(void)initTabbarRootViewController{
    //开屏广告
    [self setupLauchAD];

    //根视图
    if ([GVUserDefaults standardUserDefaults].shenghe) {
//           [HSPlusButton registerPlusButton];
    }

    MHTabbarManager *tabBarControllerConfig = [[MHTabbarManager alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    [self.window setRootViewController:tabBarController];
    tabBarController.delegate = self;

}


- (void)initLoginRootViewController{
    MHLoginViewController *logoVC = [[MHLoginViewController alloc]init];
    UINavigationController *logoNav = [[UINavigationController alloc]initWithRootViewController:logoVC];
    [self.window setRootViewController:logoNav];
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        [[MHPayClass sharedApi]handleOpenURL:url];
    }
    return result;
    
}





#pragma  mark -- UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    


    


    if (ValidStr([GVUserDefaults standardUserDefaults].shenghe)) {
        [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
        
        if (tabBarController.viewControllers[0] == viewController) {
            MHLog(@"刷新");
            if (   [[GVUserDefaults standardUserDefaults].firstPageSelect isEqualToString:@"YES"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshPAGEONE1 object:nil userInfo:nil];
            }
            [GVUserDefaults standardUserDefaults].firstPageSelect = @"YES";

           
        }else{
              [GVUserDefaults standardUserDefaults].firstPageSelect = @"NO";
        }
        if (tabBarController.viewControllers[3] == viewController|| tabBarController.viewControllers[2] == viewController) {
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                return YES;
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [tabBarController.selectedViewController presentViewController:userNav animated:YES completion:nil];
                return NO;
            }
        }else

            return YES;
    }else{
        
        if (tabBarController.viewControllers[0] == viewController) {
            MHLog(@"刷新");
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshPAGEONE object:nil userInfo:nil];
        }
        if (tabBarController.viewControllers[3] == viewController|| tabBarController.viewControllers[2] == viewController){
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                return YES;
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [tabBarController.selectedViewController presentViewController:userNav animated:YES completion:nil];
                return NO;
            }
        }else
            return YES;
    }

}

- (void)monitorNetworkStatus{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
        }
    }];
     [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification{
    
    BOOL isNetWork = [notification.object boolValue];
    if (!isNetWork) {
        KLToast(@"网络状态不佳");
    }
}


-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    MHLog(@"广告点击事件");
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel == nil)  return;
        MHLauchImageModel *model  = openModel;
    
        UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
        UINavigationController *rootVC = tabBarController.selectedViewController;
        if (model.actionUrlType == 0) {
            //web
            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.actionUrl comefrom:@"LauchImage"];
            [rootVC pushViewController:vc animated:YES];
        }else{
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[model.actionUrl dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

                if ([dict[@"code"] integerValue] == 5) {
                    //产品详情
                    if ([dict[@"property"] isEqualToString:@"REVIEW"]) {
                        //审核任务
                        HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                        vc.taskId = [NSString stringWithFormat:@"%@",dict[@"param"]];
                        [rootVC pushViewController:vc animated:YES];
                    }else if ([dict[@"property"] isEqualToString:@"SHARE"]) {
                        //分享任务
                        
                        HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                        vc.taskId = [NSString stringWithFormat:@"%@",dict[@"param"]];
                        if ([dict[@"detailType"] isEqualToString:@"VIDEO"]) {
                            vc.IsshowTop = YES;
                            
                        }else{
                            vc.IsshowTop = NO;
                        }
                        [rootVC pushViewController:vc animated:YES];
                        
                    }else if ([dict[@"property"] isEqualToString:@"DOWNLOAD"]) {
                        //下载任务
                        HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                        vc.taskId = [NSString stringWithFormat:@"%@",dict[@"param"]];
                        if ([dict[@"detailType"] isEqualToString:@"VIDEO"]) {
                            vc.IsshowTop = YES;
                            
                        }else{
                            vc.IsshowTop = NO;
                        }
                        [rootVC pushViewController:vc animated:YES];
                        
                    }else if ([dict[@"property"] isEqualToString:@"READ"]) {
                        //阅读广告任务
                        //下载任务
                        HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                        vc.taskId = [NSString stringWithFormat:@"%@",dict[@"param"]];
                        if ([dict[@"detailType"] isEqualToString:@"VIDEO"]) {
                            vc.IsshowTop = YES;
                            
                        }else{
                            vc.IsshowTop = NO;
                        }
                        [rootVC pushViewController:vc animated:YES];
                        
                    }
                    
                }
        }
}




@end
