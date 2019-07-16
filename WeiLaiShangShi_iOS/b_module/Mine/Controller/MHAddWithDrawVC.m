//
//  MHAddWithDrawVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawVC.h"
#import "MHSumbitCouponCell.h"
#import "MHAddWithDrawnomalCell.h"
#import "MHAddWithDrawyzCell.h"
#import "MHAddWithDrawyzmCell.h"
#import "MHAddWithDrawBankCell.h"
#import "MHPickView.h"

@interface MHAddWithDrawVC ()

@property (nonatomic, strong) UIView        *alipayView;
@property (nonatomic, strong) UIView        *bankView;
@property (nonatomic, strong) UILabel       *lineLabel;
@property (nonatomic, assign) NSInteger     selectPay;

@end

@implementation MHAddWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加提现方式";

    UIButton *alipayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, kRealValue(49))];
    [alipayBtn setImage:[UIImage imageNamed:@"withdraw_zhifubao"] forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"withdraw_zhifubao"] forState:UIControlStateHighlighted];
    [alipayBtn setTitle:@"  支付宝" forState:UIControlStateNormal];
    [alipayBtn addTarget:self action:@selector(alipayClick:) forControlEvents:UIControlEventTouchUpInside];
    [alipayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    alipayBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(16)];
    [self.view addSubview:alipayBtn];
    
    UIButton *bankBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, kRealValue(49))];
    [bankBtn setImage:[UIImage imageNamed:@"withdraw_bank"] forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"withdraw_bank"] forState:UIControlStateHighlighted];
    [bankBtn setTitle:@"  银行卡" forState:UIControlStateNormal];
    [bankBtn addTarget:self action:@selector(bankpayClick:) forControlEvents:UIControlEventTouchUpInside];
    [bankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bankBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(16)];
    [self.view addSubview:bankBtn];
    
    _selectPay = 0;
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth/4, kRealValue(2))];
    self.lineLabel.backgroundColor = [UIColor colorWithHexString:@"#FF3344"];
    [self.view addSubview:self.lineLabel];
    self.lineLabel.centerX  = alipayBtn.centerX;
    
    
    self.alipayView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(49), kScreenWidth, kRealValue(218))];
    self.alipayView.backgroundColor = [UIColor redColor];
    self.alipayView.hidden = NO;
    UIView *headView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
    headView1.backgroundColor = kBackGroudColor;
    [self.alipayView addSubview:headView1];
    
    UILabel *headLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
    headLabel1.text = @"请填写您的支付宝信息";
    headLabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    headLabel1.textColor = [UIColor colorWithHexString:@"999999"];
    [headView1 addSubview: headLabel1];
    [self.view addSubview:self.alipayView];
    
    MHAddWithDrawnomalCell *cell1 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(42), kScreenWidth, kRealValue(44))];;
    cell1.titleLabel.text = @"支付宝账号";
    cell1.numberTextField.keyboardType = UIKeyboardTypeASCIICapable;
    cell1.numberTextField.placeholder = @"请输入支付宝账户";
    cell1.numberTextField.tag = 6003;
    [self.alipayView addSubview:cell1];
    
    MHAddWithDrawnomalCell *cell2 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(86), kScreenWidth, kRealValue(44))];
    cell2.titleLabel.text = @"真实姓名";
    cell2.numberTextField.placeholder = @"支付宝绑定实名";
    cell2.numberTextField.keyboardType = UIKeyboardTypeDefault;
    cell2.numberTextField.tag = 6008;
    [self.alipayView addSubview:cell2];
    
    MHAddWithDrawyzCell *cell3 = [[MHAddWithDrawyzCell alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(44))];
    cell3.titleLabel.text = @"验证手机号";
    [self.alipayView addSubview:cell3];
    
    MHAddWithDrawyzmCell *cell4 = [[MHAddWithDrawyzmCell alloc]initWithFrame:CGRectMake(0, kRealValue(174), kScreenWidth, kRealValue(44))];
    cell4.numberTextField.tag = 6004;
    [cell4.countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:[GVUserDefaults standardUserDefaults].phone
                                                  scene:@"WITHDRAW"
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
    [self.alipayView addSubview:cell4];
    
    
    
    
    
    self.bankView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(49), kScreenWidth, kRealValue(306))];
    self.bankView.backgroundColor = [UIColor whiteColor];
    self.bankView.hidden = YES;
    UIView *headView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
    headView2.backgroundColor = kBackGroudColor;
    [self.bankView addSubview:headView2];
    
    UILabel *headLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
    headLabel2.text = @"请填写您的银行卡信息";
    headLabel2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    headLabel2.textColor = [UIColor colorWithHexString:@"999999"];
    [headView2 addSubview: headLabel2];

    [self.view addSubview:self.bankView];
    
    MHAddWithDrawBankCell *cell20 = [[MHAddWithDrawBankCell alloc]initWithFrame:CGRectMake(0, kRealValue(42), kScreenWidth, kRealValue(44))];
    cell20.selectClick = ^{
        MHPickView *pick = [[MHPickView alloc]initWithComponentArr:@[@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",@"交通银行",@"中国邮政储蓄银行",@"招商银行",@"上海浦东发展银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行",@"广发银行",@"兴业银行",@"平安银行",@"浙商银行",@"恒丰银行",@"渤海银行",@"南京银行"]];
         pick.titleLabel.text = @"选择银行";
        pick.sureBlock = ^(NSString *text,NSInteger index){
            cell20.contentLabel.textColor = [UIColor blackColor];
            cell20.contentLabel.text = text;
            cell20.contentLabel.tag = 6000;
        };
        [self.view addSubview:pick];
    };
    [self.bankView addSubview:cell20];
    
    MHAddWithDrawnomalCell *cell27 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(86), kScreenWidth, kRealValue(44))];
    cell27.titleLabel.text = @"开户行名称";
    cell27.numberTextField.placeholder = @"请输入开户行名称";
    cell27.numberTextField.tag = 6021;
    [self.bankView addSubview:cell27];
    
    
    MHAddWithDrawnomalCell *cell28 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(44))];
    cell28.titleLabel.text = @"持卡人姓名";
    cell28.numberTextField.placeholder = @"请输入持卡人姓名";
    cell28.numberTextField.tag = 6022;
    [self.bankView addSubview:cell28];
    

    MHAddWithDrawnomalCell *cell7 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(174), kScreenWidth, kRealValue(44))];
    cell7.titleLabel.text = @"银 行 卡 号";
    cell7.numberTextField.placeholder = @"请输入银行卡号";
    cell7.numberTextField.tag = 6001;
    [self.bankView addSubview:cell7];
    
    MHAddWithDrawyzmCell *cell29 = [[MHAddWithDrawyzmCell alloc]initWithFrame:CGRectMake(0, kRealValue(218), kScreenWidth, kRealValue(44))];
    cell29.numberTextField.tag = 6024;
    [cell29.countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        [[MHUserService sharedInstance]initWithSendCode:[GVUserDefaults standardUserDefaults].phone
                                                  scene:@"WITHDRAW"
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
    [self.bankView addSubview:cell29];
    
    
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(300), kScreenWidth - kRealValue(24), kRealValue(44))];
    btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    btn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(2);
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认添加" forState:UIControlStateNormal];
    [self.view addSubview:btn];

}




