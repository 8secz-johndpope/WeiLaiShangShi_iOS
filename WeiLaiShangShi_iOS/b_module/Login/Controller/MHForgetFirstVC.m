//
//  MHForgetFirstVC.m
//  wgts
//
//  Created by AllenQin on 2018/11/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHForgetFirstVC.h"
#import "MHForgetSecondVC.h"
#import "JKCountDownButton.h"

@interface MHForgetFirstVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) JKCountDownButton *countDownCode;


@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;



@end

@implementation MHForgetFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"忘记密码";
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(kRealValue(28), kRealValue(10), kScreenWidth, kRealValue(50));
//    label.text = @"验证手机号";
//    label.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(24)];
//    label.textColor = [UIColor colorWithHexString:@"#434343"];
//    label.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:label];
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入11位手机号码";
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(44), kRealValue(54))];
//    view1.backgroundColor = [UIColor clearColor];
//    UIImageView *iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone"]];
//    iv1.center = view1.center;
//    [view1 addSubview:iv1];
//
//    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
//    _phoneTextField.leftView = view1;
    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(295));
        make.top.equalTo(self.view.mas_top).offset(kRealValue(120));
    }];
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"请输入验证码";
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.left.equalTo(_phoneTextField.mas_left).offset(0);
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
        make.right.equalTo(self.passwordTextField.mas_right).offset(0);
        make.width.mas_equalTo(kRealValue(84));
        make.bottom.equalTo(self.passwordTextField.mas_bottom).offset(-kRealValue(7));
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
       sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(self.phoneTextField.text)?self.phoneTextField.text:@""
                                                  scene:@"FORGET_PWD"
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
    

    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
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
        make.top.equalTo(_passwordTextField.mas_bottom).offset(kRealValue(30));
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
    
}

-(void)login{

    if (_phoneTextField.text.length != 11) {
        KLToast(@"请输入正确的手机号");
        return;
    }

    if (_passwordTextField.text.length != 4) {
        KLToast(@"请输入正确的验证码");
        return;
    }

    [[MHUserService sharedInstance]initWithValidCode:_phoneTextField.text scene:@"FORGET_PWD" smsCode:_passwordTextField.text completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {

            MHForgetSecondVC *vc = [[MHForgetSecondVC alloc] init];
            vc.phone = self.phoneTextField.text;
            vc.smsCode = self.passwordTextField.text;
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            KLToast(response[@"message"]);
        }
    }];

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
    if (_passwordTextField.text.length > 4) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:4];
        
    }
    
    
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length >=4) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)backBtnClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
