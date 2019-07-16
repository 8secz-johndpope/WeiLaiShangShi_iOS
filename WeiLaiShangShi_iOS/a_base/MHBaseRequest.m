//
//  MHBaseRequest.m
//  mohu
//
//  Created by AllenQin on 2018/8/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseRequest.h"
#import "MHRefreshApi.h"
#import "UIControl+BlocksKit.h"
#import "ZJAnimationPopView.h"
#import "HSWeihuViewController.h"
#import "MHWebviewViewController.h"
@implementation MHBaseRequest{
    YTKRequestMethod   _method;
    id                 _paramDict;
    NSString           *_url;
    BOOL               _isCache;
    ZJAnimationPopView *_popView;
    NSString           *_version;
    NSString           *_breakstatulink;
}

- (instancetype)initWithUrl:(NSString *)url
                baseRequest:(YTKRequestMethod )method
                    isCache:(BOOL)isCache
                  withParam:(id )dict{
                self = [super init];
                if (self) {
                    _method = method;
                    _paramDict = dict;
                    _url = url;
                    _isCache  = isCache;
                }
                return self;
}
- (instancetype)initWithUrl:(NSString *)url
                baseRequest:(YTKRequestMethod )method
                    isCache:(BOOL)isCache
                  withParam:(id )dict
                   Version:(NSString *)version{
    self = [super init];
    if (self) {
        _method = method;
        _paramDict = dict;
        _url = url;
        _isCache  = isCache;
        _version = version;
    }
    return self;
}


-(YTKRequestMethod)requestMethod{
    return _method;
}

- (id)requestArgument {
    return _paramDict;
}

- (NSString *)requestUrl {
    return _url;
}



#pragma mark ————— 非加密时也要传输的头部内容 也可能不需要，暂时保留 —————
-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    
    NSMutableDictionary *baseDic = [NSMutableDictionary dictionary];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
         [baseDic setObject:[GVUserDefaults standardUserDefaults].accessToken forKey:@"accessToken"];
    }
    if (klStringisEmpty(_version)) {
        [baseDic setObject:MHConfigServerVersion forKey:@"version"];
    }else{
        [baseDic setObject:_version forKey:@"version"];
    }
    
    return baseDic;
}


