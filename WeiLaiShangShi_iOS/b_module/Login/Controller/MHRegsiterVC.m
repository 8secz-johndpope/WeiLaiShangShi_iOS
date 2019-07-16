//
//  MHRegsiterVC.m
//  wgts
//
//  Created by AllenQin on 2018/11/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHRegsiterVC.h"
#import "JKCountDownButton.h"
#import "MHWebviewViewController.h"
#import "NSString+WZXSSLTool.h"
#import "MHWebviewViewController.h"
#import <JPUSHService.h>

@interface MHRegsiterVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property(strong,nonatomic)UITextField *validateTextField;

@property(strong,nonatomic)UITextField *invitTextField;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) JKCountDownButton *countDownCode;



@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;


@property (strong, nonatomic)UIView *validateLineView;

@property (strong, nonatomic) UIView *invitLineView;


@end

@implementation MHRegsiterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,kRealValue(51), kScreenWidth, kRealValue(50));
    label.text = @"手机号注册";
    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    label.textColor = [UIColor colorWithHexString:@"#444444"];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入11位手机号码";

    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    

    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(label.mas_bottom).offset(kRealValue(44));
    }];
    
    
    _validateTextField = [UITextField new];
    _validateTextField.placeholder = @"请输入验证码";
    _validateTextField.backgroundColor = [UIColor whiteColor];
    _validateTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_validateTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_validateTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_validateTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    [_validateTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_validateTextField];
    [_validateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    
    
    //发送验证码
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [_countDownCode setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [_countDownCode.layer setBorderWidth:1/kScreenScale];
    [_countDownCode.layer setBorderColor:[[UIColor colorWithHexString:@"#999999"] CGColor]];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_countDownCode];
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(26));
        make.right.equalTo(self.validateTextField.mas_right).offset(-kRealValue(4));
        make.width.mas_equalTo(kRealValue(84));
        make.bottom.equalTo(self.validateTextField.mas_bottom).offset(-kRealValue(7));
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(self.phoneTextField.text)?self.phoneTextField.text:@""
                                                  scene:@"REGISTER"
                                        completionBlock:^(NSDictionary *response, NSError *error) {
                                            if (ValidResponseDict(response)) {
                                                KLToast(@"发送成功");
                                                [sender startCountDownWithSecond:60];
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
    
    
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"请输入6-16位密码";
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.left.equalTo(_phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(_validateTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    _passwordTextField.secureTextEntry = YES;
    
    
    
    
    _invitTextField = [UITextField new];
    _invitTextField.placeholder = @"填写邀请码";
    _invitTextField.backgroundColor = [UIColor whiteColor];
    _invitTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_invitTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_invitTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_invitTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    

    [_invitTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_invitTextField];
    [_invitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    
  

    UIButton *passwordBtn = [[UIButton alloc] init];
    
    [passwordBtn setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(passwordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwordBtn];
    
    [passwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(28));
        make.width.mas_equalTo(kRealValue(28));
        make.right.equalTo(_passwordTextField.mas_right).offset(-kRealValue(7));
        make.centerY.equalTo(_passwordTextField.mas_centerY).with.offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
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
        make.top.equalTo(_invitTextField.mas_bottom).offset(kRealValue(30));
    }];
    

    NSString *desc = @"登录即表示同意《火勺看点用户协议》";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangLight size:kFontValue(13)];
    textdesc.color = [UIColor colorWithHexString:@"#444444"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《火勺看点用户协议》"]
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
    
    
    _validateLineView = [[UIView alloc] init];
    _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_validateLineView];
    [_validateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.bottom.equalTo(_validateTextField.mas_bottom).offset(0);
    }];
    
    _invitLineView = [[UIView alloc] init];
    _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_invitLineView];
    [_invitLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.bottom.equalTo(_invitTextField.mas_bottom).offset(0);
    }];
    
    
    
    
    
    
    
}


- (void)login{
    
    if (_phoneTextField.text.length != 11) {
        KLToast(@"请输入正确的手机号");
        return;
    }
    
    if (_validateTextField.text.length != 4) {
        KLToast(@"请输入正确的验证码");
        return;
    }
    if (_invitTextField.text.length == 0) {
        KLToast(@"请输入正确的邀请码");
        return;
    }
    
    if (_passwordTextField.text.length >=0 && _passwordTextField.text.length < 6) {
        KLToast(@"请输入正确密码");
        return;
    }

    
    [[MHUserService sharedInstance]initWithRegsietr:_phoneTextField.text password:[_passwordTextField.text do16MD5] smsCode:_validateTextField.text inviteCode:_invitTextField.text completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            if ([response[@"data"][@"expand"] integerValue]== 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
            }
            [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
            [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
             [GVUserDefaults standardUserDefaults].phone = [[response objectForKey:@"data"]objectForKey:@"userPhone"];
            [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
            //别名
            [JPUSHService setAlias:[[response objectForKey:@"data"]objectForKey:@"alia"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }else{
            KLToast(response[@"message"]);
        }
    }];
    
}


- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
        
    }
   
    if (_passwordTextField.text.length > 16) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:16];
        
    }
    
     //验证码 4位
    if (_validateTextField.text.length > 4) {
        _validateTextField.text = [_validateTextField.text substringToIndex:4];
        
    }
    
    
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length >=6&& _validateTextField.text.length >=4 && _invitTextField > 0) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }else if (sender  == _passwordTextField) {
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }else if (sender  == _validateTextField) {
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
        _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }else if (sender  == _invitTextField) {
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    _validateLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    _invitLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
}



- (void)passwordBtnClicked:(UIButton *)button{
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    [button setImage:[UIImage imageNamed:_passwordTextField.secureTextEntry? @"password_unlook": @"password_look"] forState:UIControlStateNormal];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)backBtnClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
