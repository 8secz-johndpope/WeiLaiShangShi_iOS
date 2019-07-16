//
//  HSAddAlipayController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSAddAlipayController.h"
#import "MHAddWithDrawnomalCell.h"
#import "MHAddWithDrawyzCell.h"
#import "MHAddWithDrawyzmCell.h"
#import "MHAddWithDrawBankCell.h"

@interface HSAddAlipayController ()

@end

@implementation HSAddAlipayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"绑定支付宝";
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"支付宝信息";
    titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    [self.view  addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(kRealValue(10));
        make.left.equalTo(self.view.mas_left).with.offset(kRealValue(12));
    }];
    
    
//    UILabel *descLabel = [[UILabel alloc] init];
//    descLabel.text = @"（提现金额≤100元）";
//    descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//    descLabel.textColor = [UIColor colorWithHexString:@"#F32B2B"];
//    [self.view  addSubview:descLabel];
//    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(titleLabel.mas_centerY).with.offset(0);
//        make.left.equalTo(titleLabel.mas_right).with.offset(kRealValue(5));
//    }];
//
    MHAddWithDrawnomalCell *cell1 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(42), kScreenWidth, kRealValue(44))];;
    cell1.titleLabel.text = @"绑定实名";
    cell1.numberTextField.placeholder = @"支付宝绑定实名";
    cell1.numberTextField.keyboardType = UIKeyboardTypeDefault;
    cell1.numberTextField.tag = 6008;
    [self.view addSubview:cell1];
    
    MHAddWithDrawnomalCell *cell2 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(86), kScreenWidth, kRealValue(44))];
    cell2.titleLabel.text = @"支付宝账号";
    cell2.numberTextField.keyboardType = UIKeyboardTypeASCIICapable;
    cell2.numberTextField.placeholder = @"请输入支付宝账户";
    cell2.numberTextField.tag = 6003;
    [self.view addSubview:cell2];
    
    
    MHAddWithDrawyzmCell *cell4 = [[MHAddWithDrawyzmCell alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(44))];
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
    [self.view addSubview:cell4];
    
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(190), kScreenWidth - kRealValue(24), kRealValue(44))];
    btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    btn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(2);
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认添加" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
}

-(void)add{
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
    
    [[MHUserService sharedInstance]initwithAddWithdraw:namenumber.text cardCode:zfbnumber.text verifyCode:yzmnumber.text withdrawType:@"ALIPAY" bankAccount:@"" bankName:@"" bankCode:@"" areaCode:@"" bankSubAccount:@""  completionBlock:^(NSDictionary *response, NSError *error) {
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
}


@end
