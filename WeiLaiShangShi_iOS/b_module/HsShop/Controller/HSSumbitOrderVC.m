//
//  HSSumbitOrderVC.m
//  HSKD
//
//  Created by AllenQin on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSSumbitOrderVC.h"
#import "MHSumbitHeadView.h"
#import "MHMineUserInfoAddressViewController.h"
#import "MHMineuserAddress.h"
#import "MHSetPsdVC.h"
#import "CYPasswordView.h"
#import "HSPaySuccessController.h"
#import "UIAlertView+BlocksKit.h"

@interface HSSumbitOrderVC ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *backGroudImageView ;
@property (nonatomic, strong) UILabel *jifenLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) NSDictionary *shopDict;
@property (nonatomic, strong) NSDictionary *shopRes;
@property (nonatomic, strong) NSDictionary *passwordRes;
@property (nonatomic, strong) MHMineuserAddress *adress;
@property (nonatomic, strong)MHSumbitHeadView *headView ;
@property (nonatomic, strong) CYPasswordView *passwordView;

@end

@implementation HSSumbitOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel) name:@"CYPasswordViewCancleButtonClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPWD) name:@"CYPasswordViewForgetPWDButtonClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAdress:) name:KNotificationchangeAdress object:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    UIImageView *lineView = [[UIImageView alloc]initWithImage:kGetImage(@"shop_line")];
    lineView.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(7)) ;
    [self.view addSubview:lineView];

    
    self.headView = [[MHSumbitHeadView alloc] initWithFrame:CGRectMake(0, kRealValue(7), kScreenWidth, kRealValue(88))];
    self.headView .userInteractionEnabled =YES;
    [self.view addSubview: self.headView ];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAdress)];
    [self.headView  addGestureRecognizer:tap];
    
    
    
    UIView *shopView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(95), kScreenWidth, kRealValue(129))];
    shopView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.view addSubview:shopView];
    
    
    self.backGroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(15), kRealValue(99), kRealValue(99))];
//    self.backGroudImageView.backgroundColor = kRandomColor;
    [shopView addSubview:self.backGroudImageView];
    
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(126), kRealValue(25), kRealValue(238), kRealValue(40))];
    self.nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.nameLabel .textColor =[UIColor colorWithHexString:@"#222222"];
    self.nameLabel .numberOfLines = 2;
//    self.nameLabel.text =  @"象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲象印电饭煲";
    [shopView addSubview:self.nameLabel];
    
    
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(126), kRealValue(88), kRealValue(200), kRealValue(20))];
    moneyLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
     moneyLabel .textColor =[UIColor colorWithHexString:@"#FF273F"];
    moneyLabel .numberOfLines = 1;
    [shopView addSubview: moneyLabel];
    
    
    
    self.jifenLabel  = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(126), kRealValue(88), kRealValue(238), kRealValue(20))];
    self.jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    self.jifenLabel.textColor =[UIColor colorWithHexString:@"#FF273F"];
    self.jifenLabel.numberOfLines = 1;
    [shopView addSubview:self.jifenLabel];
    
    
    UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(224), kScreenWidth, kRealValue(44))];
    numView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numView];
    
    UILabel *numTitle = [[UILabel alloc]init];
    numTitle .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    numTitle .textColor =[UIColor colorWithHexString:@"#222222"];
    numTitle .numberOfLines = 1;
    numTitle.text =  @"商品数量";
    [numView addSubview:numTitle];
    [numTitle  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numView.mas_left).with.offset(kRealValue(13));
        make.centerY.equalTo(numView.mas_centerY).with.offset(0);
    }];
    
    
    self.numLabel = [[UILabel alloc]init];
    self.numLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.numLabel .textColor =[UIColor colorWithHexString:@"#222222"];
    self.numLabel .numberOfLines = 1;
    self.numLabel.text =  @"x1";
    [numView addSubview:self.numLabel];
    [self.numLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numView.mas_right).with.offset(-kRealValue(12));
        make.centerY.equalTo(numView.mas_centerY).with.offset(0);
    }];
    
    UIView *lineViews = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(11), kRealValue(44) - 1/kScreenScale, kScreenWidth - kRealValue(11), 1/kScreenScale)];
    lineViews.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [numView addSubview:lineViews];
    
    
    
    UIView *allView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(268), kScreenWidth, kRealValue(44))];
    allView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:allView];
    
    UILabel *allTitle = [[UILabel alloc]init];
    allTitle .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    allTitle .textColor =[UIColor colorWithHexString:@"#222222"];
    allTitle .numberOfLines = 1;
    allTitle.text =  @"小计";
    [allView addSubview:allTitle];
    [allTitle  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allView.mas_left).with.offset(kRealValue(13));
        make.centerY.equalTo(allView.mas_centerY).with.offset(0);
    }];
    
    
    self.allLabel = [[UILabel alloc]init];
    self.allLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.allLabel .textColor =[UIColor colorWithHexString:@"#FF273F"];
    self.allLabel .numberOfLines = 1;
