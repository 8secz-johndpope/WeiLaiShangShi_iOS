//
//  HSMyWalletController.m
//  HSKD
//
//  Created by AllenQin on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSMyWalletController.h"
#import "MHWithDrawVC.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "RichStyleLabel.h"
#import "MHRecordPresentViewController.h"
#import "HSShopViewController.h"
#import "UIAlertView+BlocksKit.h"
#import "HSFriendShopViewController.h"


@interface HSMyWalletController ()

@property(nonatomic, strong)UILabel *integralLabel;


@property(nonatomic, strong)UILabel *xjLabel;

@property(nonatomic, strong)UILabel *huoLabel;

@property(nonatomic, strong)UILabel *moLabel;

@property(nonatomic, strong)UILabel *djLabel;

@property(nonatomic, strong)UILabel *todayLabel;

@property(nonatomic, strong)UILabel *allhuoLabel;

@property(nonatomic, strong)UILabel *allxjLabel;

@property(nonatomic, strong)UILabel *descLabel;

@property(nonatomic, strong)NSDictionary *resDict;

@property (nonatomic, strong) ZJAnimationPopView *popView;

@end

@implementation HSMyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;
    self.title = @"钱包";
    
    UIScrollView *updateScr = [[UIScrollView alloc]init];
    updateScr.userInteractionEnabled = YES;
    updateScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:updateScr];
    [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view .mas_left).offset(0);
        make.right.equalTo(self.view .mas_right).offset(0);
        make.top.equalTo(self.view .mas_top).offset(0);
        make.height.mas_equalTo(kScreenHeight - kTopHeight);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.userInteractionEnabled = YES;
    [updateScr addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(updateScr);
        make.width.equalTo(updateScr);
    }];
    
    
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"现金流水" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(15), kRealValue(354), kRealValue(302))];
    bgView.userInteractionEnabled = YES;
    bgView.image = kGetImage(@"wallet_bakcground_icon");
    [contentView addSubview:bgView];
    
    
    
    UILabel *jifenLabel1 = [[UILabel alloc] init];
    jifenLabel1.text = @"现金账户（元）";
    jifenLabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    jifenLabel1.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView addSubview:jifenLabel1];
    [jifenLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(kRealValue(17));
        make.left.equalTo(bgView.mas_left).offset(kRealValue(20));
    }];
    
    
    
    self.xjLabel = [[UILabel alloc] init];
    //    self.xjLabel.text = @"   ";
    self.xjLabel.textAlignment = NSTextAlignmentLeft;
    self.xjLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.xjLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView addSubview:self.xjLabel];
    [self.xjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenLabel1.mas_bottom).offset(kRealValue(2));
        make.left.equalTo(jifenLabel1.mas_left).offset(0);
    }];
    
    
    UIView *lineLabel  = [[UIView alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#FE9443"];
    [bgView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-kRealValue(20));
        make.left.equalTo(bgView.mas_left).offset(kRealValue(20));
        make.top.equalTo(bgView.mas_top).offset(kRealValue(103));
        make.height.mas_offset(1/kScreenScale);
    }];
    
    
    UILabel *jifenLabel = [[UILabel alloc] init];
    jifenLabel.text = @"火币账户（火币）";
    jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    jifenLabel.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView addSubview:jifenLabel];
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(kRealValue(123));
        make.left.equalTo(bgView.mas_left).offset(kRealValue(20));
    }];
    
    
    
    self.integralLabel = [[UILabel alloc] init];
    self.integralLabel.text = @"     ";
    self.integralLabel.textAlignment = NSTextAlignmentLeft;
    self.integralLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.integralLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView addSubview:self.integralLabel];
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenLabel.mas_bottom).offset(kRealValue(2));
        make.left.equalTo(jifenLabel.mas_left).offset(0);
    }];
    
    

    
    
    UILabel *xianjinLabel = [[UILabel alloc] init];
    xianjinLabel.text = @"今日收入（火币）";
    xianjinLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    xianjinLabel.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView addSubview:xianjinLabel];
    [xianjinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.integralLabel.mas_bottom).offset(kRealValue(22));
        make.left.equalTo(bgView.mas_left).offset(kRealValue(20));
    }];


    self.moLabel = [[UILabel alloc] init];
    self.moLabel.text = @"  ";
    self.moLabel.textAlignment = NSTextAlignmentCenter;
    self.moLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.moLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView addSubview:self.moLabel];
    [self.moLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xianjinLabel.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(xianjinLabel.mas_left).offset(0);
    }];
    

    self.todayLabel = [[UILabel alloc] init];
    self.todayLabel.text = @"   ";
    self.todayLabel.textAlignment = NSTextAlignmentLeft;
    self.todayLabel.font =     [UIFont fontWithName:kPingFangSemibold size:kFontValue(18)];
    self.todayLabel.textColor = [UIColor colorWithHexString:@"#F9F762"];
    [bgView addSubview:self.todayLabel];
    [self.todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moLabel.mas_bottom).offset(kRealValue(2));
        make.left.equalTo(self.moLabel.mas_left).offset(0);
    }];
    
    
    
    
    
    UILabel *allLabel = [[UILabel alloc] init];
    allLabel.text = @"累计收入（火币）";
    allLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    allLabel.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.integralLabel.mas_bottom).offset(kRealValue(22));
        make.left.equalTo(bgView.mas_left).offset(kRealValue(182));
    }];
    
    
    self.allhuoLabel = [[UILabel alloc] init];
    self.allhuoLabel.text = @"   ";
    self.allhuoLabel.textAlignment = NSTextAlignmentCenter;
    self.allhuoLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.allhuoLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView addSubview:self.allhuoLabel];
    [self.allhuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allLabel.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(allLabel.mas_left).offset(0);
    }];
    
    
    self.allxjLabel = [[UILabel alloc] init];
    self.allxjLabel.text = @"  ";
    self.allxjLabel.textAlignment = NSTextAlignmentLeft;
    self.allxjLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(18)];
    self.allxjLabel.textColor = [UIColor colorWithHexString:@"#F9F762"];
    [bgView addSubview:self.allxjLabel];
    [self.allxjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allhuoLabel.mas_bottom).offset(kRealValue(2));
        make.left.equalTo(self.allhuoLabel.mas_left).offset(0);
    }];
    
    
    
    
    

    
    UIButton *jfBtn = [[UIButton alloc] init];
    [jfBtn setTitle:@"兑换" forState:0];
    [jfBtn addTarget:self action:@selector(duihuan) forControlEvents:UIControlEventTouchUpInside];
    jfBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    ViewBorderRadius(jfBtn, kRealValue(11), 1, [UIColor colorWithHexString:@"#FAE3D3"]);
    [bgView addSubview:jfBtn];
    [jfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo( self.integralLabel.mas_centerY).offset(0);
        make.right.equalTo(bgView.mas_right).offset(-kRealValue(20));
        make.height.mas_equalTo(kRealValue(23));
        make.width.mas_equalTo(kRealValue(71));
    }];
    
    
    
    UIImageView *bgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(335), kRealValue(354), kRealValue(215))];
    bgView1.userInteractionEnabled = YES;
    bgView1.image = kGetImage(@"icon_mywallet");
    [contentView addSubview:bgView1];
    
    
    
    UILabel *xianjinLabel3 = [[UILabel alloc] init];
    xianjinLabel3.text = @"待激活（火币）";
    xianjinLabel3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    xianjinLabel3.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView1 addSubview:xianjinLabel3];
    [xianjinLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView1.mas_top).offset(kRealValue(20));
        make.left.equalTo(bgView1.mas_left).offset(kRealValue(20));
    }];
    
    
    self.djLabel= [[UILabel alloc] init];
    self.djLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(21)];
    self.djLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView1 addSubview:self.djLabel];
    [self.djLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xianjinLabel3.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(xianjinLabel3.mas_left).offset(0);
    }];


    
    UILabel *xianjinLabel1 = [[UILabel alloc] init];
    xianjinLabel1.text = @"积分账户（积分）";
    xianjinLabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    xianjinLabel1.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView1 addSubview:xianjinLabel1];
    [xianjinLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView1.mas_top).offset(kRealValue(106));
        make.left.equalTo(bgView1.mas_left).offset(kRealValue(20));
    }];
    
    
    self.huoLabel = [[UILabel alloc] init];
    self.huoLabel.text = @"   ";
    self.huoLabel.textAlignment = NSTextAlignmentCenter;
    self.huoLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.huoLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [bgView1 addSubview:self.huoLabel];
    [self.huoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xianjinLabel1.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(xianjinLabel1.mas_left).offset(0);
    }];
    
    UILabel *jifenLabel2 = [[UILabel alloc] init];
    jifenLabel2.text = @"邀请6人即可兑换为火币提现";
    jifenLabel2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    jifenLabel2.textColor = [UIColor colorWithHexString:@"#FAE3D3"];
    [bgView1 addSubview:jifenLabel2];
    [jifenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.huoLabel.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(bgView1.mas_left).offset(kRealValue(20));
    }];
    
    
    
    UIButton *txBtn = [[UIButton alloc] init];
    [txBtn setTitle:@"提现" forState:0];
    [txBtn addTarget:self action:@selector(pushWithdraw) forControlEvents:UIControlEventTouchUpInside];
    txBtn.backgroundColor = [UIColor whiteColor];
    txBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    [txBtn setTitleColor:[UIColor colorWithHexString:@"#FD7014"] forState:0];
    ViewBorderRadius(txBtn, kRealValue(11), 1, [UIColor colorWithHexString:@"#FD7014"]);
    [bgView addSubview:txBtn];
    [txBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo( self.xjLabel.mas_centerY).offset(0);
        make.right.equalTo(bgView.mas_right).offset(-kRealValue(20));
        make.height.mas_equalTo(kRealValue(23));
        make.width.mas_equalTo(kRealValue(71));
    }];
    
    UIButton *gwBtn = [[UIButton alloc] init];
    [gwBtn setTitle:@"商品兑换" forState:0];
    [gwBtn addTarget:self action:@selector(pushShop) forControlEvents:UIControlEventTouchUpInside];
    gwBtn.backgroundColor = [UIColor whiteColor];
    gwBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    [gwBtn setTitleColor:[UIColor colorWithHexString:@"#FD7014"] forState:0];
    ViewBorderRadius(gwBtn, kRealValue(11), 1, [UIColor whiteColor]);
    [bgView1 addSubview:gwBtn];
    [gwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo( self.huoLabel.mas_centerY).offset(0);
        make.right.equalTo(bgView1.mas_right).offset(-kRealValue(20));
        make.height.mas_equalTo(kRealValue(23));
        make.width.mas_equalTo(kRealValue(71));
    }];
    
    
    UIButton *jhBtn = [[UIButton alloc] init];
    [jhBtn setTitle:@"激活" forState:0];
    [jhBtn addTarget:self action:@selector(jihuo) forControlEvents:UIControlEventTouchUpInside];
    jhBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    ViewBorderRadius(jhBtn, kRealValue(11), 1, [UIColor colorWithHexString:@"#FAE3D3"]);
    [bgView1 addSubview:jhBtn];
    [jhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo( self.djLabel.mas_centerY).offset(0);
        make.right.equalTo(bgView1.mas_right).offset(-kRealValue(20));
        make.height.mas_equalTo(kRealValue(23));
        make.width.mas_equalTo(kRealValue(71));
    }];
    
    
    
    

    
    //改成富文本提现规则：要16号字
    self.descLabel = [[UILabel alloc]init];
    self.descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.descLabel .textColor =[UIColor colorWithHexString:@"#999999"];
    self.descLabel .numberOfLines = 0;
    [contentView addSubview:self.descLabel];
    [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView1.mas_bottom).with.offset(kRealValue(20));
        make.left.equalTo(contentView.mas_left).with.offset(kRealValue(13));
        make.right.equalTo(contentView.mas_right).with.offset(-kRealValue(13));
    }];

    [[MHUserService sharedInstance]initwithHSRuleType:@"PURSE_RULE" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.descLabel.text = response[@"data"];
        }
    }];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.descLabel.mas_bottom).with.offset(kRealValue(20));
    }];
     
}


