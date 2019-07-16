//
//  HSWalletViewController.m
//  HSKD
//
//  Created by AllenQin on 2019/5/7.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletViewController.h"
#import "HSWallethotView.h"
#import "HSWalletJfView.h"
#import "HSWalletXJView.h"
#import "RichStyleLabel.h"
#import "HSMyWalletController.h"
#import "MHWithDrawVC.h"
#import "HSShopViewController.h"
#import "UIAlertView+BlocksKit.h"
#import "HSFriendShopViewController.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "EllipsePageControl.h"


@interface HSWalletViewController ()<UIScrollViewDelegate,HSWalletJfDelegate,HSWalletXJViewDelegate,EllipsePageControlDelegate>{
    BOOL  _isShow;
}

@property(strong,nonatomic)UIScrollView  *scrollView;
@property(strong,nonatomic)UIImageView  *hotHeader;
@property(strong,nonatomic)UIImageView  *jfHeader;
@property(strong,nonatomic)UIImageView  *xjHeader;
@property(strong,nonatomic)HSWallethotView  *hotView;
@property(strong,nonatomic)HSWalletJfView *jfView;
@property(strong,nonatomic)HSWalletXJView *xjView;

@property(strong,nonatomic)ZJAnimationPopView *popView;
@property(strong,nonatomic)ZJAnimationPopView *ruleView;
@property(nonatomic, strong)NSDictionary *resDict;

@property(strong,nonatomic)UILabel *xjValueLabel;
@property(strong,nonatomic)UILabel *jfValueLabel;


@property(strong,nonatomic)UILabel *chargeLabel;
@property(strong,nonatomic)UILabel *jihuoLabel;

@property(nonatomic,strong) EllipsePageControl *myPageControl1;
@end

