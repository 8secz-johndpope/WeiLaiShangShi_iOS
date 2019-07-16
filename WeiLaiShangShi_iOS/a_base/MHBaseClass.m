//
//  MHBaseClass.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseClass.h"
#import "SDImageCache.h"
#import "Reachability.h"
#import <WebKit/WebKit.h>
#import <JPUSHService.h>
#import "UIControl+BlocksKit.h"
#import "MHWebviewViewController.h"
#import "HSBannerModel.h"
#import "UIGestureRecognizer+BlocksKit.h"
#import "RichStyleLabel.h"
#import "HSMyWalletController.h"
#import "MHLoginViewController.h"
@implementation MHBaseClass

+ (MHBaseClass *)sharedInstance{
    static MHBaseClass *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}


//退出登录
-(void)loginOut{
    

    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:1];
    [GVUserDefaults standardUserDefaults].ShowRedMoney =@"no";
    [GVUserDefaults standardUserDefaults].accessToken = nil;
    [GVUserDefaults standardUserDefaults].refreshToken = nil;
    [GVUserDefaults standardUserDefaults].userRole = nil;
    [GVUserDefaults standardUserDefaults].phone = nil;
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
    }
}


- (void)removeAppCatch{
    //清理图片缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    
    //    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    //    [cache.memoryCache removeAllObjects];
    //    [cache.diskCache removeAllObjects];
    //清理webview cookie
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}
-(void)presentAlertWithtitle:(NSString *)title message:(NSString *)message leftbutton:(NSString *)leftbutton rightbutton:(NSString *)rightbutton leftAct:(void(^)(void))leftAction rightAct:(void(^)(void))rightAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftbutton style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        leftAction();
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:rightbutton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        rightAction();
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    //显示弹出框
    
    [ [self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
    
    
}
-(UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}
-(UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}


-(NSUInteger)isErrorNetWork{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSUInteger net = 0;
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = 0;
            break;
        case ReachableViaWWAN:
            net = 0;
            break;
        case NotReachable:
            net = 1;
        default:
            break;
            
    }
    return net;
}