-(void)jihuo{

    [[MHUserService sharedInstance]initWitHSActiveCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            if ([response[@"data"][@"status"] integerValue] == 0) {
                
                UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                        message:[NSString stringWithFormat:@"     您需要消耗%@友利值以激活%@火币",response[@"data"][@"power"],response[@"data"][@"integral"]]
                                                              cancelButtonTitle:@"取消"
                                                              otherButtonTitles:@[@"获取友利值"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                  if (buttonIndex == 1)
                                                                  {
                                                                      HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                                                                      [self.navigationController pushViewController:vc animated:YES];
                                                                  }
                                                              }];
                
                [alertView show];
            }
       
            if ([response[@"data"][@"status"] integerValue] == 1) {
                
                UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                        message:[NSString stringWithFormat:@" 当前消耗%@友利值激活%@火币",response[@"data"][@"power"],response[@"data"][@"integral"]]
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {

                                                              }];
                
                [alertView show];
                
                [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        self.integralLabel.text  = response[@"data"][@"withdrawIntegral"];
                        self.moLabel.text  = response[@"data"][@"todayIncome"];
                        self.todayLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"todayIncomeMoney"]];
                        self.allhuoLabel.text  = response[@"data"][@"integral"];
                        self.allxjLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"integralMoney"]];
                        self.djLabel.text = [NSString stringWithFormat:@"%@≈%@元",  response[@"data"][@"freezeIntegral"],response[@"data"][@"freezeIntegralMoney"]];
                        self.xjLabel.text = response[@"data"][@"availableBalance"];
                        self.huoLabel.text = response[@"data"][@"fireIntegral"];
                    }
                }];
            }
            
        }else{
            KLToast(response[@"message"]);
        }
    }];
}