@implementation HSWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"钱包";
    _isShow = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight)];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-kRealValue(25), kScreenHeight  - kTopHeight - kTabBarHeight)];
    self.scrollView.contentSize = CGSizeMake(kRealValue(1050), kRealValue(177));
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:self.scrollView];
    
    
    self.hotHeader = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kRealValue(345), kRealValue(177))];
    self.hotHeader.userInteractionEnabled = YES;
    self.hotHeader.image = kGetImage(@"wallet_hot_bg");
    [self.scrollView addSubview:self.hotHeader];
    
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kRealValue(18), kRealValue(150), kRealValue(30))];
    hotLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    hotLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    hotLabel.textAlignment = NSTextAlignmentCenter;
    [self.hotHeader addSubview:hotLabel];
    
    NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"火币账户(火币)"];
    [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:NSMakeRange(4,4)];
    hotLabel.attributedText = hotStr;
    hotLabel.centerX = kRealValue(345)/2;
    
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    label1.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"可兑换";
    [self.hotHeader addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotHeader.mas_top).offset(kRealValue(57));
        make.left.equalTo(self.hotHeader.mas_left).offset(kRealValue(66));
    }];
    
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    label2.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"待激活";
    [self.hotHeader addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotHeader.mas_top).offset(kRealValue(57));
        make.left.equalTo(self.hotHeader.mas_left).offset(kRealValue(238));
    }];
    
    
     self.chargeLabel = [[UILabel alloc]init];
     self.chargeLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(26)];
     self.chargeLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
     self.chargeLabel.textAlignment = NSTextAlignmentCenter;
     self.chargeLabel.text = @"  ";
    [self.hotHeader addSubview: self.chargeLabel];
    [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotHeader.mas_top).offset(kRealValue(75));
        make.centerX.equalTo(label1.mas_centerX).offset(0);
    }];
    
    
    self.jihuoLabel = [[UILabel alloc]init];
    self.jihuoLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(26)];
    self.jihuoLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    self.jihuoLabel.textAlignment = NSTextAlignmentCenter;
    self.jihuoLabel.text = @"   ";
    [self.hotHeader addSubview: self.jihuoLabel];
    [self.jihuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotHeader.mas_top).offset(kRealValue(75));
        make.centerX.equalTo(label2.mas_centerX).offset(0);
    }];
    
    
    
    UIButton *huoBtn = [[UIButton alloc] init];
    huoBtn.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [huoBtn setTitleColor:[UIColor colorWithHexString:@"#FF7E50"] forState:0];
    [huoBtn setTitle:@"兑换" forState:0];
    [huoBtn addTarget:self action:@selector(huobi) forControlEvents:UIControlEventTouchUpInside];
    huoBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    ViewBorderRadius(huoBtn, kRealValue(6), 1, [UIColor colorWithHexString:@"#ffffff"]);
    [self.hotHeader addSubview:huoBtn];
    [huoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.hotHeader.mas_top).offset(kRealValue(123));
        make.centerX.equalTo(label1.mas_centerX).offset(0);
        make.height.mas_equalTo(kRealValue(31));
        make.width.mas_equalTo(kRealValue(109));
    }];
    
    
    UIButton *jhBtn = [[UIButton alloc] init];
    jhBtn.backgroundColor = [UIColor clearColor];
    [jhBtn setTitle:@"激活" forState:0];
    [jhBtn addTarget:self action:@selector(jihuo) forControlEvents:UIControlEventTouchUpInside];
    jhBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    ViewBorderRadius(jhBtn, kRealValue(6), 1, [UIColor colorWithHexString:@"#ffffff"]);
    [self.hotHeader addSubview:jhBtn];
    [jhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.hotHeader.mas_top).offset(kRealValue(123));
        make.centerX.equalTo(label2.mas_centerX).offset(0);
        make.height.mas_equalTo(kRealValue(31));
        make.width.mas_equalTo(kRealValue(109));
    }];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:kGetImage(@"wallet_line")];
    lineImageView.frame = CGRectMake(0, kRealValue(53), 1,100);
    [self.hotHeader addSubview:lineImageView];
    lineImageView.centerX = kRealValue(345)/2;
    

    self.jfHeader = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(715), 0, kRealValue(345), kRealValue(177))];
    self.jfHeader.userInteractionEnabled = YES;
    self.jfHeader.image = kGetImage(@"wallet_jf_bg");
    [self.scrollView addSubview:self.jfHeader];
    
    
    
    UILabel *jfLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kRealValue(18), kRealValue(150), kRealValue(30))];
    jfLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    jfLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    jfLabel.textAlignment = NSTextAlignmentCenter;
    [self.jfHeader addSubview:jfLabel];
    
    NSMutableAttributedString *jfStr = [[NSMutableAttributedString alloc]      initWithString:@"积分账户(积分)"];
    [jfStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:NSMakeRange(4,4)];
    jfLabel.attributedText = jfStr;
    jfLabel.centerX = kRealValue(345)/2;
    
    
    self.jfValueLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0,kRealValue(52), kRealValue(300), kRealValue(50))];
    self.jfValueLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.jfValueLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    self.jfValueLabel.text = @"  ";
    self.jfValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.jfHeader addSubview: self.jfValueLabel];
    self.jfValueLabel.centerX = kRealValue(345)/2;
    
    
    UIButton *chargeBtn = [[UIButton alloc] init];
    chargeBtn.backgroundColor = [UIColor clearColor];
    [chargeBtn setTitle:@"商品兑换" forState:0];
    [chargeBtn addTarget:self action:@selector(duihuan) forControlEvents:UIControlEventTouchUpInside];
    chargeBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    ViewBorderRadius(chargeBtn, kRealValue(6), 1, [UIColor colorWithHexString:@"#ffffff"]);
    [self.jfHeader addSubview:chargeBtn];
    [chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( jfLabel.mas_bottom).offset(kRealValue(70));
        make.centerX.equalTo(self.jfHeader.mas_centerX).offset(0);
        make.height.mas_equalTo(kRealValue(31));
        make.width.mas_equalTo(kRealValue(169));
    }];
  
   
    self.xjHeader = [[UIImageView alloc] initWithFrame: CGRectMake(kRealValue(365), 0, kRealValue(345), kRealValue(177))];
    self.xjHeader.userInteractionEnabled = YES;
    self.xjHeader.image = kGetImage(@"wallet_xj_bg");
    [self.scrollView addSubview:self.xjHeader];
    
    UILabel *xjLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kRealValue(18), kRealValue(150), kRealValue(30))];
    xjLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    xjLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    xjLabel.textAlignment = NSTextAlignmentCenter;
    [self.xjHeader addSubview:xjLabel];
    
    NSMutableAttributedString *xjStr = [[NSMutableAttributedString alloc]      initWithString:@"现金账户(元)"];
    [xjStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:NSMakeRange(4,3)];
    xjLabel.attributedText = xjStr;
    xjLabel.centerX = kRealValue(345)/2;
    
    self.xjValueLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0,kRealValue(52), kRealValue(300), kRealValue(50))];
    self.xjValueLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.xjValueLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    self.xjValueLabel.text = @"  ";
    self.xjValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.xjHeader addSubview: self.xjValueLabel];
    self.xjValueLabel.centerX = kRealValue(345)/2;
    
    
    UIButton *txBtn = [[UIButton alloc] init];
    txBtn.backgroundColor = [UIColor clearColor];
    [txBtn setTitle:@"立即提现" forState:0];
    [txBtn addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    txBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    ViewBorderRadius(txBtn, kRealValue(6), 1, [UIColor colorWithHexString:@"#ffffff"]);
    [self.xjHeader addSubview:txBtn];
    [txBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( xjLabel.mas_bottom).offset(kRealValue(70));
        make.centerX.equalTo(self.xjHeader.mas_centerX).offset(0);
        make.height.mas_equalTo(kRealValue(31));
        make.width.mas_equalTo(kRealValue(169));
    }];
    
    
    self.hotView = [[HSWallethotView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(217), kRealValue(345), kScreenHeight - kRealValue(217) - kTopHeight - kTabBarHeight)];
    self.hotView.nav = self.navigationController;
    [self.scrollView addSubview:self.hotView];
    
    self.jfView =  [[HSWalletJfView alloc]initWithFrame:CGRectMake(kRealValue(715), kRealValue(217), kRealValue(345), kScreenHeight - kRealValue(217) - kTopHeight - kTabBarHeight)];
    self.jfView.delegate = self;
    [self.scrollView addSubview:self.jfView];
    
    self.xjView =  [[HSWalletXJView alloc]initWithFrame:CGRectMake(kRealValue(365), kRealValue(217), kRealValue(345), kScreenHeight - kRealValue(217) - kTopHeight - kTabBarHeight)];
    self.xjView.delegate = self;
    [self.scrollView addSubview:self.xjView];
    
    
    
    _myPageControl1 = [[EllipsePageControl alloc] init];
    _myPageControl1.frame=CGRectMake(kRealValue(15), kRealValue(175),kRealValue(345), kRealValue(20));
    _myPageControl1.currentColor = [UIColor colorWithHexString:@"#FF6128"];
    _myPageControl1.otherColor = [UIColor colorWithHexString:@"#FFCDBC"];
    _myPageControl1.numberOfPages = 3;
    _myPageControl1.delegate = self;
    [self.view addSubview:_myPageControl1];
    

    
    
}

