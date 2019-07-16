//
//  MHWechatPhoneVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHWechatPhoneVC.h"
#import "JKCountDownButton.h"
#import "UIImage+Common.h"
#import "MHWebviewViewController.h"
#import "MHWechatYQVC.h"

@interface MHWechatPhoneVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;

@property (strong, nonatomic) UIButton *loginBtn;
//
//@property(strong,nonatomic)UITextField *yqTextField;
//
//@property (strong, nonatomic)UIView *yqLineView;


@property (strong, nonatomic) JKCountDownButton *countDownCode;

@end

@implementation MHWechatPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(self.view.mas_top).offset(kRealValue(110));
    }];
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.placeholder = @"验证码";
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.left.equalTo(_phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(kRealValue(250));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    //发送验证码
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [_countDownCode setTitleColor:[UIColor colorWithHexString:@"689DFF"] forState:UIControlStateNormal];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_countDownCode];
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.right.equalTo(_phoneTextField.mas_right).offset(0);
        make.width.mas_equalTo(kRealValue(80));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
         sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(_phoneTextField.text)?_phoneTextField.text:@""
                                                  scene:@"THIRDPARTY_BIND_PHONE"
                                        completionBlock:^(NSDictionary *response, NSError *error) {
                                            if (ValidResponseDict(response)) {
                                                KLToast(@"发送成功");
                                                [sender startCountDownWithSecond:90];
                                            }else{
                                                KLToast(response[@"message"]);
                                                sender.enabled = YES;
                                            }
                                            if (error) {
                                                sender.enabled = YES;
                                            }
                                        }];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zds",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
        
    }];
    
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
//    _yqTextField = [UITextField new];
//    _yqTextField.placeholder = @"输入邀请码*";
//    _yqTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [_yqTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
//    [_yqTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
//    [_yqTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
//    [self.view addSubview:_yqTextField];
//    [_yqTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(kRealValue(50));
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.top.equalTo(_passwordTextField.mas_bottom).offset(0);
//    }];
//
//    _yqLineView = [[UIView alloc] init];
//    _yqLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
//    [self.view addSubview:_yqLineView];
//    [_yqLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1/kScreenScale);
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.bottom.equalTo(_yqTextField.mas_bottom).offset(0);
//    }];
//
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"绑定手机号" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(350));
        make.top.equalTo(_passwordLineView.mas_bottom).offset(kRealValue(25));
    }];
    
//    NSString *desc = @"温馨提示：未注册未来商市账户的手机号，登录时将自动注册，且代表您已同意《陌狐优品注册协议》";
//    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
//    textdesc.font = [UIFont fontWithName:kPingFangLight size:kFontValue(11)];
//    textdesc.color = [UIColor colorWithHexString:@"000000"];
//    [textdesc setTextHighlightRange:[desc rangeOfString:@"《陌狐优品注册协议》"]
//                              color:[UIColor colorWithHexString:@"689DFF"]
//                    backgroundColor:[UIColor colorWithHexString:@"666666"]
//                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/registration_agreement.html" comefrom:@"mine"];
//                              [self.navigationController pushViewController:vc animated:YES];
//                          }];
//    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(320), CGFLOAT_MAX) text:textdesc];
//    YYLabel *textLabel = [YYLabel new];
//    textLabel.numberOfLines = 0;
//    [self.view addSubview:textLabel];
//    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.height.mas_equalTo(layout.textBoundingSize.height);
//        make.top.equalTo(_loginBtn.mas_bottom).offset(kRealValue(13));
//    }];
//    textLabel.attributedText = textdesc;
    
}

- (void)login{
    [self.view endEditing:YES];
    if (_phoneTextField.text.length < 11) {
        KLToast(@"手机号格式不正确");
        return;
    }
    if (_passwordTextField.text.length < 4) {
        KLToast(@"验证码不正确");
        return;
    }
    
    [[MHUserService sharedInstance]initWithThirdPreBindPhone:ValidStr(_phoneTextField.text)?_phoneTextField.text:@""
                                                     smsCode:ValidStr(_passwordTextField.text)?_passwordTextField.text:@""
                                                         uid:_uid
                                                     unionid:_unionid
                                             completionBlock:^(NSDictionary *response, NSError *error) {
                                                 if (ValidResponseDict(response)) {
                                                     if ([response[@"data"][@"checkResult"] isEqualToString:@"SUCCESS"]) {
                                                         if ([response[@"data"][@"expand"] integerValue]== 0) {
                                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
                                                         }
                                                         [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                                                         [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                                                         [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                                                       
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }else{
                                                         MHWechatYQVC *vc = [[MHWechatYQVC alloc] init];
                                                         vc.phone = self.phoneTextField.text;
                                                         vc.smsCode = self.passwordTextField.text;
                                                         vc.unionid = self.unionid;
                                                         vc.uid = self.uid;
                                                         vc.thirdparty = @"WECHAT";
                                                         [self.navigationController pushViewController:vc animated:YES];
                                                     }
                                                 }else{
                                                     KLToast(response[@"message"]);
                                                 }
    }];

}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
//        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else if(sender == _passwordTextField){
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
//        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else{
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
//        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
//    _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
        
    }
    //验证码 4位
    if (_passwordTextField.text.length > 4) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:4];
        
    }
}
- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
