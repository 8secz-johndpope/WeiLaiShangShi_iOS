//
//  MHYQVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHYQVC.h"
#import "UIImage+Common.h"

@interface MHYQVC ()

@property(strong,nonatomic)UITextField *yqTextField;
@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic) UIButton *loginBtn;

@end

@implementation MHYQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写邀请码";
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = _phoneStr;
    phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(self.view.mas_top).offset(kRealValue(50));
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.text = @"当前手机号未注册，需要绑定邀请码以完成注册";
    descLabel.font = [UIFont fontWithName:kPingFangLight size:kFontValue(12)];
    descLabel.textColor = [UIColor colorWithHexString:@"FB3131"];
    descLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(phoneLabel.mas_bottom).offset(kRealValue(8));
    }];
    
    _yqTextField = [UITextField new];
    _yqTextField.placeholder = @"输入邀请码*";
    _yqTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_yqTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_yqTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_yqTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_yqTextField];
    [_yqTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(descLabel.mas_bottom).offset(kRealValue(13));
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
    [_loginBtn setTitle:@"绑定" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#ff8900"];
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
    
    if (_yqTextField.text.length ==  0) {
        KLToast(@"请输入邀请码");
        return;
    }
    
//    [[MHUserService sharedInstance]initWithActive:ValidStr(_accessToken)?_accessToken:@""
//                                       userYQCode:ValidStr(_yqTextField.text)?_yqTextField.text:@""
//                                  completionBlock:^(NSDictionary *response, NSError *error) {
//                                      if (ValidResponseDict(response)) {
//                                          [GVUserDefaults standardUserDefaults].accessToken = _accessToken;
//                                          [GVUserDefaults standardUserDefaults].refreshToken = _refreshToken;
//                                          [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
//                                          UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
//                                          if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
//                                              
//                                              tabbarViewController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                              tabbarViewController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                              tabbarViewController.viewControllers[2].tabBarItem.title = @"升级店主";
//                                          }else{
//                                              tabbarViewController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                              tabbarViewController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                                              tabbarViewController.viewControllers[2].tabBarItem.title = @"店主";
//                                          }
//                                          [self dismissViewControllerAnimated:YES completion:nil];
//                                      }else{
//                                         KLToast(response[@"message"]);
//                                      }
//                                  }];
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
