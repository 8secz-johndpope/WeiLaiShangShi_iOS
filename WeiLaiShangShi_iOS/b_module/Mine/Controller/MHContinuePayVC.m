//
//  MHContinuePayVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHContinuePayVC.h"
#import "MHSumbitCouponCell.h"
#import "RichStyleLabel.h"
#import "MHPayClass.h"
#import "CYPasswordView.h"
#import "MHPayResultVC.h"
#import "MHSetPsdVC.h"

@interface MHContinuePayVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger  selectPay;

@property (nonatomic, strong) CYPasswordView *passwordView;

@property (nonatomic,copy) NSArray  *picArr;

@property (nonatomic,copy) NSArray  *titleArr;

@property (nonatomic, strong) UITableView   *contentTableView;

@property (nonatomic,copy) NSString   *availableBalance;

@property (nonatomic, strong) UIView  *bottomNav;

@end

@implementation MHContinuePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackGroudColor;
    self.title = @"继续支付";
    _selectPay = 0;
    _picArr = @[@"ic_play_play"];
    _titleArr = @[@"支付宝支付"];

   [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
       if (ValidResponseDict(response)){
           self.availableBalance = [NSString stringWithFormat:@"%@",response[@"data"][@"availableBalance"]];
           [self createTableView];
           [self creatbottomNav];
           [self.contentTableView reloadData];
       }
   }];
}


- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight- kRealValue(40)-kBottomHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        
        [_contentTableView registerClass:[MHSumbitCouponCell class] forCellReuseIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHSumbitCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
    cell.leftImageView.image = kGetImage(_picArr[indexPath.row]);
    cell.titleLabel.text = _titleArr[indexPath.row];
    [cell.selectBtn setImage:kGetImage(@"ic_choice_unselect") forState:UIControlStateDisabled];
    [cell.selectBtn setImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
    [cell.selectBtn setImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
    if ([self.availableBalance doubleValue] >=  [self.model.orderTruePrice doubleValue])  {
        cell.selectBtn.enabled = YES;
        if (indexPath.row == _selectPay) {
            cell.selectBtn.selected = YES;
        }else{
            cell.selectBtn.selected = NO;
        }
    }else{
        
        if (indexPath.row == 1) {
            cell.selectBtn.selected = NO;
            cell.selectBtn.enabled = NO;
        }else{
            
            if (indexPath.row == _selectPay) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
            cell.selectBtn.enabled = YES;
        }
    }
    
    if(indexPath.row == 0){
        cell.footLabel.text = @"安全快捷，可支持银行卡支付";
    }else if (indexPath.row == 1){
        cell.footLabel.text =    [NSString stringWithFormat:@"账户余额：¥%@",self.availableBalance];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
    headView.backgroundColor = kBackGroudColor;
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
    headLabel.text = @"选择支付方式";
    headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    headLabel.textColor = [UIColor blackColor];
    [headView addSubview: headLabel];
    
    return headView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(64);
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return kRealValue(42);
}

-(void)creatbottomNav{
    if (!_bottomNav) {
        _bottomNav = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kTopHeight-kRealValue(44), kScreenWidth, kRealValue(44))];
        _bottomNav.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomNav];
        
        RichStyleLabel *priceLabel = [[RichStyleLabel alloc]init];
        priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        priceLabel.textColor =[UIColor colorWithHexString:@"#000000"];
        priceLabel.textAlignment = NSTextAlignmentRight;
        [_bottomNav addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomNav.mas_top).with.offset(0);
            make.left.equalTo(self.bottomNav.mas_left).with.offset(kRealValue(16));
            make.height.mas_equalTo(kRealValue(44));
        }];
        
        [priceLabel setAttributedText:[NSString stringWithFormat:@"需支付  ¥%@",self.model.orderTruePrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FB3131"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
        
        UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(100),0, kRealValue(100), kRealValue(44))];
        [submitBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(100), kRealValue(44))] forState:UIControlStateNormal];
        submitBtn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [submitBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_bottomNav addSubview:submitBtn];
    }
}

