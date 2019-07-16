//
//  MHFixPhoneVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHFixPhoneOneVC.h"
#import "JKCountDownButton.h"
#import "UIImage+Common.h"
#import "MHFixPhoneTwoVC.h"

@interface MHFixPhoneOneVC ()

@property(strong,nonatomic)UITextField *phoneTextField;


@property (strong, nonatomic)UIView *phoneLineView;


@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) JKCountDownButton *countDownCode;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong)NSMutableDictionary *dic;
@end

@implementation MHFixPhoneOneVC

- (instancetype)initWithModel:(NSMutableDictionary *)userInfo
{
    self = [super init];
    if (self) {
      self.dic = userInfo;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"手机号更换";
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(28), kRealValue(30), kScreenWidth, kRealValue(25))];
    label1.text = @"验证原手机号";
    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label1];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(28), kRealValue(68), kScreenWidth, kRealValue(25))];
    self.textLabel.text = @"";
    self.textLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.textLabel];
    
    if (!klObjectisEmpty(self.dic) ) {
        self.textLabel.text = [self.dic valueForKey:@"userPhone"];
    }
    
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入验证码";
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
        make.bottom.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        if (klStringisEmpty(self.textLabel.text)) {
            KLToast(@"手机号为空");
            return ;
        }
        sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(self.textLabel.text)?self.textLabel.text:@""
                                                  scene:@"VALIDATE_PHONE"
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
        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(-2);
    }];
    
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
     _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FF3344"];
    [self.view addSubview:_loginBtn];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(_phoneLineView.mas_bottom).offset(kRealValue(25));
    }];
    

    
    
}

- (void)login{
  
    if (klStringisEmpty(self.textLabel.text)) {
        KLToast(@"手机号为空");
        return ;
    }
    if (klStringisEmpty(self.phoneTextField.text)) {
        KLToast(@"验证码为空");
        return ;
    }
    [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"UPDATE_USER_PHONE" userNickname:@"" userImage:@"" openId:@"" unionId:@"" originUserPhone:self.textLabel.text originUserPhoneCode:self.phoneTextField.text newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:@"" newConfirmPassword:@"" newPayPasswordCode:@"" isOldPhone:NO CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            MHFixPhoneTwoVC *vc = [[MHFixPhoneTwoVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
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
    }
}

- (void)editDidEnd:(UITextField *)sender {
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
    if (_phoneTextField.text.length > 4) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:4];
        
    }
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