-(void)pushShop{
    HSShopViewController *vc = [[HSShopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}



- (void)withDrawListClick{
    MHRecordPresentViewController *vc= [[MHRecordPresentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.integralLabel.text  = response[@"data"][@"withdrawIntegral"];
            self.moLabel.text  = response[@"data"][@"todayIncome"];
            self.todayLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"todayIncomeMoney"]];
            self.allhuoLabel.text  = response[@"data"][@"integral"];
            self.allxjLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"integralMoney"]];
            self.djLabel.text = [NSString stringWithFormat:@"%@≈%@元",  response[@"data"][@"freezeIntegral"],response[@"data"][@"freezeIntegralMoney"]];
            self.xjLabel.text = response[@"data"][@"availableBalance"];
            self.huoLabel.text = response[@"data"][@"fireIntegral"];
        }
    }];
}


-(void)pushWithdraw{
    MHWithDrawVC *vc = [[MHWithDrawVC alloc] init];
    if (ValidStr(self.moLabel.text)) {
         vc.withDrawMoney =  self.xjLabel.text;
    }else{
         vc.withDrawMoney =  @"0.00";
    }
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)duihuan{
    
    [MBProgressHUD showActivityMessageInWindow:@""];
    
    [[MHUserService sharedInstance]initwithHSHotPreExchangeCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [MBProgressHUD hideHUD];
            self.resDict = response[@"data"];
            
           
            if ([response[@"data"][@"integral"] integerValue] == 0) {
                KLToast(@"暂无可兑换火币");
                return;
            }
            
            UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(277), kRealValue(150))];
            contentView.backgroundColor = [UIColor whiteColor];
            contentView.layer.masksToBounds = YES;
            contentView.layer.cornerRadius = kRealValue(10);
            
            
            UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(30), kRealValue(277), kRealValue(20))];
            titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
            titleLabel.text = [NSString stringWithFormat:@"本次消耗%@火币",response[@"data"][@"integral"]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
            [contentView addSubview:titleLabel];
            
            
            
            RichStyleLabel *priceLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(0, kRealValue(60), kRealValue(277), kRealValue(25))];
            priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
            priceLabel.textColor =[UIColor colorWithHexString:@"#222222"];
            priceLabel.textAlignment = NSTextAlignmentCenter;
            [contentView addSubview:priceLabel];
            
            [priceLabel setAttributedText:[NSString stringWithFormat:@"兑换 %@元",response[@"data"][@"balance"]] withRegularPattern:@"[0-9.,¥元]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FC7013"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(20)]}];
            
            
            UIView *lineLabel = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(106) - 1/kScreenScale, kRealValue(277), 1/kScreenScale)];
            lineLabel.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
            [contentView addSubview:lineLabel];
            
            UIView *lineLabel1 = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(138.5), kRealValue(106), 1/kScreenScale, kRealValue(44))];
            lineLabel1.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
            [contentView addSubview:lineLabel1];
            
            self.popView = [[ZJAnimationPopView alloc] initWithCustomView:contentView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            self.popView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            self.popView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            self.popView.popAnimationDuration = 0.3f;
            // 3.5 移除时动画时长
            self.popView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            self.popView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            self.popView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [self.popView pop];
            
            
            
            
            
            UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(106), kRealValue(138.5), kRealValue(44))];
            leftBtn.backgroundColor = [UIColor whiteColor];
            [leftBtn bk_addEventHandler:^(id sender) {
                [self.popView dismiss];
                
                
            } forControlEvents:UIControlEventTouchUpInside];
            leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
            [leftBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
            [contentView addSubview:leftBtn];
            
            
            UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(138.5), kRealValue(106), kRealValue(138.5), kRealValue(44))];
            rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
            [rightBtn setTitleColor:[UIColor colorWithHexString:@"#FC7013"] forState:UIControlStateNormal];
            [rightBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
            [rightBtn bk_addEventHandler:^(id sender) {
                [self.popView dismiss];
                [[MHUserService sharedInstance]initwithHSHotExchange:self.resDict[@"integral"] CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)) {
                                self.integralLabel.text  = response[@"data"][@"withdrawIntegral"];
                                self.moLabel.text  = response[@"data"][@"todayIncome"];
                                self.todayLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"todayIncomeMoney"]];
                                self.allhuoLabel.text  = response[@"data"][@"integral"];
                                self.allxjLabel.text = [NSString stringWithFormat:@"≈%@元", response[@"data"][@"integralMoney"]];
                                self.djLabel.text = [NSString stringWithFormat:@"%@≈%@元",  response[@"data"][@"freezeIntegral"],response[@"data"][@"freezeIntegralMoney"]];
                                self.xjLabel.text = response[@"data"][@"availableBalance"];
                                self.huoLabel.text = response[@"data"][@"fireIntegral"];
                            }
                        }];
                    }
                    KLToast(response[@"message"]);
                }];
                
            } forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:rightBtn];
            
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
