//
//  MHPhoneLoginVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHFixPhoneTwoVC.h"
#import "JKCountDownButton.h"
#import "UIImage+Common.h"
#import "MHYQVC.h"

@interface MHFixPhoneTwoVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) JKCountDownButton *countDownCode;

@end

@implementation MHFixPhoneTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"手机号更换";
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(28), kRealValue(30), kScreenWidth, kRealValue(25))];
    label1.text = @"绑定新手机号";
    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label1];
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入新的手机号";
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
    _passwordTextField.placeholder = @"请输入验证码";
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
        if (klStringisEmpty(self.phoneTextField.text)) {
            KLToast(@"手机号为空");
            return ;
        }
          sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(self.phoneTextField.text)?self.phoneTextField.text:@""
                                                  scene:@"UPDATE_PHONE"
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
    
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(-1);
    }];
    
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(self.passwordTextField.mas_bottom).offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"确定绑定" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FF3344"];
    [self.view addSubview:_loginBtn];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(_passwordLineView.mas_bottom).offset(kRealValue(25));
    }];
    
    
}

- (void)login{
    if (klStringisEmpty(self.phoneTextField.text)) {
        KLToast(@"手机号为空");
        return ;
    }
    if (klStringisEmpty(self.passwordTextField.text)) {
        KLToast(@"验证码为空");
        return ;
    }
    [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"UPDATE_USER_PHONE" userNickname:@"" userImage:@"" openId:@"" unionId:@"" originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:self.phoneTextField.text newUserPhoneCode:self.passwordTextField.text newPayPassword:@"" newConfirmPassword:@"" newPayPasswordCode:@"" isOldPhone:NO CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"换绑成功");
                    if (self.navigationController.viewControllers.count >= 2) {
                        UIViewController *viewvc =self.navigationController.viewControllers[1];
                        [self.navigationController popToViewController:viewvc animated:YES];
                    }else{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                  
                }else{
                    KLToast(@"验证失败,请重新验证");
                }
            }];
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else{
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
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
