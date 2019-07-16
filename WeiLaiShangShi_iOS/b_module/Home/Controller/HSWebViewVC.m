//
//  HSWebViewVC.m
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWebViewVC.h"

@interface HSWebViewVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HSWebViewVC




- (void)viewDidLoad {
    [super viewDidLoad];
 
}


-(void)setUrl:(NSString *)url{
    _url = url;
    //加载网页
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view  addSubview: self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    // 自动检测电话号码、网址、邮件地址
    self.webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    // 缩放网页
    self.webView.scalesPageToFit = YES;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

}

@end
