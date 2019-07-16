//
//  HSDisCoverViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSDisCoverViewController.h"
#import <WebKit/WebKit.h>
#import "HSQRcodeVC.h"
#import "HSChargeController.h"
#import "MHLoginViewController.h"


@interface HSDisCoverViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)NSString *sourceurl;
@property(nonatomic, strong)NSString *h5funName;
@property (nonatomic, strong)NSMutableDictionary *respondic;
@end

@implementation HSDisCoverViewController

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initWithFirstPageComponent:@"4" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *bannerArr = response[@"data"];
            [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"type"] isEqualToString:@"BANNER"]) {
                    NSArray *picArr = obj[@"result"];
                    NSMutableArray *crlArr = [NSMutableArray array];
                    [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [crlArr addObject:obj[@"actionUrl"]];
                      
                    }];
                    self.sourceurl = [crlArr objectAtIndex:0];
                    [self createview:self.sourceurl];
                  
                }
            }];
        }
    }];
    
      

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
    [configuration.userContentController addScriptMessageHandler:self name:@"updateNow"];
    [configuration.userContentController addScriptMessageHandler:self name:@"goToLogin"];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    if (!self.webView) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -kTopHeight-kTabBarHeight)configuration:configuration];
         [self.view addSubview:self.webView];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 20;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
   
    
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    MHLog(@"%@--%@",message.name,message.body);
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
    if ([message.name isEqualToString:@"jumpToProductDetailWithID"]) {
//        MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
//        vc.productId = [NSString stringWithFormat:@"%@",message.body];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"jsToNative"]) {
        
        NSMutableDictionary *dic= message.body;
        self.h5funName =[dic valueForKey:@"shareApp"];
        self.respondic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initwithHSWebAriticeinterfaceCode:[dic valueForKey:@"dd"] businessParam:[dic valueForKey:@"jsonId"] weburl:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.respondic = [response valueForKey:@"data"];
                NSString *str1 = (NSString *)[response valueForKey:@"data"] ;

                NSString *str = [NSString stringWithFormat:@"%@(%@)",self.h5funName,str1];
                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    MHLog(@"%@",error);
                    
                }];
            }else{
                KLToast([response valueForKey:@"message"]);
//                self.respondic = [response valueForKey:@"data"];
//                NSString *str1 = [response valueForKey:@"data"] ;
//
//                NSString *str = [NSString stringWithFormat:@"%@(\"%@\")",self.h5funName,str1];
//                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//                    MHLog(@"%@",error);
//
//                }];
            }
            
        }];
        
//        MHShopViewController *vc = [[MHShopViewController alloc]init];
//        vc.comeform = @"webview";
//        //        vc.productId = [NSString stringWithFormat:@"%@",message.body];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([message.name isEqualToString:@"updateNow"]) {
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }else{
            [self.tabBarController setSelectedIndex:4];
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
    
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.title = @"加载中..";
    
  
    
    
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
//    if ([self.comeformtitle isEqualToString:@"notice"]) {
//        self.title = @"消息详情";
//    }
    
   
   
    
  
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
////在JS端调用alert函数时，会触发此代理方法。
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
//{
//
//}

//JS端调用confirm函数时，会触发此方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
}

//JS端调用prompt函数时，会触发此方法
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