-(NSString *)createParamUrl:(NSString *)url param:(NSDictionary *)dict{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];

    if ([url rangeOfString:@"?"].location !=NSNotFound) {
    //&
          return [NSString stringWithFormat:@"%@&params=%@",url,[data base64EncodedStringWithOptions:0]];
        
    }else{
    //?
        return [NSString stringWithFormat:@"%@?params=%@",url,[data base64EncodedStringWithOptions:0]];
    }
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString *)title
                              desc:(NSString *)desc
                          shareUrl:(NSString *)shareUrl
             currentViewController:(UIViewController *)currentViewController
                           success:(void (^)(void))success
                              fail:(void (^)(void))fail{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:[UIImage imageNamed:@"logo1"]];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            fail();
        }else{
            NSLog(@"response data is %@",data);
            success();
        }
    }];
}
-(void)Imgtap
{
    NSMutableArray *alertArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    HSBannerModel *model = [alertArr2 objectAtIndex:0];
    if ([model.contentType isEqualToString:@"H5_LINK"]) {
        
        if (!klStringisEmpty(model.content)) {
            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.content comefrom:@"home"];
            [[self currentNC] pushViewController:vc animated:YES];
        }
        
    }else{
        
        [[MHUserService sharedInstance]initWithHSNoticeDetailId:model.id CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithhtmlstring:response[@"data"][@"content"] comefrom:@"gonggao"];
                [[self currentNC] pushViewController:vc animated:YES];
            }
        }];
    }
    
}
-(void)Imgtap1
{
    MHLoginViewController *login = [[MHLoginViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
    [[self getCurrentVC] presentViewController:userNav animated:YES completion:nil];
    
    if (![GVUserDefaults standardUserDefaults].accessToken) {
        [self closeAct2];
    }else{
       [self closeAct];
    }
   
}


// 活动公告
-(void)presentActAltertWithtitle:(NSString *)title content:(NSString *)content backgroudImg:(NSString *)backgroudImg contentType:(NSString *)contentType closeImg:(NSString *)closeImg action_url:(NSString *)action_url type:(NSString *)type alertid:(NSString *)alertid
{
    NSMutableArray *alertArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    HSBannerModel *model = [alertArr2 objectAtIndex:0];
    // 存储 展示过的
    model.statu = @"ACTIVE";
     [NSKeyedArchiver archiveRootObject:alertArr2 toFile:[self filePath]];
    
    NSMutableArray *havealertArrold = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath1]];
    if (havealertArrold.count > 0) {
        //原来就有数据 如果有相同就改状态 没有就加

        BOOL have = YES;
        for (int i = 0; i < havealertArrold.count ; i++) {

            HSBannerModel *havemodel  = havealertArrold[i];
            if ([havemodel.id isEqualToString: model.id]) {

                havemodel.statu = @"ACTIVE";
                have = YES;
                break;

            }else{
                have = NO;
            }
        }
        if (have == NO) {
            model.statu = @"ACTIVE";
            [havealertArrold addObject:model];
        }


        [NSKeyedArchiver archiveRootObject:havealertArrold toFile:[self filePath1]];
    }else{
        NSMutableArray *havealertArr = [NSMutableArray array];
          model.statu = @"ACTIVE";
        [havealertArr addObject:model];
        [NSKeyedArchiver archiveRootObject:havealertArr toFile:[self filePath1]];
    }
     self.linkurl  =action_url;
    if ([type isEqualToString:@"ACTIVITY"]) {
        UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgview.backgroundColor = KClearColor;
        
        self.imge3 = [[UIImageView alloc]init];
        self.imge3.userInteractionEnabled = YES;
        self.imge3.image = kGetImage(@"red2");
        self.imge3.hidden =YES;
        [bgview addSubview:self.imge3];
        [self.imge3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgview.mas_centerX).offset(0);
            make.centerY.equalTo(bgview.mas_centerY).offset(0);
            make.width.mas_equalTo(kRealValue(342));
            make.height.mas_equalTo(kRealValue(403));
        }];
        
        
        self.imge1 = [[UIImageView alloc]init];
        self.imge1.userInteractionEnabled = YES;
        [self.imge1 sd_setImageWithURL:[NSURL URLWithString:backgroudImg]];
        //    self.imge1.frame= CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        [bgview addSubview:self.imge1];
        [self.imge1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgview.mas_centerX).offset(0);
            make.centerY.equalTo(bgview.mas_centerY).offset(0);
            make.width.mas_equalTo(kRealValue(342));
            make.height.mas_equalTo(kRealValue(403));
        }];
        UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Imgtap)];
        [self.imge1 addGestureRecognizer:Img3tap];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imge1.mas_bottom).offset(kRealValue(10));
            make.centerX.mas_equalTo(self.imge1.mas_centerX).offset(kRealValue(0));
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
        // 3.2 显示时背景的透明度
        self.popView.popBGAlpha = 0.5f;
        // 3.3 显示时是否监听屏幕旋转
        self.popView.isObserverOrientationChange = YES;
        // 3.4 显示时动画时长
        self.popView.popAnimationDuration = 0.5f;
        // 3.5 移除时动画时长
        self.popView.dismissAnimationDuration = 0.3f;
        
        // 3.6 显示完成回调
        self.popView.popComplete = ^{
            MHLog(@"显示完成");
        };
        // 3.7 移除完成回调
        self.popView.dismissComplete = ^{
            MHLog(@"移除完成");
        };
        [self.popView pop];
    }
    if ([type isEqualToString:@"APP_UPDATE_NON_FORCE"]) {
        //非强制更新
        
        UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        contentViews.backgroundColor = [UIColor clearColor];
        
        UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(150), kRealValue(300), kRealValue(385))];
        forceUpdateImg.userInteractionEnabled = YES;
        forceUpdateImg.image = [UIImage imageNamed:@"home_update_bg"];
        [contentViews addSubview:forceUpdateImg];
        forceUpdateImg.centerX = contentViews.centerX;
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.text = @"升级到新版本";
        leftLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        leftLabel.font = [UIFont systemFontOfSize:kFontValue(20)];
        [forceUpdateImg addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(140));
            make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
        }];
        
        
        UIScrollView * updateScr = [[UIScrollView alloc]init];
        [contentViews addSubview:updateScr];
        [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
            make.right.equalTo(forceUpdateImg.mas_right).offset(kRealValue(-25));
            make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(170));
            make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(kRealValue(-82));
            
        }];
        UIView *updateContentView = [[UIView alloc]init];
        [updateScr addSubview:updateContentView];
        [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(updateScr);
            make.width.equalTo(updateScr);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithHexString:@"#444444"];
