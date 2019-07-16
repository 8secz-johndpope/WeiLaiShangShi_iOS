//
//  HSWithDrawBankController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSEditBankVC.h"
#import "MHAddWithDrawnomalCell.h"
#import "MHAddWithDrawyzCell.h"
#import "MHAddWithDrawyzmCell.h"
#import "MHAddWithDrawBankCell.h"
#import "MHPickView.h"
#import "HSAddAreaCell.h"
#import "BRPickerView.h"


@interface HSEditBankVC ()

@property(nonatomic,copy)NSString *areaCode;

@property(nonatomic,copy)NSString *bankCode;

@property(strong,nonatomic) MHAddWithDrawnomalCell *cell28;

@property(strong,nonatomic)MHWithDrawListModel * model;

@end

@implementation HSEditBankVC


-(instancetype)initWithModel:(MHWithDrawListModel *)model{
    self = [super init];
    if (self) {
        self.model  = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改银行卡";
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"银行卡信息";
    titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    [self.view  addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(kRealValue(10));
        make.left.equalTo(self.view.mas_left).with.offset(kRealValue(12));
    }];
    
    
    //    UILabel *descLabel = [[UILabel alloc] init];
    //    descLabel.text = @"（提现金额＞100元）";
    //    descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    //    descLabel.textColor = [UIColor colorWithHexString:@"#F32B2B"];
    //    [self.view  addSubview:descLabel];
    //    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.equalTo(titleLabel.mas_centerY).with.offset(0);
    //        make.left.equalTo(titleLabel.mas_right).with.offset(kRealValue(5));
    //    }];
    
    
    self.cell28 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(42), kScreenWidth, kRealValue(44))];
    self.cell28.numberTextField.text = self.model.realName;
    self.cell28.numberTextField.tag = 6022;
    self.cell28.numberTextField.delegate = self;
    [self.view addSubview: self.cell28];
    
    
    MHAddWithDrawBankCell *cell20 = [[MHAddWithDrawBankCell alloc]initWithFrame:CGRectMake(0, kRealValue(86), kScreenWidth, kRealValue(44))];
    cell20.contentLabel.textColor = [UIColor blackColor];
    cell20.contentLabel.text = self.model.bankName;
    cell20.contentLabel.tag = 6000;
    [self.view addSubview:cell20];
    
    
    HSAddAreaCell*cell23 = [[HSAddAreaCell alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(44))];
    cell23.contentLabel.textColor = [UIColor blackColor];
    cell23.contentLabel.text = self.model.bankAccount;
    cell23.contentLabel.tag = 6050;
    [self.view addSubview:cell23];
    
    MHAddWithDrawnomalCell *cell27 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(174), kScreenWidth, kRealValue(44))];
    cell27.titleLabel.text = @"开户行支行";
    cell27.numberTextField.placeholder = @"请输入开户行名称";
    cell27.numberTextField.tag = 6021;
    [self.view addSubview:cell27];
    
    

    
    
    MHAddWithDrawnomalCell *cell7 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(218), kScreenWidth, kRealValue(44))];
    cell7.titleLabel.text = @"银行卡号";
    cell7.numberTextField.placeholder = @"请输入银行卡号";
    cell7.numberTextField.tag = 6001;
    [self.view addSubview:cell7];
    
    MHAddWithDrawyzmCell *cell29 = [[MHAddWithDrawyzmCell alloc]initWithFrame:CGRectMake(0, kRealValue(262), kScreenWidth, kRealValue(44))];
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
    [self.view addSubview:cell29];
    
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(320), kScreenWidth - kRealValue(24), kRealValue(44))];
    btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    btn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(2);
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.cell28.numberTextField) {
        return NO;
    }else{
        return YES;
    }
}


-(void)add{
    
    
    UILabel *bankName  =    [self.view viewWithTag:6000];
    UILabel *areaName  =    [self.view viewWithTag:6050];
    UITextField *namenumber =    [self.view viewWithTag:6022];
    UITextField *banknumber  =    [self.view viewWithTag:6001];
    UITextField *yzmnumber  =    [self.view viewWithTag:6024];
    UITextField *kaihuhangText  =  [self.view viewWithTag:6021];
    
    if (kaihuhangText.text.length == 0) {
        KLToast(@"请输入开户行名称!");
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
    
    [[MHUserService sharedInstance]initwitheditWithdraw:self.model.id cardCode:banknumber.text verifyCode:yzmnumber.text withdrawType:@"BANK" bankAccount:areaName.text bankName:bankName.text bankCode:self.bankCode areaCode:self.areaCode bankSubAccount:kaihuhangText.text completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [MBProgressHUD hideHUD];
            KLToast(@"修改成功");
            
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
