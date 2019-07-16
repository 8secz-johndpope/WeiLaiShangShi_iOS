//
//  MHWithDrawVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawVC.h"
#import "MHWithDrawTitleCell.h"
#import "MHWithDrawMoneyCell.h"
#import "MHWithDrawPayCell.h"
#import "MHWithDrawListModel.h"
#import "MHAddWithDrawVC.h"
#import "CYPasswordView.h"
#import "MHRecordPresentViewController.h"
#import "MHRecordPresentStatuController.h"
#import "MHSetPsdVC.h"
#import "MHWithDrawRecordModel.h"
#import "HSWithDrawMoneyCell.h"
#import "HSAddAlipayController.h"
#import "HSWithDrawBankController.h"
#import "MHWithDrawMoneyCell.h"
#import "HSEditAlipayController.h"
#import "UIControl+BlocksKit.h"
#import "HSEditBankVC.h"
#import "MHWebviewViewController.h"


@interface MHWithDrawVC ()<UITableViewDelegate,UITableViewDataSource,HSWithDrawCellDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong) MHWithDrawListModel       *zfbModel;
@property (nonatomic, strong) MHWithDrawListModel       *yhkModel;
@property (nonatomic, assign) NSString     *selectIndex;
@property (nonatomic, assign) NSInteger     moneyIndex;
@property (nonatomic, strong) NSMutableDictionary    *mobiDict;
@property (nonatomic, strong) NSDictionary    *zfbDict;
@property (nonatomic, strong) NSDictionary    *yhkDict;
@property (nonatomic, strong) NSArray    *typeArr;
@property (nonatomic, strong) CYPasswordView *passwordView;
@end

@implementation MHWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = @"";
    _moneyIndex = -1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel) name:@"CYPasswordViewCancleButtonClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPWD) name:@"CYPasswordViewForgetPWDButtonClickNotification" object:nil];
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"提现规则" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
}


-(void)withDrawListClick{
    //提现规则
  MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/article/txrule.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"rule"];
  [self.navigationController pushViewController:vc animated:YES];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initWitAllTypesCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.typeArr = response[@"data"];
            [self.view addSubview:self.contentTableView];
            [self.view addSubview:self.btn];
            [[MHUserService sharedInstance]initwithHSRuleType:@"WITHDRAW_RULE" CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                   UILabel *label  =   [_contentTableView viewWithTag:8527];
                    label.text = response[@"data"];
                }
            }];
            
            [[MHUserService sharedInstance]initwithHSWithdrawListCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *listArr = [MHWithDrawListModel baseModelWithArr:response[@"data"]];
                    if ([listArr count]>0) {
                        [listArr enumerateObjectsUsingBlock:^(MHWithDrawListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj.bankType isEqualToString:@"BANK"]) {
                                [self.typeArr enumerateObjectsUsingBlock:^(NSString *type, NSUInteger idx, BOOL * _Nonnull stop) {
                                    if ([type isEqualToString:@"BANK"]) {
                                        self.yhkModel = obj;
                                    }
                                }];
                                
                            }else{
                                [self.typeArr enumerateObjectsUsingBlock:^(NSString *type, NSUInteger idx, BOOL * _Nonnull stop) {
                                    if ([type isEqualToString:@"ALIPAY"]) {
                                        self.zfbModel = obj;
                                    }
                                }];
                                
                            }
                        }];
                        if (self.zfbModel) {
                            self.selectIndex = @"ALIPAY";
                            self.moneyIndex = 0;
                        }else{
                            if (self.yhkModel) {
                                self.selectIndex = @"BANK";
                                self.moneyIndex = 0;
                            }else{
                                self.selectIndex = @"";
                                self.moneyIndex = -1;
                            }
                        }
                    }else{
                        self.zfbModel = nil;
                        self.yhkModel = nil;
                    }
                    if ([self.selectIndex isEqualToString:@"ALIPAY"]) {
                        [[MHUserService sharedInstance]initwithHSShopWithDrawMoneyList:@"ALIPAY_WITHDRAW" CompletionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)) {
                                self.zfbDict = response[@"data"];
                                [self.contentTableView reloadData];
                            }
                        }];
                    }else  if ([self.selectIndex isEqualToString:@"BANK"]) {
                        [[MHUserService sharedInstance]initwithHSShopWithDrawMoneyList:@"BANK_WITHDRAW" CompletionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)) {
                                self.yhkDict = response[@"data"];
                                [self.contentTableView reloadData];
                            }
                        }];
                    }else  {
                        [[MHUserService sharedInstance]initwithHSShopWithDrawMoneyList:@"ALIPAY_WITHDRAW" CompletionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)) {
                                self.zfbDict = response[@"data"];
                                [self.contentTableView reloadData];
                            }
                        }];
                    }
                }
            }];
        }
    }];
    

}