-(void)startWithRefreshCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure{
    
    [self setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //1、先判断code   2、刷新token
        if ([[self errcode:request] isEqualToString: kRefreshTokenCode]) {
            //刷新token
            MHRefreshApi *api = [[MHRefreshApi alloc] init];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                if ([[self errcode:request] isEqualToString:@"0"]) {
                    //2、刷新成功
                    [GVUserDefaults standardUserDefaults].accessToken = [[[request responseJSONObject] objectForKey:@"data"]objectForKey:@"accessToken"];
                    [GVUserDefaults standardUserDefaults].refreshToken = [[[request responseJSONObject] objectForKey:@"data"]objectForKey:@"refreshToken"];            
                    //3、重新调用接口
                    MHBaseRequest  *baseApi = [[MHBaseRequest alloc]initWithUrl:_url baseRequest:_method isCache:_isCache withParam:_paramDict];
                    [baseApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull req) {
                        if (success) {
                            success(req);
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull req) {
                        if (failure) {
                            failure(req);
                        }
                    }];
                    
                }else if ([[self errcode:request] isEqualToString: kNoneCode]){
                    //重新登录 loginOut
                    [[MHBaseClass sharedInstance] loginOut];
                    [MBProgressHUD hideHUD];
                    UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
                    tabbarViewController.selectedIndex = 0;
                    KLToast(@"请重新登录");
                    
                }else if ([[self errcode:request] isEqualToString: kTimeOutCode]){
                    //重新登录 loginOut
                    [[MHBaseClass sharedInstance] loginOut];
                    [MBProgressHUD hideHUD];
                    UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
                    tabbarViewController.selectedIndex = 0;
                    KLToast(@"长时间没登录，请重新登录");
                    
                }else if ([[self errcode:request] isEqualToString: kLoginOutCode]){
                    //重新登录 loginOut
                    [[MHBaseClass sharedInstance] loginOut];
                    [MBProgressHUD hideHUD];
                    UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
                    tabbarViewController.selectedIndex = 0;
                    KLToast(@"你已在别的设备上登录，请重新登录");
                }else{
                    //重新登录 loginOut
                    [[MHBaseClass sharedInstance] loginOut];
                    [MBProgressHUD hideHUD];
                    UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
//                    tabbarViewController.selectedIndex = 0;
                    KLToast(@"长时间没登录，请重新登录");
                }
            } failure:nil];
            
        }else if ([[self errcode:request] isEqualToString: kNoneCode]){
            //重新登录 loginOut
            [[MHBaseClass sharedInstance] loginOut];
            [MBProgressHUD hideHUD];
            UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
            tabbarViewController.selectedIndex = 0;
            KLToast(@"请重新登录");
            
        }else if ([[self errcode:request] isEqualToString: kTimeOutCode]){
            //重新登录 loginOut
            [[MHBaseClass sharedInstance] loginOut];
            [MBProgressHUD hideHUD];
            UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
            tabbarViewController.selectedIndex = 0;
            KLToast(@"长时间没登录，请重新登录");
            
        }else if ([[self errcode:request] isEqualToString: kLoginOutCode]){
            //重新登录 loginOut
            [[MHBaseClass sharedInstance] loginOut];
            [MBProgressHUD hideHUD];
            UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
            tabbarViewController.selectedIndex = 0;
            KLToast(@"你已在别的设备上登录，请重新登录");
        }else if ([[self errcode:request] isEqualToString: @"-1"]){
            //更新
            
            if ([[GVUserDefaults standardUserDefaults].ShowAppUpdateWithCode isEqualToString:@"Yes"]) {
                   [self updateMessage:[[request responseJSONObject] objectForKey:@"data"]];
                  [GVUserDefaults standardUserDefaults].ShowAppUpdateWithCode = @"No";
              }
            
            
        }else if ([[self errcode:request] isEqualToString:@"-2"] ){
            //系统维护页面
            if ([[GVUserDefaults standardUserDefaults].ShowBreakStatuWithCode isEqualToString:@"Yes"]) {
                // 展示系统弹框
                _breakstatulink=  [[request responseJSONObject] objectForKey:@"data"];
                
                [self showbreakAlert:[[request responseJSONObject] objectForKey:@"data"]];
                [GVUserDefaults standardUserDefaults].ShowBreakStatuWithCode = @"No";
                
            }
            
            
            
            
        }else{
           
            if (success) {
                MHLog(@"%@",[request responseString]);
                success(request);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request);
            NSString *hostUrl = [NSString stringWithFormat:@"%@://%@",request.currentRequest.URL.scheme,request.currentRequest.URL.host];
//            NSLog(@"%@",hostUrl);
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshApi object:nil userInfo:@{@"hostUrl":hostUrl}];
        }
    }];
    
   [self start];

}
-(void)forceUpdateImgAct
{
   
   
}
-(void)showbreakAlert:(NSString *)str
{
    UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    contentViews.userInteractionEnabled = YES;
    contentViews.backgroundColor = [UIColor clearColor];
    UIImageView *forceUpdateImg;
    if (klStringisEmpty(str)) {
        forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(590/2), kRealValue(236))];
        forceUpdateImg.userInteractionEnabled = YES;
        forceUpdateImg.image = [UIImage imageNamed:@"维护"];
        [contentViews addSubview:forceUpdateImg];
        forceUpdateImg.centerX = contentViews.centerX;
        forceUpdateImg.centerY = contentViews.centerY;
    }else{
        forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(590/2), kRealValue(550/2))];
        forceUpdateImg.userInteractionEnabled = YES;
        forceUpdateImg.image = [UIImage imageNamed:@"weih1"];
        [contentViews addSubview:forceUpdateImg];
        forceUpdateImg.centerX = contentViews.centerX;
        forceUpdateImg.centerY = contentViews.centerY;
    }
    
    

    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forceUpdateImgAct)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
       
      
        if (!klStringisEmpty(str)) {
            HSWeihuViewController *vc = [[HSWeihuViewController alloc]initWithurl:str comefrom:@"home"];
            UINavigationController *rootnv = [[UINavigationController alloc]initWithRootViewController:vc];
            rootnv.navigationBar.barTintColor = [UIColor whiteColor];
            [[UIApplication sharedApplication].windows[0].rootViewController presentViewController:rootnv animated:YES completion:nil];
        }
    }];
    [forceUpdateImg addGestureRecognizer:tap];
    
    
   
   
    
    _popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    _popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    _popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    _popView.popAnimationDuration = 0.5f;
    // 3.5 移除时动画时长
    _popView.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    _popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    _popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [_popView pop];
    
}
-(void)updateMessage:(NSDictionary *)response{
    
    
    
    MHUpdateModel *model = [MHUpdateModel baseModelWithDic:response];
    if (model.forceUpgrade == 1) {
        //更新
        
        UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        contentViews.backgroundColor = [UIColor clearColor];
        
        UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(300), kRealValue(385))];
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
        NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
        label.text = str;
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
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
        } forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(update_btn, kRealValue(5));
        [forceUpdateImg addSubview:update_btn];
        [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
            make.centerX.equalTo(forceUpdateImg.mas_centerX);
            make.width.mas_equalTo(kRealValue(220));
            make.height.mas_equalTo(kRealValue(35));
        }];
        
        _popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
        // 3.2 显示时背景的透明度
        _popView.popBGAlpha = 0.5f;
        // 3.3 显示时是否监听屏幕旋转
        _popView.isObserverOrientationChange = YES;
        // 3.4 显示时动画时长
        _popView.popAnimationDuration = 0.5f;
        // 3.5 移除时动画时长
        _popView.dismissAnimationDuration = 0.3f;
        
        // 3.6 显示完成回调
        _popView.popComplete = ^{
            MHLog(@"显示完成");
        };
        // 3.7 移除完成回调
        _popView.dismissComplete = ^{
            MHLog(@"移除完成");
        };
        [_popView pop];
        
        
    }else{
        
        if (model.upgrade == 1) {
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
            NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
            label.text = str;
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
                [_popView dismiss];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
            } forControlEvents:UIControlEventTouchUpInside];
            ViewRadius(update_btn, kRealValue(5));
            [forceUpdateImg addSubview:update_btn];
            [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
                make.centerX.equalTo(forceUpdateImg.mas_centerX);
                make.width.mas_equalTo(kRealValue(220));
                make.height.mas_equalTo(kRealValue(35));
            }];
            
            _popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            _popView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            _popView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            _popView.popAnimationDuration = 0.5f;
            // 3.5 移除时动画时长
            _popView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            _popView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            _popView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [_popView pop];
            
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
            [closeBtn bk_addEventHandler:^(id sender) {
                [_popView dismiss];
                [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert = @"No";
                
            } forControlEvents:UIControlEventTouchUpInside];
            [contentViews addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
                make.right.mas_equalTo(forceUpdateImg.mas_right);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
    }
}

- (NSString *)errcode:(YTKBaseRequest *)request {
    return [NSString stringWithFormat:@"%@",[[request responseJSONObject] objectForKey:@"code"] ];
}


-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}

@end