-(void)showRuleView{
    [[MHUserService sharedInstance]initwithHSRuleType:@"FIRE_INTEGRAL_RULE" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
                _isShow = NO;
            //response[@"data"]
            
            UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(300), kRealValue(370))];
            contentViews.backgroundColor = [UIColor clearColor];
            
            
            UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(300), kRealValue(235))];
            bgImg.backgroundColor = [UIColor whiteColor];
            ViewRadius(bgImg, kRealValue(8))
            [contentViews addSubview:bgImg];
            
            
            
            UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(25),kRealValue(25), kRealValue(32), kRealValue(32))];
            forceUpdateImg.image = [UIImage imageNamed:@"rule_explain"];
            [bgImg addSubview:forceUpdateImg];

            
            UILabel *leftLabel = [[UILabel alloc] init];
            leftLabel.text = @"积分规则说明";
            leftLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            leftLabel.font = [UIFont systemFontOfSize:kFontValue(18)];
            [bgImg addSubview:leftLabel];
            [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(forceUpdateImg.mas_centerY).offset(0);
                make.left.equalTo(forceUpdateImg.mas_right).offset(kRealValue(12));
            }];
            
            
            UIScrollView * updateScr = [[UIScrollView alloc]init];
            [bgImg addSubview:updateScr];
            [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bgImg.mas_left).offset(kRealValue(25));
                make.right.equalTo(bgImg.mas_right).offset(kRealValue(-25));
                make.top.equalTo(bgImg.mas_top).offset(kRealValue(84));
                make.bottom.equalTo(bgImg.mas_bottom).offset(kRealValue(-10));
                
            }];
            UIView *updateContentView = [[UIView alloc]init];
            [updateScr addSubview:updateContentView];
            [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(updateScr);
                make.width.equalTo(updateScr);
            }];
            UILabel *label = [[UILabel alloc]init];
            label.numberOfLines = 0;
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            NSString *str = response[@"data"];//[  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
            label.text = str;
            label.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            [updateContentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(updateContentView.mas_top);
                make.left.equalTo(@0);
                make.width.equalTo(updateContentView.mas_width);
                
            }];
            
            [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_bottom);
            }];
            
            
            self.ruleView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
            // 3.2 显示时背景的透明度
            self.ruleView.popBGAlpha = 0.5f;
            // 3.3 显示时是否监听屏幕旋转
            self.ruleView.isObserverOrientationChange = YES;
            // 3.4 显示时动画时长
            self.ruleView.popAnimationDuration = 0.5f;
            // 3.5 移除时动画时长
            self.ruleView.dismissAnimationDuration = 0.3f;
            
            // 3.6 显示完成回调
            self.ruleView.popComplete = ^{
                MHLog(@"显示完成");
            };
            // 3.7 移除完成回调
            self.ruleView.dismissComplete = ^{
                MHLog(@"移除完成");
            };
            [self.ruleView pop];
            
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
            [closeBtn bk_addEventHandler:^(id sender) {
                [self.ruleView dismiss];
                
            } forControlEvents:UIControlEventTouchUpInside];
            [contentViews addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgImg.mas_bottom).with.offset(kRealValue(40));
                make.centerX.mas_equalTo(bgImg.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
        }
    }];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger currentPage = targetContentOffset->x / kRealValue(345);
    self.myPageControl1.currentPage = currentPage;
    if (currentPage == 2  && _isShow) {
        [self showRuleView];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.chargeLabel.text  = response[@"data"][@"withdrawIntegral"];
            self.jihuoLabel.text = response[@"data"][@"freezeIntegral"];
            self.jfValueLabel.text = response[@"data"][@"fireIntegral"];
            self.xjValueLabel.text = response[@"data"][@"availableBalance"];
            self.hotView.todayValueLabel.text = response[@"data"][@"todayIncome"];
            self.hotView.allValueLabel.text = response[@"data"][@"integral"];
        }
    }];
    
    [[MHUserService sharedInstance]initWithHSbiliCharge:@"BALANCE" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            CGFloat power = [response[@"data"] floatValue];
            self.hotView.rightLabel.text = [NSString stringWithFormat:@"1:%.f",1/power];
        }
    }];
    
    [self.jfView reloadViewData];
    [self.xjView reloadViewData];
}


