//
//  HSWebviewCell.m
//  HSKD
//
//  Created by yuhao on 2019/4/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWebviewCell.h"
#import <WebKit/WebKit.h>
#import "MHProdetailViewController.h"
#import "MHShopViewController.h"
#import "HSPayResultController.h"
#import "HSChargeController.h"
#import "MHLoginViewController.h"
#import "HSQRcodeVC.h"
#import <Photos/Photos.h>
@interface HSWebviewCell ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>

@end

@implementation HSWebviewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xffffff);
        [self createview];
    }
    return self;
}
-(void)createwebviewheight
{
    self.webView.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight);
}
-(void)createwebviewheight2
{
    
    self.webView.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight-kRealValue(66)-kBottomHeight);
    
}
-(void)createview
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
    [configuration.userContentController addScriptMessageHandler:self name:@"isHskd"];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    if (!self.webView) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)configuration:configuration];
        [self addSubview:self.webView];
    }
//    self.webView.scrollView.scrollEnabled = NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
    request.timeoutInterval = 20;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    if ([message.name isEqualToString:@"isHskd"]) {
        
      
    }
    if ([message.name isEqualToString:@"saveNetworkBitmap"]) {
        
        [self savePicWIth:message.body];
        
    }
    
    if ([message.name isEqualToString:@"callTelphone"]) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@",message.body]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if ([message.name isEqualToString:@"jumpToProductDetailWithID"]) {
     
    }
    if ([message.name isEqualToString:@"JumpToShopList"]) {
       
    }
    if ([message.name isEqualToString:@"jsToNativeCode"]) {
        
    }
    if ([message.name isEqualToString:@"updateNow"]) {
      
        
    }
    if ([message.name isEqualToString:@"goToLogin"]) {
       
    }
    if ([message.name isEqualToString:@"jsToNative"]) {
        
    }
    
    
}


// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    NSString *script = [NSString stringWithFormat:
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var img;"
                        "var maxwidth=%f;"
                        "for(i=0;i <document.images.length;i++){"
                        "img = document.images[i];"
                        "if(img.width > maxwidth){"
                        "img.width = maxwidth;"
                        "}"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);", kScreenWidth - 20];
    [self.webView evaluateJavaScript:script completionHandler:nil ];
    [self.webView evaluateJavaScript:@"ResizeImages();" completionHandler:nil];
    
  
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
// 页面加载失败时调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
   
    
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
    
  
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(webviewscroller)]) {
        [self.delegate webviewscroller];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
