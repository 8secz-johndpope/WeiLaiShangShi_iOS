//
//  MHWechatYQVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWechatYQVC.h"
#import "UIImage+Common.h"

@interface MHWechatYQVC ()

@property(strong,nonatomic)UITextField *yqTextField;
@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic) UIButton *loginBtn;


@end

@implementation MHWechatYQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写邀请码";
//    UILabel *phoneLabel = [[UILabel alloc] init];
//    phoneLabel.text = _phone;
//    phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
//    phoneLabel.textColor = [UIColor blackColor];
//    phoneLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:phoneLabel];
//    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.top.equalTo(self.view.mas_top).offset(kRealValue(50));
//    }];
//
//    UILabel *descLabel = [[UILabel alloc] init];
//    descLabel.text = @"当前手机号未注册，需要绑定邀请码以完成注册";
//    descLabel.font = [UIFont fontWithName:kPingFangLight size:kFontValue(12)];
//    descLabel.textColor = [UIColor colorWithHexString:@"FB3131"];
//    descLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:descLabel];
//    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.width.mas_equalTo(kRealValue(320));
//        make.top.equalTo(phoneLabel.mas_bottom).offset(kRealValue(8));
//    }];
//
    _yqTextField = [UITextField new];
    _yqTextField.placeholder = @"填写邀请码";
    _yqTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_yqTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_yqTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_yqTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_yqTextField];
    [_yqTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
         make.top.equalTo(self.view.mas_top).offset(kRealValue(50));
    }];
    
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_yqTextField.mas_bottom).offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#F6AC19"];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(350));
        make.top.equalTo(_phoneLineView.mas_bottom).offset(kRealValue(25));
    }];
    
    
}

-(void)login{
     [self.view endEditing:YES];
    if (_yqTextField.text.length ==  0) {
        KLToast(@"请输入正确的邀请码");
        return;
    }
     [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance]initWithThirdBindPhone:ValidStr(self.phone)?self.phone:@""
                                                  smsCode:ValidStr(self.smsCode)?self.smsCode:@""
                                               userYQCode:ValidStr(_yqTextField.text)?_yqTextField.text:@""
                                                      uid:_uid
                                                  unionid:_unionid
                                          completionBlock:^(NSDictionary *response, NSError *error) {
                                              if (ValidResponseDict(response)) {
                                                  if ([response[@"data"][@"expand"] integerValue]== 0) {
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewReward" object:nil userInfo:nil];
                                                  }
                                                  [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                                                  [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                                                  [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                                               
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                    [MBProgressHUD hideHUD];
                                              }else{
                                                  KLToast(response[@"message"]);
                                                     [MBProgressHUD hideHUD];
                                              }
                                              if (error) {
                                                  [MBProgressHUD hideHUD];
                                              }
                                          }];
}

#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
}

- (void)editDidEnd:(UITextField *)sender {
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
