//
//  MHSetPsdVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSetPsdVC.h"

#import "JKCountDownButton.h"
#import "UIImage+Common.h"

@interface MHSetPsdVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic)UIView *phoneLineView1;
@property (strong, nonatomic) UIView *passwordLineView;

@property (strong, nonatomic) UIButton *loginBtn;

@property(strong,nonatomic)UITextField *yqTextField;

@property (strong, nonatomic)UIView *yqLineView;


@property (strong, nonatomic) JKCountDownButton *countDownCode;

@end

@implementation MHSetPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置/修改资金密码";
    
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"验证手机号188****8888";
    titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(18)];
    titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.view.mas_top).offset(kRealValue(50));
    }];
    
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"输入6位数字资金密码";
    _phoneTextField.secureTextEntry = YES;
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
    
    _phoneLineView1 = [[UIView alloc] init];
    _phoneLineView1.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_phoneLineView1];
    [_phoneLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(-1);
    }];
    
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.placeholder = @"确认资金密码";
    _passwordTextField.secureTextEntry = YES;
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
    

    
//    _phoneLineView = [[UIView alloc] init];
//    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
//    [self.view addSubview:_phoneLineView];
//    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1/kScreenScale);
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.bottom.equalTo(_phoneTextField.mas_bottom).offset(0);
//    }];
//
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
    _yqTextField = [UITextField new];
    _yqTextField.placeholder = @"请输入验证码";
    _yqTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_yqTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_yqTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
     [_yqTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_yqTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_yqTextField];
    [_yqTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(0);
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
        make.right.equalTo(_phoneTextField.mas_right).offset(-kRealValue(4));
        make.width.mas_equalTo(kRealValue(84));
        make.bottom.equalTo(_yqTextField.mas_bottom).offset(-kRealValue(7));
    }];
    NSString *scenc;
    if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"modifyPayPassword"]] isEqualToString:@"0"]) {
        scenc = @"SET_PAY_PASSWORD";
    }else{
        scenc = @"UPDATE_PAY_PASSWORD";
    }
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
           sender.enabled = NO;
                [[MHUserService sharedInstance]initWithSendCode:[self.dic valueForKey:@"phone"]?[self.dic valueForKey:@"phone"]:@""
                                                          scene:scenc
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
    
    _yqLineView = [[UIView alloc] init];
    _yqLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_yqLineView];
    [_yqLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_yqTextField.mas_bottom).offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"完成设置" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = KColorFromRGB(kThemecolor);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(343));
        make.top.equalTo(_yqTextField.mas_bottom).offset(kRealValue(25));
    }];
    
    NSString *desc = @"温馨提示：\n 为保障您的账户安全，请及时设置资金密码。";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangLight size:kFontValue(13)];
    textdesc.color = [UIColor colorWithHexString:@"#FB3131"];
//    [textdesc setTextHighlightRange:[desc rangeOfString:@"《未来商市注册协议》"]
//                              color:[UIColor colorWithHexString:@"689DFF"]
//                    backgroundColor:[UIColor colorWithHexString:@"666666"]
//                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//
//                          }];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(320), CGFLOAT_MAX) text:textdesc];
    YYLabel *textLabel = [YYLabel new];
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.height.mas_equalTo(layout.textBoundingSize.height);
        make.top.equalTo(_loginBtn.mas_bottom).offset(kRealValue(10));
    }];
    textLabel.attributedText = textdesc;
    
    
    
    self.title = self.navtitle;
    if (!klObjectisEmpty(self.dic)) {
        titleLabel.text = [NSString stringWithFormat:@"验证手机号%@",[[self.dic valueForKey:@"phone"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    }
    
    
}

- (void)login{
    
    if (_phoneTextField.text.length != 6) {
        KLToast(@"请输入正确密码");
        return;
    }
    if (_passwordTextField.text.length != 6) {
        KLToast(@"请输入正确确认密码");
        return;
    }
    if (_phoneTextField.text != _passwordTextField.text) {
        KLToast(@"两次密码输入不一致");
        return;
    }
    if (_yqTextField.text.length<1) {
        KLToast(@"验证码不正确");
        return;
    }
    
    if ( [[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"modifyPayPassword"]] isEqualToString:@"0"]) {
        
        
        [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"SET_USER_PAY_PASSWORD" userNickname:@"" userImage:@"" openId:@"" unionId:@"" originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:self.phoneTextField.text newConfirmPassword:_passwordTextField.text newPayPasswordCode:_yqTextField.text isOldPhone:NO CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                KLToast(@"设置成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                KLToast([response valueForKey:@"message"]);
            }
        }];
        
        
        
        
        
        
    }else{
        
        [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"UPDATE_USER_PAY_PASSWORD" userNickname:@"" userImage:@"" openId:@"" unionId:@"" originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:self.phoneTextField.text newConfirmPassword:_passwordTextField.text newPayPasswordCode:_yqTextField.text isOldPhone:NO CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                KLToast(@"设置成功");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView1.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else if(sender == _passwordTextField){
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _phoneLineView1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else{
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        _phoneLineView1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        _yqLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    _phoneLineView1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    _yqLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)textValueChanged:(id)sender {
    
    //密码
    if (_phoneTextField.text.length > 6) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:6];
        
    }
    //确认密码
    if (_passwordTextField.text.length > 6) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:6];
        
    }
    //验证码
    if (_yqTextField.text.length > 4) {
        _yqTextField.text = [_yqTextField.text substringToIndex:4];
        
    }
}
- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