-(void)huobi{
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
                                self.chargeLabel.text  = response[@"data"][@"withdrawIntegral"];
                                self.jihuoLabel.text = response[@"data"][@"freezeIntegral"];
                                self.jfValueLabel.text = response[@"data"][@"fireIntegral"];
                                self.xjValueLabel.text = response[@"data"][@"availableBalance"];
                                self.hotView.todayValueLabel.text = response[@"data"][@"todayIncome"];
                                self.hotView.allValueLabel.text = response[@"data"][@"integral"];
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

-(void)tixian{
    MHWithDrawVC *vc = [[MHWithDrawVC alloc] init];
    if (ValidStr(self.xjValueLabel.text)) {
        vc.withDrawMoney =  self.xjValueLabel.text;
    }else{
        vc.withDrawMoney =  @"0.00";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)duihuan{
    
    HSShopViewController *vc = [[HSShopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark EllipsePageControlDelegate。监听用户点击
-(void)ellipsePageControlClick:(EllipsePageControl *)pageControl index:(NSInteger)clickIndex{
    
    CGPoint position = CGPointMake(kRealValue(350)*clickIndex, 0);
    [self.scrollView setContentOffset:position animated:YES];
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
                        self.chargeLabel.text  = response[@"data"][@"withdrawIntegral"];
                        self.jihuoLabel.text = response[@"data"][@"freezeIntegral"];
                        self.jfValueLabel.text = response[@"data"][@"fireIntegral"];
                        self.xjValueLabel.text = response[@"data"][@"availableBalance"];
                        self.hotView.todayValueLabel.text = response[@"data"][@"todayIncome"];
                        self.hotView.allValueLabel.text = response[@"data"][@"integral"];
                    }
                }];
            }
            
        }else{
            KLToast(response[@"message"]);
        }
    }];
}


-(void)reloadHome{
    [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.chargeLabel.text  = response[@"data"][@"withdrawIntegral"];
            self.jihuoLabel.text = response[@"data"][@"freezeIntegral"];
            self.jfValueLabel.text = response[@"data"][@"fireIntegral"];
            self.xjValueLabel.text = response[@"data"][@"availableBalance"];
            self.hotView.todayValueLabel.text = response[@"data"][@"todayIncome"];
            self.hotView.allValueLabel.text = response[@"data"][@"integral"];
        }
    }];
}


-(void)xjreloadHome{
    [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.chargeLabel.text  = response[@"data"][@"withdrawIntegral"];
            self.jihuoLabel.text = response[@"data"][@"freezeIntegral"];
            self.jfValueLabel.text = response[@"data"][@"fireIntegral"];
            self.xjValueLabel.text = response[@"data"][@"availableBalance"];
            self.hotView.todayValueLabel.text = response[@"data"][@"todayIncome"];
            self.hotView.allValueLabel.text = response[@"data"][@"integral"];
        }
    }];
}


@end