//    self.allLabel.text =  @"3000";
    [allView addSubview:self.allLabel];
    [self.allLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(allView.mas_right).with.offset(-kRealValue(12));
        make.centerY.equalTo(allView.mas_centerY).with.offset(0);
    }];
    
    UIView *bttomView = [[UIView alloc] initWithFrame:CGRectMake(0,  kScreenHeight - kTopHeight -kRealValue(49), kScreenWidth, kRealValue(49))];
    bttomView.backgroundColor = [UIColor whiteColor];
    bttomView.userInteractionEnabled = YES;
    [self.view addSubview:bttomView];
    

    
    
    //购买
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(252), 0, kScreenWidth - kRealValue(252), kRealValue(49))];
    [buyBtn addTarget:self action:@selector(pushSumbit) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.backgroundColor = [UIColor colorWithHexString:@"FF273F"];
    [buyBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [buyBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    [bttomView addSubview:buyBtn];
    
    
    self.orderLabel = [[UILabel alloc]init];
    self.orderLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    self.orderLabel .textColor =[UIColor colorWithHexString:@"#FF273F"];
    self.orderLabel .numberOfLines = 1;
    [bttomView addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buyBtn.mas_left).with.offset(-kRealValue(16));
        make.centerY.equalTo(buyBtn.mas_centerY).with.offset(0);
    }];

    [[MHUserService sharedInstance]initwithSumitOrder:@[@{@"productId":@(self.prodId),@"productNum":@(1)}] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.shopDict =  response[@"data"][@"shops"][0][@"products"][0];
            self.shopRes = response[@"data"];
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付：%@积分",response[@"data"][@"orderTruePrice"]]];
            
            moneyLabel.text = [NSString stringWithFormat:@"%@积分",response[@"data"][@"orderTruePrice"]];
            
            // 改变颜色
            
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0,3)];
            
            self.orderLabel.attributedText = noteStr;
            
          
            
            
            [self.backGroudImageView sd_setImageWithURL:[NSURL URLWithString:self.shopDict[@"productSmallImage"]] placeholderImage:kGetImage(@"emty_fang")];
            self.nameLabel.text = self.shopDict[@"productName"];
            self.allLabel.text = [NSString stringWithFormat:@"%@积分",self.shopDict[@"productPrice"]];
            
            if (ValidStr(response[@"data"][@"contact"])) {
                self.headView.label1.hidden = NO;
                self.headView.label1.hidden = NO;
                self.headView.addressLabel.hidden = NO;
                self.headView.nameLabel.hidden = NO;
                self.headView.phoneLabel.hidden = NO;
                self.headView.emtyLabel.hidden = YES;
                self.headView.nameLabel.text = response[@"data"][@"contact"];
                self.headView.phoneLabel.text = response[@"data"][@"phone"];
                self.headView.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",response[@"data"][@"province"],response[@"data"][@"city"],response[@"data"][@"area"],response[@"data"][@"detail"]];
            }else{
                self.headView.addressLabel.hidden = YES;
                self.headView.nameLabel.hidden = YES;
                self.headView.phoneLabel.hidden = YES;
                self.headView.emtyLabel.hidden = NO;
                self.headView.label1.hidden = YES;
                self.headView.label1.hidden = YES;
            }
            
            
        }
    }];
}