//        NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
        label.text = title;
        label.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [updateContentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(updateContentView.mas_top);
            make.left.equalTo(@0);
            make.width.equalTo(updateContentView.mas_width);
            
        }];
        
        [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_bottom);
        }];
        
        UIButton *update_btn = [[UIButton alloc] init];
        [update_btn setTitle:@"立即升级" forState:UIControlStateNormal];
        update_btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        [update_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
        [update_btn bk_addEventHandler:^(id sender) {
            //更新按钮
            [self.popView dismiss];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:content]];
        } forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(update_btn, kRealValue(5));
        [forceUpdateImg addSubview:update_btn];
        [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
            make.centerX.equalTo(forceUpdateImg.mas_centerX);
            make.width.mas_equalTo(kRealValue(220));
            make.height.mas_equalTo(kRealValue(35));
        }];
        
        self.popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
        // 3.2 显示时背景的透明度
        self.popView.popBGAlpha = 0.5f;
        // 3.3 显示时是否监听屏幕旋转
        self.popView.isObserverOrientationChange = YES;
        // 3.4 显示时动画时长
        self.popView.popAnimationDuration = 0.5f;
        // 3.5 移除时动画时长
        self.popView.dismissAnimationDuration = 0.3f;
        
        // 3.6 显示完成回调
        self.popView.popComplete = ^{
            MHLog(@"显示完成");
        };
        // 3.7 移除完成回调
        self.popView.dismissComplete = ^{
            MHLog(@"移除完成");
        };
        [self.popView pop];
        
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
         [closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];;
        [contentViews addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
            make.right.mas_equalTo(forceUpdateImg.mas_right);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    if ([type isEqualToString:@"RED_ENVELOPE"]||[type isEqualToString:@"RED_ENVELOPE_UNLOGIN"]) {
        
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            
      
        UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgview.backgroundColor = KClearColor;
        
        self.imge3 = [[UIImageView alloc]init];
        self.imge3.userInteractionEnabled = YES;
        self.imge3.image = kGetImage(@"red2");
        self.imge3.hidden =YES;
        [bgview addSubview:self.imge3];
        [self.imge3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgview.mas_centerX).offset(0);
            make.centerY.equalTo(bgview.mas_centerY).offset(0);
            make.width.mas_equalTo(kRealValue(342));
            make.height.mas_equalTo(kRealValue(403));
        }];
        
      
        self.imge1 = [[UIImageView alloc]init];
        self.imge1.userInteractionEnabled = YES;
        self.imge1.image = kGetImage(@"red");
        //    self.imge1.frame= CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        [bgview addSubview:self.imge1];
        [self.imge1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgview.mas_centerX).offset(0);
            make.centerY.equalTo(bgview.mas_centerY).offset(0);
            make.width.mas_equalTo(kRealValue(342));
            make.height.mas_equalTo(kRealValue(403));
        }];
        UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Imgtap1)];
        [self.imge1 addGestureRecognizer:Img3tap];
        
