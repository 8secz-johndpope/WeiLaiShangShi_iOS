//
//  MHForgetSecondVC.m
//  wgts
//
//  Created by AllenQin on 2018/11/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHForgetSecondVC.h"
#import "NSString+WZXSSLTool.h"

@interface MHForgetSecondVC ()


@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *loginBtn;


@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;


@end

@implementation MHForgetSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(kRealValue(28), kRealValue(10), kScreenWidth, kRealValue(50));
//    label.text = @"重置密码";
//    label.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(24)];
//    label.textColor = [UIColor colorWithHexString:@"#434343"];
//    label.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:label];
    
    self.title = @"设置新密码";
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入新密码";
    _phoneTextField.secureTextEntry = YES;
//    _phoneTextField.layer.masksToBounds = YES;
//    _phoneTextField.layer.cornerRadius = kRealValue(22);
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(44), kRealValue(54))];
//    view1.backgroundColor = [UIColor clearColor];
//    UIImageView *iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
//    iv1.center = view1.center;
////    [view1 addSubview:iv1];
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
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
//    _passwordTextField.layer.masksToBounds = YES;
//    _passwordTextField.layer.cornerRadius = kRealValue(22);
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"确认密码";
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(44), kRealValue(54))];
//    view2.backgroundColor = [UIColor clearColor];
//    UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
//    iv2.center = view2.center;
//    [view2 addSubview:iv2];
//    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
//    _passwordTextField.leftView = view2;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.left.equalTo(_phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(kRealValue(10));
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#BEBEBE"]] forState:UIControlStateDisabled];
    _loginBtn.layer.masksToBounds = YES;
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

- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 16) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:16];
        
    }
    //验证码 4位
    if (_passwordTextField.text.length > 16) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:16];
        
    }
    
    if (_phoneTextField.text.length >=6 && _passwordTextField.text.length >=6) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}

-(void)login{
    
    if (_phoneTextField.text.length >=0 && _phoneTextField.text.length < 6) {
        KLToast(@"请输入正确密码");
        return;
    }
    //
    if (_passwordTextField.text.length >=0 && _passwordTextField.text.length < 6) {
        KLToast(@"请输入正确密码");
        return;
    }
    
    [[MHUserService sharedInstance]initWithFixPassword:self.phone password:[_phoneTextField.text do16MD5] confirmPassword:[_passwordTextField.text do16MD5] smsCode:self.smsCode completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
             KLToast(@"设置成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
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




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)backBtnClicked{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
