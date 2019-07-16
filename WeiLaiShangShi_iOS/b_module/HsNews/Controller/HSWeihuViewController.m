//
//  HSWeihuViewController.m
//  HSKD
//
//  Created by yuhao on 2019/4/18.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWeihuViewController.h"
#import <WebKit/WebKit.h>
#import "MHProdetailViewController.h"
#import "MHShopViewController.h"
#import "HSPayResultController.h"
#import "HSChargeController.h"
#import "MHLoginViewController.h"
#import "HSQRcodeVC.h"
#import <Photos/Photos.h>
@interface HSWeihuViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)NSString *sourceurl;
@property(nonatomic, strong)NSString *h5funName;
@property (nonatomic, strong)NSMutableDictionary *respondic;

@end

@implementation HSWeihuViewController

- (instancetype)initWithurl:(NSString *)url comefrom:(NSString *)comeform
{
    self = [super init];
    if (self) {
        self.url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        _comeformtitle = comeform;
    }
    return self;
}
- (instancetype)initWithhtmlstring:(NSString *)htmlstring comefrom:(NSString *)comeform
{
    self = [super init];
    if (self) {
        _htmlstring = htmlstring;
        _comeformtitle = comeform;
        
    }
    return self;
}

-(void)createviewwithhtmlstr:(NSString *)htmlstr
{
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webView loadHTMLString:[headerString stringByAppendingString:htmlstr] baseURL:nil];
    //    [self.webView loadHTMLString:htmlstr baseURL:nil];
    self.webView.navigationDelegate = self;
    
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    
    
}
-(void)createview:(NSString *)url
{
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //调用JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"callTelphone"];//移除导航栏
    [configuration.userContentController addScriptMessageHandler:self name:@"jumpToProductDetailWithID"];
    [configuration.userContentController addScriptMessageHandler:self name:@"JumpToShopList"];
    [configuration.userContentController addScriptMessageHandler:self name:@"jsToNativeCode"];//移除导航栏
    [configuration.userContentController addScriptMessageHandler:self name:@"jsToNative"];
    [configuration.userContentController addScriptMessageHandler:self name:@"saveNetworkBitmap"];
    [configuration.userContentController addScriptMessageHandler:self name:@"updateNow"];
    [configuration.userContentController addScriptMessageHandler:self name:@"goToLogin"];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight)configuration:configuration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 20;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    
}
#pragma mark 保存图片
- (void)toSaveImage:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __block UIImage *img;
    [manager diskImageExistsForURL:url completion:^(BOOL isInCache) {
        if (isInCache) {
            img =  [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
            // 保存图片到相册中
            UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }else{
            //从网络下载图片
            NSData *data = [NSData dataWithContentsOfURL:url];
            img = [UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }
    }];
    
    
    
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message…
        KLToast(@"图片保存失败");
    }
    else  // No errors
    {
        
        KLToast(@"图片保存成功");
    }
}

-(void)savePicWIth:(NSString *)str
{
    // 获取当前App的相册授权状态
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    // 判断授权状态
    if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        // 如果已经授权, 保存图片
        [self toSaveImage:str];
    }
    // 如果没决定, 弹出指示框, 让用户选择
    else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            // 如果用户选择授权, 则保存图片
            if (status == PHAuthorizationStatusAuthorized) {
                [self toSaveImage:str];
            }
        }];
    } else {
        // 前往设置
        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"提示" message:@"你已拒绝未来商市访问您的相册，前往打开设置" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
            
        } rightAct:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }];
        
        
    }
    
    
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    MHLog(@"%@--%@",message.name,message.body);
    if ([message.name isEqualToString:@"saveNetworkBitmap"]) {
        
        [self savePicWIth:message.body];
        
    }
    
    if ([message.name isEqualToString:@"callTelphone"]) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@",message.body]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if ([message.name isEqualToString:@"jumpToProductDetailWithID"]) {
        MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
        vc.productId = [NSString stringWithFormat:@"%@",message.body];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"JumpToShopList"]) {
        MHShopViewController *vc = [[MHShopViewController alloc]init];
        vc.comeform = @"webview";
        //        vc.productId = [NSString stringWithFormat:@"%@",message.body];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"jsToNativeCode"]) {
        
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"]) {
            [[MHBaseClass sharedInstance] presentAlertWithtitle:@"升级为会员后才可拥有推广二维码" message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                
            } rightAct:^{
                HSChargeController *vc = [[HSChargeController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }else{
            HSQRcodeVC *vc =[[HSQRcodeVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
    if ([message.name isEqualToString:@"updateNow"]) {
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.tabBarController setSelectedIndex:2];
        }
        
    }
    if ([message.name isEqualToString:@"goToLogin"]) {
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }else{
            KLToast(@"您已注册");
        }
    }
    if ([message.name isEqualToString:@"jsToNative"]) {
        
        NSMutableDictionary *dic= message.body;
        self.h5funName =[dic valueForKey:@"successApp"];
        self.respondic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initwithHSWebAriticeinterfaceCode:[dic valueForKey:@"dd"] businessParam:[dic valueForKey:@"jsonId"] weburl:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.respondic = [response valueForKey:@"data"];
                NSString *str1 = (NSString *)[response valueForKey:@"data"] ;
                //                NSDictionary *dic = [self dictionaryWithJsonString:str1];
                //                NSString *finshstr = [self dictionaryToJson:dic];
                //
                NSString *str = [NSString stringWithFormat:@"%@(%@)",self.h5funName,str1];
                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    MHLog(@"%@",error);
                    
                }];
            }else{
                self.respondic = [response valueForKey:@"data"];
                NSString *str1 = [response valueForKey:@"data"] ;
                
                NSString *str = [NSString stringWithFormat:@"%@(\"%@\")",self.h5funName,str1];
                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    MHLog(@"%@",error);
                    
                }];
            }
            
        }];
        
        //        MHShopViewController *vc = [[MHShopViewController alloc]init];
        //        vc.comeform = @"webview";
        //        //        vc.productId = [NSString stringWithFormat:@"%@",message.body];
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!klStringisEmpty(self.htmlstring)) {
        [self createviewwithhtmlstr:self.htmlstring];
    }else{
        [self createview:self.url];
    }
    
    // Do any additional setup after loading the view.
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.title = @"加载中..";
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
    if ([self.comeformtitle isEqualToString:@"notice"]) {
        self.title = @"消息详情";
    }
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
// 页面加载失败时调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.title = @"加载失败";
    [MBProgressHUD showActivityMessageInWindow:@"加载失败"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    self.title = webView.title;
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnClicked{
    if ([self.comeformtitle isEqualToString:@"payyop"]) {
        HSPayResultController *vc = [[HSPayResultController alloc] init];
        vc.orderCode = self.orderCode;
        vc.payType = self.payType;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