//        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
//        [closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
//        [bgview addSubview:closeBtn];
//        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imge1.mas_bottom).offset(kRealValue(10));
//            make.centerX.mas_equalTo(self.imge1.mas_centerX).offset(kRealValue(0));
//            make.size.mas_equalTo(CGSizeMake(25, 25));
//        }];
     
        self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
        // 3.2 显示时背景的透明度
        self.popView.popBGAlpha = 0.5f;
        // 3.3 显示时是否监听屏幕旋转
        self.popView.isObserverOrientationChange = YES;
        // 3.4 显示时动画时长
        self.popView.popAnimationDuration = 0.5f;
        // 3.5 移除时动画时长
        self.popView.dismissAnimationDuration = 0.3f;
        
        // 3.6 显示完成回调
        self.popView.popComplete = ^{
            MHLog(@"显示完成");
        };
        // 3.7 移除完成回调
        self.popView.dismissComplete = ^{
            MHLog(@"移除完成");
        };
        [self.popView pop];
        }else{
            //登录
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(375), kRealValue(450))];
            bgView.backgroundColor = [UIColor clearColor];
            
            UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(4), kRealValue(10), kRealValue(361), kRealValue(430))];
            headView.userInteractionEnabled = YES;
            headView.image = kGetImage(@"icon_redpackage_open");
            [bgView addSubview:headView];
            
            
            UIImageView *headView1 = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(4), kRealValue(10), kRealValue(361), kRealValue(430))];
            headView1.userInteractionEnabled = YES;
            headView1.image = kGetImage(@"icon_redpackage_close");
            
            
            self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            self.popView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            self.popView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            self.popView.popAnimationDuration = 0.5f;
            // 3.5 移除时动画时长
            self.popView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            self.popView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            self.popView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [self.popView pop];
            
            UITapGestureRecognizer *cleosetap = [[UITapGestureRecognizer  alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                [MBProgressHUD showActivityMessageInWindow:@""];
                [[MHUserService sharedInstance]initwithHSWithRedPackageCompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        [MBProgressHUD hideHUD];
                        [headView removeAllSubviews];
                        [bgView addSubview:headView1];
                        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(50), kRealValue(361), kRealValue(20))];
                        textLabel.textAlignment = NSTextAlignmentCenter;
                        textLabel.textColor = [UIColor colorWithHexString:@"#E42936"];
                        textLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(18)];
                        textLabel.text = @"  恭喜您获得红包";
                        [headView1 addSubview:textLabel];
                        
                        RichStyleLabel *priceLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(0, kRealValue(70), kRealValue(361), kRealValue(80))];
                        priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
                        priceLabel.textColor =[UIColor colorWithHexString:@"#DA2529"];
                        priceLabel.textAlignment = NSTextAlignmentCenter;
                        [headView1 addSubview:priceLabel];
                        
                        [priceLabel setAttributedText:[NSString stringWithFormat:@"  %@火币",response[@"data"]] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#DA2529"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(60)]}];
                        
                        UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(150), kRealValue(361), kRealValue(20))];
                        textLabel1.textAlignment = NSTextAlignmentCenter;
                        textLabel1.textColor = [UIColor colorWithHexString:@"#999999"];
                        textLabel1.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(12)];
                        textLabel1.text = @"  红包已到账";
                        [headView1 addSubview:textLabel1];
                        
                        //
                        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(180), kRealValue(410),kRealValue(24), kRealValue(24))];
                        [btn setBackgroundImage:kGetImage(@"x") forState:0];
                        [bgView addSubview:btn];
                        [btn bk_addEventHandler:^(id sender) {
                            [self.popView dismiss];
                        } forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }];
            }];
            
            [headView addGestureRecognizer:cleosetap];
            
            
            
            
            UITapGestureRecognizer *closetap = [[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                [self.popView dismiss];
                
              
                [[self currentNC].tabBarController setSelectedIndex:2];
            }];
            [headView1 addGestureRecognizer:closetap];
            
            
        }
        
    }
    if ([type isEqualToString:@"ORDINARY"]) {
        if ([contentType isEqualToString:@"IMG"] ||[contentType isEqualToString:@"H5"] ) {
            UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            bgview.backgroundColor = KClearColor;
            
            self.imge3 = [[UIImageView alloc]init];
            self.imge3.userInteractionEnabled = YES;
            self.imge3.image = kGetImage(@"red2");
            self.imge3.hidden =YES;
            [bgview addSubview:self.imge3];
            [self.imge3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bgview.mas_centerX).offset(0);
                make.centerY.equalTo(bgview.mas_centerY).offset(0);
                make.width.mas_equalTo(kRealValue(342));
                make.height.mas_equalTo(kRealValue(403));
            }];
            
            
            self.imge1 = [[UIImageView alloc]init];
            self.imge1.userInteractionEnabled = YES;
            [self.imge1 sd_setImageWithURL:[NSURL URLWithString:backgroudImg]];
            //    self.imge1.frame= CGRectMake(0, 0, kScreenWidth, kScreenWidth);
            [bgview addSubview:self.imge1];
            [self.imge1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bgview.mas_centerX).offset(0);
                make.centerY.equalTo(bgview.mas_centerY).offset(0);
                make.width.mas_equalTo(kRealValue(342));
                make.height.mas_equalTo(kRealValue(403));
            }];
            UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Imgtap)];
            [self.imge1 addGestureRecognizer:Img3tap];
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imge1.mas_bottom).offset(kRealValue(10));
                make.centerX.mas_equalTo(self.imge1.mas_centerX).offset(kRealValue(0));
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
            self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            self.popView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            self.popView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            self.popView.popAnimationDuration = 0.5f;
            // 3.5 移除时动画时长
            self.popView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            self.popView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            self.popView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [self.popView pop];
        }else{
            UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            bgview.backgroundColor = KClearColor;
            
            
            
            
            UIView *bgview1 = [[UIView alloc]init];
             bgview1.userInteractionEnabled = YES;
            bgview1.backgroundColor = KColorFromRGB(0xFFFFFF);
            [bgview addSubview:bgview1];
            [bgview1 mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.centerX.equalTo(bgview.mas_centerX).offset(0);
                 make.centerY.equalTo(bgview.mas_centerY).offset(0);
                make.width.mas_equalTo(kRealValue(310));
                make.height.mas_equalTo([backgroudImg heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)] width:kRealValue(266)] + kRealValue(100));
            }];
            bgview1.layer.masksToBounds = YES;
            bgview1.layer.cornerRadius = kRealValue(8);
            
            UILabel *titlelab = [[UILabel alloc]init];
            [bgview1 addSubview:titlelab];
            titlelab.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
            titlelab.text = title;
            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgview1.mas_top).offset(kRealValue(15));
                make.centerX.equalTo(bgview1.mas_centerX).offset(0);
                 make.height.mas_equalTo(kRealValue(20));
                
            }];
            
            UILabel *titlelab1 = [[UILabel alloc]init];
            [bgview1 addSubview:titlelab1];
            titlelab1.text = backgroudImg;
            titlelab1.numberOfLines = 0;
            titlelab1.textAlignment = NSTextAlignmentLeft;
            titlelab1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    
            [titlelab1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titlelab.mas_bottom).offset(kRealValue(15));
                make.centerX.equalTo(bgview1.mas_centerX).offset(0);
                make.left.equalTo(bgview1.mas_left).offset(20);
                make.right.equalTo(bgview1.mas_right).offset(-20);
            }];
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = KColorFromRGB(0xEFEFEF);
            [bgview1 addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgview1.mas_bottom).offset(-kRealValue(44));
                make.right.mas_equalTo(bgview1.mas_right).offset(0);
                make.left.mas_equalTo(bgview1.mas_left).offset(0);
                make.height.mas_equalTo(1/kScreenScale);
                
            }];
            
            
            UILabel *chakan = [[UILabel alloc]init];
            [bgview1 addSubview:chakan];
            chakan.userInteractionEnabled = YES;
            chakan.text = @"立即查看";
            chakan.textAlignment = NSTextAlignmentCenter;
            chakan.textColor = KColorFromRGB(0xFC7013);
            chakan.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
            
            [chakan mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.equalTo(bgview1.mas_bottom).offset(-kRealValue(43));
                make.centerX.equalTo(bgview1.mas_centerX).offset(0);
                make.width.mas_equalTo(kRealValue(310));
                make.height.mas_equalTo(kRealValue(43));
            }];
            
            
            
            
            
       
            UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Imgtap)];
            [chakan addGestureRecognizer:Img3tap];
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeAct) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgview1.mas_bottom).offset(kRealValue(10));
                make.centerX.mas_equalTo(bgview1.mas_centerX).offset(kRealValue(0));
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
            self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            self.popView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            self.popView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            self.popView.popAnimationDuration = 0.5f;
            // 3.5 移除时动画时长
            self.popView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            self.popView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            self.popView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [self.popView pop];
        }
    }
    
   

    
    
    
    
    
}