-(void)pushSumbit{
    
   NSString *phone =  self.adress.phone?self.adress.phone:self.shopRes[@"phone"];
    if (!ValidStr(phone)) {
        KLToast(@"请填写收货地址");
        return;
    }

    
    
    
    
    NSMutableArray *listArr = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.shopDict[@"productCount"] forKey:@"productNum"];
    [dict setObject:self.shopDict[@"productId"] forKey:@"productId"];
    [listArr addObject:dict];
    [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.passwordRes = response[@"data"];
            if ([[NSString stringWithFormat:@"%@",response[@"data"][@"modifyPayPassword"]] isEqualToString:@"0"]) {
                
                MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
                vc.navtitle =@"设置资金密码";
                vc.dic = response[@"data"];
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }else{
                UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                        message:@"该商品兑换后不可退换货"
                                                              cancelButtonTitle:@"取消"
                                                              otherButtonTitles:@[@"确认兑换"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                  if (buttonIndex == 1)
                                                                  {
                                                                      
                                                                      
                                                                      self.passwordView = [[CYPasswordView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) WithMoneyStr:@"123"];
                                                                      self.passwordView.loadingText = @"积分兑换中...";
                                                                      self.passwordView.moneyStr = [NSString stringWithFormat:@"%@积分",self.shopDict[@"productPrice"]];
                                                                      self.passwordView.feeStr = [NSString stringWithFormat:@"积分余额：%@积分",self.passwordRes[@"fireIntegral"]];
                                                                      self.passwordView.title = @"积分兑换";
                                                                      [self.passwordView showInView:self.view.window];
                                                                      kWeakSelf(self);
                                                                      self.passwordView.finish = ^(NSString *password) {
                                                                          [weakself.passwordView hideKeyboard];
                                                                          //                        [weakself.passwordView startLoading];
                                                                          //                    [dict setObject:password forKey:@"payPassword"];
                                                                          [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
                                                                              if (ValidResponseDict(response)){
                                                                                  
                                                                                  [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:self.adress.phone?self.adress.id:[NSString stringWithFormat:@"%@",self.shopRes[@"addressId"]] payType:@"INTEGRAL" orderType:@"INTEGRAL" orderTruePrice:self.shopDict[@"productPrice"] payPassword:password completionBlock:^(NSDictionary *response, NSError *error) {
                                                                                      if (ValidResponseDict(response)) {
                                                                                          
                                                                                          //                                        KLToast(@"支付成功");
                                                                                          HSPaySuccessController *vc = [[HSPaySuccessController alloc]init];
                                                                                          [self.navigationController pushViewController:vc animated:YES];
                                                                                          
                                                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                              //push
                                                                                              [weakself.passwordView hide];
                                                                                              
                                                                                              
                                                                                          });
                                                                                      }else{
                                                                                          
                                                                                          KLToast(response[@"message"]);
                                                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                              [weakself.passwordView hide];
                                                                                          });
                                                                                      }
                                                                                      
                                                                                      
                                                                                  }];
                                                                              }
                                                                          }];
                                                                          
                                                                      };
                                                                  }
                                                              }];
                
                [alertView show];

            }
            
        }
    }];
    
    
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
    vc.dic = self.passwordRes;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)selectAdress{
    MHMineUserInfoAddressViewController *vc = [[MHMineUserInfoAddressViewController alloc] init];
    vc.type = @"sumbit";
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)changeAdress:(NSNotification *)noti
{
    self.adress  = [noti object];
    if (self.adress) {
        self.headView.addressLabel.hidden = NO;
        self.headView.nameLabel.hidden = NO;
        self.headView.phoneLabel.hidden = NO;
        self.headView.emtyLabel.hidden = YES;
        self.headView.label1.hidden = NO;
        self.headView.label2.hidden = NO;
        self.headView.nameLabel.text = self.adress .contact;
        self.headView.phoneLabel.text = self.adress .phone;
        self.headView.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",self.adress .province,self.adress .city,self.adress .area,self.adress .detail];
    }else{
        self.headView.addressLabel.hidden = YES;
        self.headView.nameLabel.hidden = YES;
        self.headView.phoneLabel.hidden = YES;
        self.headView.emtyLabel.hidden = NO;
        self.headView.label1.hidden = YES;
        self.headView.label2.hidden = YES;
    }
    
}

@end