- (void)alipayClick:(UIButton *)sender{
    _selectPay = 0;
    [self.view endEditing:YES];
    self.alipayView.hidden = NO;
    self.bankView.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
         self.lineLabel.centerX  = sender.centerX;
    }];

}


- (void)bankpayClick:(UIButton *)sender{
    _selectPay = 1;
    [self.view endEditing:YES];
    self.alipayView.hidden = YES;
    self.bankView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.lineLabel.centerX  = sender.centerX;
    }];
}


-(void)add{
    if (_selectPay == 0) {
        
        
        UITextField *zfbnumber  =   [self.view viewWithTag:6003];
        UITextField *yzmnumber  =   [self.view viewWithTag:6004];
        UITextField *namenumber  =  [self.view viewWithTag:6008];
        if (zfbnumber.text.length == 0) {
            KLToast(@"支付宝账号不能为空!");
            return;
        }
        if (namenumber.text.length == 0) {
            KLToast(@"请输入支付宝绑定的真实姓名!");
            return;
        }
        if (yzmnumber.text.length != 4) {
            KLToast(@"请输入正确的验证码!");
            return;
        }
        
        [MBProgressHUD showActivityMessageInWindow:@""];
        
        [[MHUserService sharedInstance]initwithAddWithdraw:namenumber.text cardCode:zfbnumber.text verifyCode:yzmnumber.text withdrawType:@"1" bankAccount:@"" bankName:@"" bankCode:@"" areaCode:@"" bankSubAccount:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    [MBProgressHUD hideHUD];
                    KLToast(@"添加成功");
    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [MBProgressHUD hideHUD];
                    KLToast(response[@"message"]);
                }
                if (error) {
                    [MBProgressHUD hideHUD];
                }
        }];

    }else{
        
        
        UILabel *bankName  =    [self.view viewWithTag:6000];
        UITextField *namenumber =    [self.view viewWithTag:6022];
        UITextField *banknumber  =    [self.view viewWithTag:6001];
        UITextField *yzmnumber  =    [self.view viewWithTag:6024];
        UITextField *kaihuhangText  =  [self.view viewWithTag:6021];
        if (bankName.text.length == 0) {
            KLToast(@"请选择银行！");
            return;
        }
        if (kaihuhangText.text.length == 0) {
            KLToast(@"请输入开户行名称!");
            return;
        }
        if (namenumber.text.length == 0) {
            KLToast(@"请输入银行卡绑定的真实姓名!");
            return;
        }
        if (banknumber.text.length == 0) {
            KLToast(@"请输入银行卡卡号!");
            return;
        }
        if (yzmnumber.text.length != 4) {
            KLToast(@"请输入正确的验证码!");
            return;
        }
        
        [MBProgressHUD showActivityMessageInWindow:@""];
        
//        [[MHUserService sharedInstance]initwithAddWithdraw:namenumber.text cardCode:banknumber.text verifyCode:yzmnumber.text withdrawType:@"0" bankAccount:kaihuhangText.text bankName:bankName.text bankCode:@"" areaCode:@"" completionBlock:^(NSDictionary *response, NSError *error) {
//            if (ValidResponseDict(response)) {
//                [MBProgressHUD hideHUD];
//                KLToast(@"添加成功");
//
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                [MBProgressHUD hideHUD];
//                KLToast(response[@"message"]);
//            }
//            if (error) {
//                [MBProgressHUD hideHUD];
//            }
//        }];
    }
    
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
