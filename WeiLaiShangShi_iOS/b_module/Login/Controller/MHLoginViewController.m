//
//  MHLoginViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHLoginViewController.h"
#import "UIImage+Common.h"
#import "MHForgetFirstVC.h"
#import "MHRegsiterVC.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "NSString+WZXSSLTool.h"
#import <JPUSHService.h>
#import <UMShare/UMShare.h>
#import "MHWechatPhoneVC.h"
#import "MHWebviewViewController.h"

@interface MHLoginViewController ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *loginBtn;


@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;

@end

@implementation MHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;
    
//    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStyleDone)target:self action:@selector(registerUser)];
//
//    NSDictionary *dic =[NSDictionary dictionaryWithObject:[UIColor colorWithHexString:@"444444" ]forKey:NSForegroundColorAttributeName];
//    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    UIButton * button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_back setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    
    [button_back setTitle:@"注册" forState:UIControlStateNormal];
    [button_back setTitleColor:[UIColor colorWithHexString:@"444444" ] forState:UIControlStateNormal];
    button_back.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [button_back.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button_back addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button_back];
    [backButton setStyle:UIBarButtonItemStyleDone];
    self.navigationItem.rightBarButtonItem = backButton;
    

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,kRealValue(51), kScreenWidth, kRealValue(50));
    label.text = @"密码登录";
    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    label.textColor = [UIColor colorWithHexString:@"#444444"];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入11位手机号码";
//    _phoneTextField.layer.masksToBounds = YES;
//    _phoneTextField.layer.cornerRadius = kRealValue(22);
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;

    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(label.mas_bottom).offset(kRealValue(44));
    }];
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"请输入6-16位密码";
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.bottom.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetUser) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(20));
        make.right.equalTo(_passwordTextField.mas_right).offset(0);
        make.width.mas_equalTo(kRealValue(74));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    

    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#BEBEBE"]] forState:UIControlStateDisabled];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.enabled = NO;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kRealValue(65));
    }];
    
//
//
//
//    UIButton *reigserBtn = [[UIButton alloc] init];
//    reigserBtn.backgroundColor = [UIColor clearColor];
//    [reigserBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [reigserBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
//    reigserBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//    [reigserBtn setTitleColor:[UIColor colorWithHexString:@"#689DFF"] forState:UIControlStateNormal];
//    [self.view addSubview:reigserBtn];
//    [reigserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(kRealValue(20));
//        make.left.equalTo(_loginBtn.mas_left).offset(kRealValue(3));
//        make.width.mas_equalTo(kRealValue(40));
//        make.top.equalTo(_loginBtn.mas_bottom).offset(kRealValue(15));
//    }];
    
    NSString *desc = @"登录即表示同意《未来商市用户协议》";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangLight size:kFontValue(13)];
    textdesc.color = [UIColor colorWithHexString:@"#444444"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《未来商市用户协议》"]
                              color:[UIColor colorWithHexString:@"#F6AC19"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/zhuce.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
                              [self.navigationController pushViewController:vc animated:YES];
                          }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentCenter;
//    [paragraphStyle setLineSpacing:12];
    [textdesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [desc length])];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(320), CGFLOAT_MAX) text:textdesc];
    YYLabel *textLabel = [YYLabel new];
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.height.mas_equalTo(layout.textBoundingSize.height);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kRealValue(60));
    }];
    textLabel.attributedText = textdesc;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kScreenHeight - kTopHeight - kRealValue(190), kRealValue(100), kRealValue(100));
    [btn setTitle:@"微信一键登录" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"weix_icon"] forState:0];
    [btn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kRealValue(14)];
    [self initButton:btn];
    [self.view addSubview:btn];
    btn.centerX = self.view.centerX;
}



//微信登录
-(void)wxLogin {
    
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            KLToast(@"您取消了微信登录");
        }else{
            UMSocialUserInfoResponse *resp = result;
            [MBProgressHUD  showActivityMessageInWindow:@"正在登录中.."];
            [[MHUserService sharedInstance]initWithThirdLogin:@"WECHAT" uid: resp.openid unionid:resp.unionId nickName:resp.name avatar:resp.iconurl completionBlock:^(NSDictionary *response, NSError *error) {
                
                if (ValidResponseDict(response)) {
                    if ([response[@"data"][@"status"]  isEqualToString:@"ACTIVE"]) {
                        if ([response[@"data"][@"expand"] integerValue]== 0) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
                        }
                        [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                        [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                        [GVUserDefaults standardUserDefaults].phone = [[response objectForKey:@"data"]objectForKey:@"phone"];
                        [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                        //别名
                        [JPUSHService setAlias:[[response objectForKey:@"data"]objectForKey:@"alia"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                            
                        } seq:1];
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshHome object:nil userInfo:nil];
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                    }else{
                        //绑定手机号
                        MHWechatPhoneVC *vc = [[MHWechatPhoneVC alloc] init];
                        vc.uid = resp.openid;
                        vc.unionid = resp.unionId;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }else{
                    KLToast(response[@"message"]);
                }
                [MBProgressHUD hideHUD];
            }];
        }
    }];
}



//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)btn{
    float  spacing = 10;//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}




- (void)login{
    
    [self.view endEditing:YES];
    if (_phoneTextField.text.length != 11) {
        KLToast(@"请输入正确的手机号");
        return;
    }
    if (_passwordTextField.text.length >=0 && _passwordTextField.text.length < 6) {
        KLToast(@"请输入正确密码");
        return;
    }

    [[MHUserService sharedInstance]initWithLogin:_phoneTextField.text sms:[_passwordTextField.text do16MD5] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if ([response[@"data"][@"expand"] integerValue]== 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
            }
            [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
            [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
             [GVUserDefaults standardUserDefaults].phone = [[response objectForKey:@"data"]objectForKey:@"phone"];
            [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
            //别名
            [JPUSHService setAlias:[[response objectForKey:@"data"]objectForKey:@"alia"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
             [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshHome object:nil userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            KLToast(response[@"message"]);
        }
    }];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)registerUser{
    MHRegsiterVC *vc = [[MHRegsiterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)closeLogin{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)forgetUser{
    
    MHForgetFirstVC *vc = [[MHForgetFirstVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }else{
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
}


- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
        
    }
    //验证码 4位
    if (_passwordTextField.text.length > 16) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:16];
        
    }
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length >=6) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