-(void)withDraw{

    if (_selectIndex.length == 0) {
        KLToast(@"请添加提现方式");
        return;
    }
    if (self.moneyIndex == -1) {
         KLToast(@"请添加提现方式");
    }
    
    UITextField *textfield  =    [_contentTableView viewWithTag:6666];
    if (!ValidStr(textfield.text) ) {
        KLToast(@"请输入金额");
        return;
    }
    if ([textfield.text doubleValue]<=0 ) {
        KLToast(@"提现金额须大于0");
        return;
    }
    
    if (self.selectIndex == 0) {
        NSArray *dictArr = self.zfbDict[@"money"];
        NSLog(@"%@",dictArr[self.moneyIndex]);
    }else{
        NSArray *dictArr = self.yhkDict[@"money"];
        NSLog(@"%@",dictArr[self.moneyIndex]);
    }
    
    
    
    [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.mobiDict  = response[@"data"];
            if ([[NSString stringWithFormat:@"%@",self.mobiDict [@"modifyPayPassword"]] isEqualToString:@"0"]) {
                MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
                vc.navtitle =@"设置资金密码";
                vc.dic = self.mobiDict;
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                
                self.passwordView = [[CYPasswordView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) WithMoneyStr:@"123"];
                self.passwordView.loadingText = @"余额提现中...";
                NSString *moneyStr;
                NSString *fee;
                if ([self.selectIndex isEqualToString:@"ALIPAY"]) {

                    self.passwordView.moneyStr = [NSString stringWithFormat:@"%@元",textfield.text];
                    moneyStr = [NSString stringWithFormat:@"%@",textfield.text];
                        fee  = [NSString stringWithFormat:@"%.2f",([moneyStr floatValue]*[self.zfbDict[@"rule"][@"ratio"] floatValue]) + [self.zfbDict[@"rule"][@"extra"] floatValue]];
//                    self.passwordView.feeStr = [NSString stringWithFormat:@"手续费：%@",fee];
                }else{
                    
                    self.passwordView.moneyStr = [NSString stringWithFormat:@"%@元",textfield.text];
                    moneyStr = [NSString stringWithFormat:@"%@",textfield.text];
                    fee = [NSString stringWithFormat:@"%.2f",([moneyStr floatValue]*[self.yhkDict[@"rule"][@"ratio"] floatValue]) + [self.yhkDict[@"rule"][@"extra"] floatValue]];
//                    self.passwordView.feeStr = [NSString stringWithFormat:@"手续费：%@",fee];
                }
           
                self.passwordView.title = @"余额提现";
                [self.passwordView showInView:self.view.window];
                kWeakSelf(self);
                self.passwordView.finish = ^(NSString *password) {
                    [weakself.passwordView hideKeyboard];

                    [[MHUserService sharedInstance]initwithWithdraw:moneyStr cardId: [self.selectIndex isEqualToString:@"ALIPAY"] ? [NSString stringWithFormat:@"%@",self.zfbModel.id]:[NSString stringWithFormat:@"%@",self.yhkModel.id] payPassword:password fee:fee  completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
//                            [weakself.passwordView requestComplete:YES message:@"支付成功"];
//                            [weakself.passwordView stopLoading];
                             KLToast(@"提现成功");
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                //push
                                [self.navigationController popViewControllerAnimated:YES];
//                                MHRecordPresentViewController *vc = [[MHRecordPresentViewController alloc]init];
//                                   [self.navigationController pushViewController:vc animated:YES]
//                           ;
                                [weakself.passwordView hide];
                            });
                        }else{
//                            [weakself.passwordView requestComplete:NO message:response[@"message"]];
//                            [weakself.passwordView stopLoading];
                             KLToast(response[@"message"]);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [weakself.passwordView hide];
                            });
                        }
                    }];

                };
            }

        }
    }];

}

