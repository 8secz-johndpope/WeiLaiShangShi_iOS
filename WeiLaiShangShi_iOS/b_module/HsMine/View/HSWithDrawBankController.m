//
//  HSWithDrawBankController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWithDrawBankController.h"
#import "MHAddWithDrawnomalCell.h"
#import "MHAddWithDrawyzCell.h"
#import "MHAddWithDrawyzmCell.h"
#import "MHAddWithDrawBankCell.h"
#import "MHPickView.h"
#import "HSAddAreaCell.h"
#import "BRPickerView.h"


@interface HSWithDrawBankController ()

@property(nonatomic,copy)NSString *areaCode;

@property(nonatomic,copy)NSString *bankCode;

@end

@implementation HSWithDrawBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定银行卡";
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
    
    
   
    MHAddWithDrawnomalCell *cell28 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(42), kScreenWidth, kRealValue(44))];
    cell28.titleLabel.text = @"持卡人姓名";
    cell28.numberTextField.placeholder = @"请输入持卡人姓名";
    cell28.numberTextField.tag = 6022;
    [self.view addSubview:cell28];
    
    
    MHAddWithDrawBankCell *cell20 = [[MHAddWithDrawBankCell alloc]initWithFrame:CGRectMake(0, kRealValue(86), kScreenWidth, kRealValue(44))];
    cell20.selectClick = ^{
        [self.view endEditing:YES];
        if ([GVUserDefaults standardUserDefaults].bankCode) {
            NSArray *arr  = [GVUserDefaults standardUserDefaults].bankCode;
            NSMutableArray *bankNameArr  = [NSMutableArray array];
            NSMutableArray *bankcodeArr  = [NSMutableArray array];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [bankNameArr addObject:obj[@"bankName"]];
                [bankcodeArr addObject:obj[@"bankCode"]];
            }];
            MHPickView *pick = [[MHPickView alloc]initWithComponentArr:bankNameArr];
            pick.titleLabel.text = @"选择银行";
            pick.sureBlock = ^(NSString *text,NSInteger index){
//                NSArray *maArr = @[@"ICBC",@"ABC",@"BOC",@"CCB",@"BOCO",@"PSBC",@"CMBCHINA",@"SPDB",@"ECITIC",@"CEB",@"HXB",@"CMBC",@"CGB",@"CIB",@"SDB",@"CZ",@"EGB",@"CBHB",@"NJYH"];
                self.bankCode = bankcodeArr[index];
                cell20.contentLabel.textColor = [UIColor blackColor];
                cell20.contentLabel.text = text;
                cell20.contentLabel.tag = 6000;
            };
            [self.view addSubview:pick];
        }else{
            [[MHUserService sharedInstance]initwithBankListCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *arr  = response[@"data"];
                    NSMutableArray *bankNameArr  = [NSMutableArray array];
                    NSMutableArray *bankcodeArr  = [NSMutableArray array];
                    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [bankNameArr addObject:obj[@"bankName"]];
                        [bankcodeArr addObject:obj[@"bankCode"]];
                    }];
                    MHPickView *pick = [[MHPickView alloc]initWithComponentArr:bankNameArr];
                    pick.titleLabel.text = @"选择银行";
                    pick.sureBlock = ^(NSString *text,NSInteger index){
                        //                NSArray *maArr = @[@"ICBC",@"ABC",@"BOC",@"CCB",@"BOCO",@"PSBC",@"CMBCHINA",@"SPDB",@"ECITIC",@"CEB",@"HXB",@"CMBC",@"CGB",@"CIB",@"SDB",@"CZ",@"EGB",@"CBHB",@"NJYH"];
                        self.bankCode = bankcodeArr[index];
                        cell20.contentLabel.textColor = [UIColor blackColor];
                        cell20.contentLabel.text = text;
                        cell20.contentLabel.tag = 6000;
                    };
                    [self.view addSubview:pick];
                }
            }];
        }
        

    };
    [self.view addSubview:cell20];
    
    
    HSAddAreaCell*cell23 = [[HSAddAreaCell alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(44))];
    cell23.selectClick = ^{
//        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//        NSString *filePath = [bundle pathForResource:@"category" ofType:@"plist"];
         [self.view endEditing:YES];
        if ([GVUserDefaults standardUserDefaults].areaList) {
            NSArray *dataSource =  [GVUserDefaults standardUserDefaults].areaList;
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
                NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
                NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
                NSLog(@"code%@", area.code);
                NSLog(@"--------------------");
                
                cell23.contentLabel.textColor = [UIColor blackColor];
                cell23.contentLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
                cell23.contentLabel.tag = 6050;
                self.areaCode = [NSString stringWithFormat:@"%@,%@,%@",province.code,city.code,area.code];
            } cancelBlock:^{
                NSLog(@"点击了背景视图或取消按钮");
            }];
        }else{
            [[MHUserService sharedInstance]initwithCityListCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    [GVUserDefaults standardUserDefaults].areaList = response[@"data"];
                    NSArray *dataSource =  [GVUserDefaults standardUserDefaults].areaList;
                    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                        NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
                        NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
                        NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
                        NSLog(@"code%@", area.code);
                        NSLog(@"--------------------");
                        
                        cell23.contentLabel.textColor = [UIColor blackColor];
                        cell23.contentLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
                        cell23.contentLabel.tag = 6050;
                        self.areaCode = [NSString stringWithFormat:@"%@,%@,%@",province.code,city.code,area.code];
                    } cancelBlock:^{
                        NSLog(@"点击了背景视图或取消按钮");
                    }];
                }
            }];
        }
        
 
        
    };
    [self.view addSubview:cell23];
    
    MHAddWithDrawnomalCell *cell27 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(174), kScreenWidth, kRealValue(44))];
    cell27.titleLabel.text = @"开户行支行";
    cell27.numberTextField.placeholder = @"请输入开户行名称";
    cell27.numberTextField.tag = 6021;
    [self.view addSubview:cell27];
    
    
    
    
    
    MHAddWithDrawnomalCell *cell7 = [[MHAddWithDrawnomalCell alloc]initWithFrame:CGRectMake(0, kRealValue(218), kScreenWidth, kRealValue(44))];
    cell7.titleLabel.text = @"银行卡号";
    cell7.numberTextField.placeholder = @"请输入银行卡号";
    cell7.numberTextField.keyboardType = UIKeyboardTypePhonePad;
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
    [btn setTitle:@"确认添加" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
}
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}


-(void)add{
    
    
    UILabel *bankName  =    [self.view viewWithTag:6000];
    UILabel *areaName  =    [self.view viewWithTag:6050];
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
    if (![self isPureInt:banknumber.text]) {
        KLToast(@"银行卡卡号必须是纯数字!");
        return;
    }
    
    if (yzmnumber.text.length != 4) {
        KLToast(@"请输入正确的验证码!");
        return;
    }
    if (self.areaCode.length == 0) {
        KLToast(@"请输入正确的地区!");
        return;
    }
    if (self.bankCode.length == 0) {
        KLToast(@"请输入正确的银行!");
        return;
    }
   
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    
    [[MHUserService sharedInstance]initwithAddWithdraw:namenumber.text cardCode:banknumber.text verifyCode:yzmnumber.text withdrawType:@"BANK" bankAccount:areaName.text bankName:bankName.text bankCode:self.bankCode areaCode:self.areaCode bankSubAccount:kaihuhangText.text completionBlock:^(NSDictionary *response, NSError *error) {
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