-(void)closeAct
{

    [self.popView dismiss];
    NSMutableArray *alertArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    
    HSBannerModel *model = [alertArr2 objectAtIndex:0];
    // 存储 展示过的
    NSMutableArray *havealertArrold = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath1]];
    if (havealertArrold.count > 0) {
        //原来就有数据 如果有相同就改状态 没有就加
        
        BOOL have = YES;
        for (int i = 0; i < havealertArrold.count ; i++) {
            
            HSBannerModel *havemodel  = havealertArrold[i];
            if ([havemodel.id isEqualToString: model.id]) {
                
                havemodel.statu = @"DONE";
                have = YES;
                break;
            }else{
                have = NO;
            }
        }
        if (have == NO) {
            model.statu = @"DONE";
            [havealertArrold addObject:model];
        }
        
        
        [NSKeyedArchiver archiveRootObject:havealertArrold toFile:[self filePath1]];
    }else{
        NSMutableArray *havealertArr = [NSMutableArray array];
        model.statu = @"DONE";
        [havealertArr addObject:model];
        [NSKeyedArchiver archiveRootObject:havealertArr toFile:[self filePath1]];
    }
    
        [alertArr2 removeObjectAtIndex:0];
        [NSKeyedArchiver archiveRootObject:alertArr2 toFile:[self filePath]];
        NSMutableArray *alertArr = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        
        if (alertArr.count > 0) {
            HSBannerModel *model = [alertArr objectAtIndex:0];
            if ([model.statu isEqualToString:@"PENDING"]||[model.statu isEqualToString:@"ACTIVE"]) {
                [[MHBaseClass sharedInstance] presentActAltertWithtitle:model.title content:model.content backgroudImg:model.bulletBoxFilling contentType:model.bulletBoxType closeImg:model.title action_url:model.action_url type:model.type alertid:model.id];
                
                
            }
            
        }
        
        
    
}
-(void)closeAct2
{
    
    [self.popView dismiss];
    NSMutableArray *alertArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    
    HSBannerModel *model = [alertArr2 objectAtIndex:0];
    // 存储 展示过的
    NSMutableArray *havealertArrold = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath1]];
    if (havealertArrold.count > 0) {
        //原来就有数据 如果有相同就改状态 没有就加
        
        BOOL have = YES;
        for (int i = 0; i < havealertArrold.count ; i++) {
            
            HSBannerModel *havemodel  = havealertArrold[i];
            if ([havemodel.id isEqualToString: model.id]) {
                
                havemodel.statu = @"DONE";
                have = YES;
                break;
            }else{
                have = NO;
            }
        }
        if (have == NO) {
            model.statu = @"DONE";
            [havealertArrold addObject:model];
        }
        
        
        [NSKeyedArchiver archiveRootObject:havealertArrold toFile:[self filePath1]];
    }else{
        NSMutableArray *havealertArr = [NSMutableArray array];
        model.statu = @"DONE";
        [havealertArr addObject:model];
        [NSKeyedArchiver archiveRootObject:havealertArr toFile:[self filePath1]];
    }
    
    [alertArr2 removeObjectAtIndex:0];
    [NSKeyedArchiver archiveRootObject:alertArr2 toFile:[self filePath]];
    NSMutableArray *alertArr = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    
    if (alertArr.count > 0) {
        HSBannerModel *model = [alertArr objectAtIndex:0];
        if ([model.statu isEqualToString:@"PENDING"]||[model.statu isEqualToString:@"ACTIVE"]) {
//            [[MHBaseClass sharedInstance] presentActAltertWithtitle:model.title content:model.content backgroudImg:model.bulletBoxFilling contentType:model.bulletBoxType closeImg:model.title action_url:model.action_url type:model.type alertid:model.id];
            
            
        }
        
    }
    
    
    
}
- (NSString *)filePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"alert.plist"];
}
- (NSString *)filePath1
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Havealert.plist"];
}

@end