-(UIButton *)btn{
    if (!_btn) {
        _btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(56), kScreenHeight - kTopHeight - kRealValue(50)-kBottomHeight, kScreenWidth - kRealValue(118), kRealValue(38))];
        _btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        _btn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = kRealValue(19);
        _btn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        [_btn addTarget:self action:@selector(withDraw) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"立即提现" forState:UIControlStateNormal];
    }
    return _btn;

}


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kRealValue(60), 0);
        [_contentTableView registerClass:[MHWithDrawTitleCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawTitleCell class])];
        [_contentTableView registerClass:[HSWithDrawMoneyCell class] forCellReuseIdentifier:NSStringFromClass([HSWithDrawMoneyCell class])];
        [_contentTableView registerClass:[MHWithDrawPayCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawPayCell class])];
        [_contentTableView registerClass:[MHWithDrawMoneyCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawMoneyCell class])];
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return  [self.typeArr  count];
    }
    return 1;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MHWithDrawTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawTitleCell class])];
        cell.moneyLabel.text = self.withDrawMoney;
        cell.maxString = self.withDrawMoney;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else if (indexPath.section == 2){
        MHWithDrawPayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawPayCell class])];
        
        if ([_typeArr[indexPath.row] isEqualToString:@"ALIPAY"]) {
            cell.leftImageView.image = kGetImage(@"ic_play_play");
            cell.titleLabel.text = @"支付宝";
            [cell.editBtn addTarget:self action:@selector(pushEditAlipay) forControlEvents:UIControlEventTouchUpInside];
            if (self.zfbModel) {
                cell.rightLabel.text = self.zfbModel.cardCode;
                cell.rightLabel.textColor = [UIColor colorWithHexString:@"222222"];
                cell.editBtn.hidden = NO;
                cell.rightImageView.hidden = YES;
            }else{
                cell.rightLabel.text = @"绑定后可提现";
                cell.rightLabel.textColor = [UIColor colorWithHexString:@"#999999"];
                cell.editBtn.hidden = YES;
                cell.rightImageView.hidden = NO;
            }
            
            if ([_selectIndex isEqualToString:@"ALIPAY"] ) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
        }else{
            cell.leftImageView.image = kGetImage(@"ic_play_unionPay");
            cell.titleLabel.text = @"银行卡";
            [cell.editBtn addTarget:self action:@selector(editBank) forControlEvents:UIControlEventTouchUpInside];
            if (self.yhkModel) {
                cell.rightLabel.text = self.yhkModel.bankName;
                cell.rightLabel.textColor = [UIColor colorWithHexString:@"222222"];
                cell.editBtn.hidden = NO;
                cell.rightImageView.hidden = YES;
            }else{
                cell.rightLabel.text = @"绑定后可提现";
                cell.rightLabel.textColor = [UIColor colorWithHexString:@"#999999"];
                cell.editBtn.hidden = YES;
                cell.rightImageView.hidden = NO;
            }
            
            if ([_selectIndex isEqualToString:@"BANK"] ) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
        }


        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        MHWithDrawMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawMoneyCell class])];
        cell.maxString = self.withDrawMoney;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
}

-(void)pushEditAlipay{
    //
    HSEditAlipayController *vc  = [[HSEditAlipayController alloc] initWithName:self.zfbModel.realName userId:self.zfbModel.id];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
        if ([_typeArr[indexPath.row] isEqualToString:@"ALIPAY"]) {
            if (_zfbModel) {
                _selectIndex = @"ALIPAY";
                self.moneyIndex = 0;
                [[MHUserService sharedInstance]initwithHSShopWithDrawMoneyList:@"ALIPAY_WITHDRAW" CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        self.zfbDict = response[@"data"];
                        [self.contentTableView reloadData];
                    }
                }];
               
            }else{
                //开通支付宝
                HSAddAlipayController *vc  = [[HSAddAlipayController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }

        }else{
            if (_yhkModel) {
                _selectIndex = @"BANK";
                self.moneyIndex = 0;
                [[MHUserService sharedInstance]initwithHSShopWithDrawMoneyList:@"BANK_WITHDRAW" CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        self.yhkDict = response[@"data"];
                        [self.contentTableView reloadData];
                    }
                }];
            }else{
                //开通银行卡
                HSWithDrawBankController *vc  = [[HSWithDrawBankController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        bgView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:bgView];
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"#222222"];
        titlesLabel.text  = @"提现金额";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(11));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(14));
        }];
        
        return headerView;
    }else  if (section == 2) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        bgView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:bgView];
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"#222222"];
        titlesLabel.text  = @"提现方式";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(11));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(14));
        }];
        
        return headerView;
    }
    return nil;
}


//-(void)changeState:(UIButton *)sender{
//    _editState = !_editState;
//    sender.selected = _editState;
//    [UIView performWithoutAnimation:^{
//        [self.contentTableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//
//    }];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 ||section == 2) {
        return kRealValue(50);
    }else{
        return kRealValue(10);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      return kRealValue(44);
    }else if (indexPath.section == 1){
      return kRealValue(100);
    }else if (indexPath.section == 2){
        return kRealValue(44);
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return kRealValue(10);
    }else{
         return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
        headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        return headerView;
    }else{
        return nil;
    }

}


-(void)clickBtnValues:(NSInteger)value{
    
     self.moneyIndex = value;
//    if (self.selectIndex isEqualToString:@) {
//
//
////        NSArray *dictArr = self.zfbDict[@"money"];
////        NSLog(@"%@",dictArr[value]);
//    }else{
//        self.moneyIndex = value;
////        NSArray *dictArr = self.yhkDict[@"money"];
////        NSLog(@"%@",dictArr[value]);
//    }
}

-(void)addWithDraw{
    MHAddWithDrawVC *VC = [[MHAddWithDrawVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}



-(void)editBank{
    
    HSEditBankVC *VC = [[HSEditBankVC alloc]initWithModel:self.yhkModel];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cancel {
    MHLog(@"关闭密码框");
    //    [MBProgressHUD showSuccess:@"关闭密码框"];
}

- (void)forgetPWD {
    MHLog(@"忘记密码");
    [self.passwordView hide];
    MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
    vc.navtitle =@"修改资金密码";
    vc.dic = self.mobiDict;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