- (void)submit{
    
    //订单 在model
    NSString *payType = @"";
    if (_selectPay == 0){
        payType = @"ALIPAY";
    }else{
        payType = @"BALANCEPAY";
    }
    
    if (_selectPay == 1) {
        [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if ([[NSString stringWithFormat:@"%@",response[@"data"] [@"modifyPayPassword"]] isEqualToString:@"0"]) {
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"请先设置资金密码" ];
                    alertVC.messageAlignment = NSTextAlignmentCenter;
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                        
                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"去设置" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                        MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
                        vc.navtitle =@"设置资金密码";
                        vc.dic = response[@"data"];;
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
                    
                }else{
                    self.passwordView = [[CYPasswordView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) WithMoneyStr:@""];
//                    self.passwordView.loadingText = @"陌币支付中...";
                    self.passwordView.moneyStr = [NSString stringWithFormat:@"¥%@",self.model.orderTruePrice];
                    self.passwordView.title = @"未来支付";
                    [self.passwordView showInView:self.view.window];
                    kWeakSelf(self);
                    self.passwordView.finish = ^(NSString *password) {
                        [weakself.passwordView hideKeyboard];
//                        [weakself.passwordView startLoading];
                 
                        [[MHUserService sharedInstance]initwithContinuePay:self.model.orderId payType:payType payPassword:password completionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)) {
//                                [weakself.passwordView requestComplete:YES message:@"支付成功"];
//                                [weakself.passwordView stopLoading];
                                KLToast(@"支付成功");
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    //push
                                    MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                    vc.stateStr = @"success";
                                    vc.commissionProfit = _model.commissionProfit;
                                    vc.orderCode = _model.orderCode;
                                    vc.orderId = _model.orderId;
                                    vc.orderTruePrice = _model.orderTruePrice;
                                    if ([self.model.orderType isEqualToString:@"VIP_ORDER"]) {
                                        vc.orderType = @"VIP_ORDER";
                                    }
                                    [self.navigationController pushViewController:vc animated:YES];
                                    [weakself.passwordView hide];
                                });
                            }else{
//                                [weakself.passwordView requestComplete:NO message:response[@"message"]];
//                                [weakself.passwordView stopLoading];
                                KLToast(response[@"message"]);
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [weakself.passwordView hide];
                                });
                            }
                        }];
                    };
                }
                
            }
        }];
    }else{
        
        //支付接口
        [[MHUserService sharedInstance]initwithContinuePay:self.model.orderId payType:payType payPassword:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                NSString *payParam = response[@"data"][@"orderPayParam"];
                if (!ValidStr(payParam)) {
                    KLToast(@"订单好像出了一点偏差");
                    return ;
                }
                    [[MHPayClass sharedApi]aliPayWithPayParam:response[@"data"][@"orderPayParam"] success:^(payresult code) {
                        if (alipaysuceess ==  code) {
                            //回调支付宝
                    
                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                            vc.stateStr = @"success";
                            vc.typeStr = @"zhifubao";
                            vc.commissionProfit =_model.commissionProfit;
                            vc.orderCode = _model.orderCode;
                            vc.orderId = _model.orderId;
                            vc.orderTruePrice = _model.orderTruePrice;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else{
                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                            vc.stateStr = @"failure";
                            vc.commissionProfit = _model.commissionProfit;
                            vc.orderCode = _model.orderCode;
                            vc.orderId = _model.orderId;
                            vc.orderTruePrice = _model.orderTruePrice;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                    } failure:^(payresult code) {

                        MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                        vc.stateStr = @"failure";
                        vc.commissionProfit = _model.commissionProfit;
                        vc.orderCode = _model.orderCode;
                        vc.orderId = _model.orderId;
                        vc.orderTruePrice = _model.orderTruePrice;
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
            }else{
                KLToast(response[@"message"]);
            }
        }];
    }
    

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        if ([self.availableBalance doubleValue] <   [self.model.orderTruePrice doubleValue]) {
            return;
        }
    }
    _selectPay = indexPath.row;
    [_contentTableView reloadData];
    
}

@end
