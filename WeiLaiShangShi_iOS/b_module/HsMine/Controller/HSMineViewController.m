//
//  HSMineViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/20.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSMineViewController.h"
#import "MHTeamPersionViewController.h"
#import "HSMyWalletController.h"
#import "MHMessageListViewController.h"
#import "MHMineUserInfoViewController.h"
#import "HSFriendShopViewController.h"
#import "HSChargeController.h"
#import "HSOrderVC.h"
#import "HSPaySuccessController.h"
#import "HSQRcodeVC.h"
#import "HSRewardController.h"
#import "MHWebviewViewController.h"
#import "UIAlertView+BlocksKit.h"
#import "HSChargeController.h"
#import "HSScrollView.h"
#import "UIImage+ViewColor.h"
#import "MHAboutMHViewController.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "UIButton+WebCache.h"
#import "HSPayStateWebViewController.h"
#import "RichStyleLabel.h"
#import "MHAboutMHViewController.h"


@interface HSMineViewController (){
    BOOL  isShow;
}

@property(nonatomic, strong)UIImageView *headimageview;
@property(nonatomic, strong)UIImageView *userleverImage ;
@property(nonatomic, strong)UIImageView *chenleverImage ;
@property(nonatomic, strong)UIImageView *mineOrderView;
@property(nonatomic, strong)UIImageView *leftView;
@property(nonatomic, strong)UIImageView *rightView;
@property(nonatomic, strong)UILabel *fuliTitle;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UIProgressView *processView;
@property(nonatomic, copy)  NSString *urlStr;
@property(nonatomic, copy)  NSString *shopStr;
@property(nonatomic, strong)UILabel *username;
@property(nonatomic, strong)RichStyleLabel *LoveLabel;
@property(nonatomic, strong)UILabel *integralLabel;
@property(nonatomic, strong)UILabel *todayIntegralLabel;
@property(nonatomic, strong)UILabel *huoIntegralLabel;
@property(nonatomic, strong)UILabel *huormbLabel;
@property(nonatomic, strong)UILabel *todayrmbLabel;
@property(nonatomic, strong)UILabel *allrmbLabel;
@property(nonatomic, strong)UILabel *moLabel;
@property(nonatomic, strong)UIButton *signBtn;
@property(nonatomic, strong)UIImageView *adImageView;
@property(nonatomic, strong)NSDictionary *userDict;
//@property(nonatomic, strong)UIImageView *walltOrderView;
@property(nonatomic, strong)UILabel *orderTitle;
@property(nonatomic, strong)NSMutableArray *fuliArr;

@property (nonatomic, strong) ZJAnimationPopView *VersionpopView;
@property(nonatomic, copy)NSString *gameUrl;
@property(nonatomic, copy)NSString *kefuUrl;
@property (nonatomic, strong)UIImageView *whyView;
@property (nonatomic, strong)UIImageView *tipArrow;
@property (nonatomic, strong)UILabel *tipLabel;


@end

@implementation HSMineViewController



-(void)checkAppUpdate
{
    [[MHUserService sharedInstance]initWithOS:@"IOS" channel:@"Appstore" version:[CTUUID getAppVersion] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            MHUpdateModel *model = [MHUpdateModel baseModelWithDic:response[@"data"]];
            if (model.forceUpgrade == 1) {
                //更新
                
                UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                contentViews.backgroundColor = [UIColor clearColor];
                
                UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(300), kRealValue(385))];
                forceUpdateImg.userInteractionEnabled = YES;
                forceUpdateImg.image = [UIImage imageNamed:@"home_update_bg"];
                [contentViews addSubview:forceUpdateImg];
                forceUpdateImg.centerX = contentViews.centerX;
                
                UILabel *leftLabel = [[UILabel alloc] init];
                leftLabel.text = @"升级到新版本";
                leftLabel.textColor = [UIColor colorWithHexString:@"#222222"];
                leftLabel.font = [UIFont systemFontOfSize:kFontValue(20)];
                [forceUpdateImg addSubview:leftLabel];
                [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(140));
                    make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                }];
                
                
                UIScrollView * updateScr = [[UIScrollView alloc]init];
                [contentViews addSubview:updateScr];
                [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                    make.right.equalTo(forceUpdateImg.mas_right).offset(kRealValue(-25));
                    make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(170));
                    make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(kRealValue(-82));
                    
                }];
                UIView *updateContentView = [[UIView alloc]init];
                [updateScr addSubview:updateContentView];
                [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(updateScr);
                    make.width.equalTo(updateScr);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.numberOfLines = 0;
                label.textColor = [UIColor colorWithHexString:@"#444444"];
                NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
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
                
                UIButton *update_btn = [[UIButton alloc] init];
                [update_btn setTitle:@"立即升级" forState:UIControlStateNormal];
                update_btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
                [update_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
                [update_btn bk_addEventHandler:^(id sender) {
                    //更新按钮
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                } forControlEvents:UIControlEventTouchUpInside];
                ViewRadius(update_btn, kRealValue(5));
                [forceUpdateImg addSubview:update_btn];
                [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
                    make.centerX.equalTo(forceUpdateImg.mas_centerX);
                    make.width.mas_equalTo(kRealValue(220));
                    make.height.mas_equalTo(kRealValue(35));
                }];
                
                self.VersionpopView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                // 3.2 显示时背景的透明度
                self.VersionpopView.popBGAlpha = 0.5f;
                // 3.3 显示时是否监听屏幕旋转
                self.VersionpopView.isObserverOrientationChange = YES;
                // 3.4 显示时动画时长
                self.VersionpopView.popAnimationDuration = 0.5f;
                // 3.5 移除时动画时长
                self.VersionpopView.dismissAnimationDuration = 0.3f;
                
                // 3.6 显示完成回调
                self.VersionpopView.popComplete = ^{
                    MHLog(@"显示完成");
                };
                // 3.7 移除完成回调
                self.VersionpopView.dismissComplete = ^{
                    MHLog(@"移除完成");
                };
                [self.VersionpopView pop];
                
                
            }else{
                
                if (model.upgrade == 1) {
                    //非强制更新
                    
                    UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    contentViews.backgroundColor = [UIColor clearColor];
                    
                    UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(150), kRealValue(300), kRealValue(385))];
                    forceUpdateImg.userInteractionEnabled = YES;
                    forceUpdateImg.image = [UIImage imageNamed:@"home_update_bg"];
                    [contentViews addSubview:forceUpdateImg];
                    forceUpdateImg.centerX = contentViews.centerX;
                    
                    UILabel *leftLabel = [[UILabel alloc] init];
                    leftLabel.text = @"升级到新版本";
                    leftLabel.textColor = [UIColor colorWithHexString:@"#222222"];
                    leftLabel.font = [UIFont systemFontOfSize:kFontValue(20)];
                    [forceUpdateImg addSubview:leftLabel];
                    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(140));
                        make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                    }];
                    
                    
                    UIScrollView * updateScr = [[UIScrollView alloc]init];
                    [contentViews addSubview:updateScr];
                    [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                        make.right.equalTo(forceUpdateImg.mas_right).offset(kRealValue(-25));
                        make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(170));
                        make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(kRealValue(-82));
                        
                    }];
                    UIView *updateContentView = [[UIView alloc]init];
                    [updateScr addSubview:updateContentView];
                    [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(updateScr);
                        make.width.equalTo(updateScr);
                    }];
                    UILabel *label = [[UILabel alloc]init];
                    label.numberOfLines = 0;
                    label.textColor = [UIColor colorWithHexString:@"#444444"];
                    NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
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
                    
                    UIButton *update_btn = [[UIButton alloc] init];
                    [update_btn setTitle:@"立即升级" forState:UIControlStateNormal];
                    update_btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
                    [update_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
                    [update_btn bk_addEventHandler:^(id sender) {
                        //更新按钮
                        [self.VersionpopView dismiss];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                    } forControlEvents:UIControlEventTouchUpInside];
                    ViewRadius(update_btn, kRealValue(5));
                    [forceUpdateImg addSubview:update_btn];
                    [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
                        make.centerX.equalTo(forceUpdateImg.mas_centerX);
                        make.width.mas_equalTo(kRealValue(220));
                        make.height.mas_equalTo(kRealValue(35));
                    }];
                    
                    self.VersionpopView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                    // 3.2 显示时背景的透明度
                    self.VersionpopView.popBGAlpha = 0.5f;
                    // 3.3 显示时是否监听屏幕旋转
                    self.VersionpopView.isObserverOrientationChange = YES;
                    // 3.4 显示时动画时长
                    self.VersionpopView.popAnimationDuration = 0.5f;
                    // 3.5 移除时动画时长
                    self.VersionpopView.dismissAnimationDuration = 0.3f;
                    
                    // 3.6 显示完成回调
                    self.VersionpopView.popComplete = ^{
                        MHLog(@"显示完成");
                    };
                    // 3.7 移除完成回调
                    self.VersionpopView.dismissComplete = ^{
                        MHLog(@"移除完成");
                    };
                    [self.VersionpopView pop];
                    
                    
                    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
                    [closeBtn bk_addEventHandler:^(id sender) {
                        [self.VersionpopView dismiss];
                        [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert = @"No";
                        
                        
                    } forControlEvents:UIControlEventTouchUpInside];
                    [contentViews addSubview:closeBtn];
                    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
                        make.right.mas_equalTo(forceUpdateImg.mas_right);
                        make.size.mas_equalTo(CGSizeMake(25, 25));
                    }];
                }
                
            }
            
        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    isShow = YES;
    self.fuliArr = [NSMutableArray array];
    HSScrollView *updateScr = [[HSScrollView alloc]init];
    updateScr.userInteractionEnabled = YES;
    updateScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:updateScr];
    [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view .mas_left).offset(0);
        make.right.equalTo(self.view .mas_right).offset(0);
        make.top.equalTo(self.view .mas_top).offset(0);
        make.height.mas_equalTo(kScreenHeight-kTabBarHeight);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.userInteractionEnabled = YES;
    [updateScr addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(updateScr);
        make.width.equalTo(updateScr);
    }];
    self.contentView  = contentView;
    
    
    _headimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(49), kRealValue(44), kRealValue(44))];
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSet)];
    _headimageview.userInteractionEnabled = YES;
    [_headimageview addGestureRecognizer:headTap];
    ViewRadius(_headimageview, kRealValue(22));
    [contentView addSubview:_headimageview];
    
    
    
    UIImageView *arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth  - kRealValue(20), 0,kRealValue(6),kRealValue(10))];
    arrowImageView.image = kGetImage(@"my_next_icon");
    [contentView addSubview:arrowImageView];
    arrowImageView.centerY  = _headimageview.centerY;

    _username = [[UILabel alloc]init];
    _username.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _username.textColor = [UIColor colorWithHexString:@"#222222"];
    _username.textAlignment = NSTextAlignmentLeft;
    _username.text =@"    ";
    [contentView addSubview:_username];
    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(11));
        make.top.equalTo(self.headimageview.mas_top).offset(-kRealValue(2));
    }];
    

    
    _userleverImage = [[UIImageView alloc]init];
//    _userleverImage.image = kGetImage(@"user_yvip");
    [contentView addSubview:_userleverImage];
    [_userleverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(11));
        make.bottom.equalTo(self.headimageview.mas_bottom).offset(kRealValue(2));
        make.size.mas_equalTo(CGSizeMake(kRealValue(77), kRealValue(19)));
    }];
    
    
    
//    self.signBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(84) , 0, kRealValue(84), kRealValue(26))];
//
//    [self.signBtn setTitle:@"签到领火币" forState:0];
//    self.signBtn.hidden = YES;
//    [self.signBtn setTitle:@"已签到" forState:UIControlStateDisabled];
//    self.signBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
//    //    [self.signBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:0];
//    [self.signBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#D9D8D8"]] forState:UIControlStateDisabled];
//    [self.signBtn  addTarget:self action:@selector(pushSign) forControlEvents:UIControlEventTouchUpInside];
//    [contentView addSubview:self.signBtn ];
//
//
//
//    [self.signBtn  setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"#FF6941"],[UIColor colorWithHexString:@"#F6AC19"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(84), kRealValue(26))] forState:UIControlStateNormal];
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.signBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kRealValue(13), kRealValue(13))];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.signBtn.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.signBtn.layer.mask = maskLayer;
    
    _LoveLabel = [[RichStyleLabel alloc]init];
    _LoveLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    _LoveLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _LoveLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:_LoveLabel];
    [_LoveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userleverImage.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.userleverImage.mas_centerY).offset(-kRealValue(6));
    }];
    

    
    
    _processView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [contentView addSubview:_processView];
    _processView.trackTintColor = [UIColor colorWithHexString:@"#FCD4CB"];
    _processView.progressTintColor = [UIColor colorWithHexString:@"#E95520"];
    [_processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userleverImage.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.LoveLabel.mas_bottom).offset(kRealValue(1));
        make.size.mas_equalTo(CGSizeMake(kRealValue(97), kRealValue(3)));
    }];
    
    _chenleverImage = [[UIImageView alloc]init];
    [contentView addSubview:_chenleverImage];
    [_chenleverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.username.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.username.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(77), kRealValue(24)));
    }];
    
    
    
    
    
    _adImageView = [[UIImageView alloc]init];
    _adImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [_adImageView addGestureRecognizer:imageTap];
    
    [contentView addSubview:_adImageView];
    [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LoveLabel.mas_bottom).offset(kRealValue(30));
        make.centerX.equalTo(contentView.mas_centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(351), kRealValue(84)));
    }];
    
    

    
    UIButton *walletBtn = [[UIButton alloc] init];
    walletBtn.backgroundColor = [UIColor clearColor];
    [walletBtn addTarget:self action:@selector(pushSet) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:walletBtn];
    [walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(contentView.mas_right).offset(0);
        make.bottom.equalTo(self.headimageview.mas_bottom).offset(0);
        make.width.mas_equalTo(kRealValue(90));
    }];
    
    
    

    
    
    //问号 why_icon
    self.whyView = [[UIImageView alloc] init];
    self.whyView .image = kGetImage(@"why_icon");
    self.whyView .userInteractionEnabled = YES;
    [contentView addSubview:self.whyView ];
    [self.whyView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoveLabel.mas_right).offset(kRealValue(3));
        make.centerY.equalTo(self.LoveLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(10), kRealValue(10)));
    }];
    
    
    UIButton *whyShow = [[UIButton alloc] init];
    whyShow.backgroundColor = [UIColor clearColor];
    [whyShow addTarget:self action:@selector(tipShow) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:whyShow];
    [whyShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.LoveLabel.mas_right).offset(kRealValue(40));
        make.centerY.equalTo(self.LoveLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(150), kRealValue(25)));
    }];
    
    
    
    self.tipArrow = [[UIImageView alloc] init];
    self.tipArrow .image = kGetImage(@"why_boom");
    self.tipArrow.hidden = YES;
    [contentView addSubview:self.tipArrow ];
    [self.tipArrow  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.LoveLabel.mas_top).offset(-kRealValue(1));
        make.centerX.equalTo(self.whyView.mas_centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(9), kRealValue(5)));
    }];
    
    _tipLabel = [[UILabel alloc]init];
    self.tipLabel.hidden = YES;
    _tipLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    _tipLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.text = @" 当前剩余/累计获得 ";
    ViewRadius(_tipLabel, kRealValue(2));
    _tipLabel.backgroundColor = [UIColor colorWithHexString:@"#9C9C9C"];
    [contentView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tipArrow.mas_top).offset(0);
        make.left.equalTo(self.tipArrow.mas_left).offset(-kRealValue(26));
        make.size.mas_equalTo(CGSizeMake(kRealValue(97), kRealValue(17)));
    }];
    
    
    
    
    UIButton *MessagetBtn = [[UIButton alloc] init];
    [MessagetBtn setImage:kGetImage(@"user_information") forState:0];;
    [MessagetBtn addTarget:self action:@selector(pushMessage) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:MessagetBtn];
    [MessagetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(kRealValue(5));
        make.right.equalTo(contentView.mas_right).offset(-kRealValue(5));
        make.width.mas_equalTo(kRealValue(44));
        make.height.mas_equalTo(kRealValue(44));
    }];

    
        self.leftView = [[UIImageView alloc]init];
        self.leftView.userInteractionEnabled = YES;
        ViewRadius(self.leftView, kRealValue(4));
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
        [self.leftView addGestureRecognizer:tap1];
        [contentView addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.adImageView.mas_bottom).offset(kRealValue(14));
            make.left.equalTo(contentView.mas_left).offset(kRealValue(12));
            make.size.mas_equalTo(CGSizeMake(kRealValue(170), kRealValue(94)));
        }];
    
    
        self.rightView = [[UIImageView alloc]init];
        ViewRadius(self.rightView, kRealValue(4));
        [contentView addSubview:self.rightView];
        self.rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bossClick)];
        [self.rightView addGestureRecognizer:tap2];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.adImageView.mas_bottom).offset(kRealValue(14));
            make.right.equalTo(contentView.mas_right).offset(-kRealValue(13));
            make.size.mas_equalTo(CGSizeMake(kRealValue(170), kRealValue(94)));
        }];
    
    
//
//    UILabel *walltTitle = [[UILabel alloc] init];
//    walltTitle.text = @"我的钱包";
//    walltTitle.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(18)];
//    walltTitle.textColor = [UIColor colorWithHexString:@"#222222"];
//    [contentView addSubview:walltTitle];
//    [walltTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.adImageView.mas_bottom).offset(kRealValue(13));
//        make.left.equalTo(contentView.mas_left).offset(kRealValue(14));
//    }];
//
    
    
//
//    UIButton *withDrawBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(80), kRealValue(220), kRealValue(70), kRealValue(30))];
//    [withDrawBtn setTitle:@"提现兑换" forState:0];
//    [withDrawBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:0];
//    withDrawBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    [withDrawBtn setImage:kGetImage(@"my_next_icon") forState:0];
//    [withDrawBtn addTarget:self action:@selector(pushWallet) forControlEvents:UIControlEventTouchUpInside];
//    [withDrawBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -
//                                             withDrawBtn.imageView.frame.size.width -  kRealValue(5), 0, withDrawBtn.imageView.frame.size.width + kRealValue(5))];
//    [withDrawBtn setImageEdgeInsets:UIEdgeInsetsMake(0, withDrawBtn.titleLabel.bounds.size.width + kRealValue(5), 0, - withDrawBtn.titleLabel.bounds.size.width - kRealValue(5))];
//    [contentView addSubview:withDrawBtn];
    
    
//    UIImageView *walltOrderView = [[UIImageView alloc]init];
//    walltOrderView.userInteractionEnabled = YES;
//    walltOrderView.image = kGetImage(@"icon_user_all");
//    [contentView addSubview:walltOrderView];
//    [walltOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(walltTitle.mas_bottom).offset(kRealValue(6));
//        make.centerX.equalTo(contentView.mas_centerX).offset(0);
//        make.size.mas_equalTo(CGSizeMake(kRealValue(363), kRealValue(176)));
//    }];
//    UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushWallet)];
//    [walltOrderView addGestureRecognizer:Img3tap];
//
//    self.walltOrderView = walltOrderView;
//
    
    
//        UILabel *xianjinLabel = [[UILabel alloc] init];
//        xianjinLabel.text = @"现金账户（元）";
//        xianjinLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//        xianjinLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//        [walltOrderView addSubview:xianjinLabel];
//        [xianjinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(walltOrderView.mas_top).offset(kRealValue(23));
//            make.left.equalTo(walltOrderView.mas_left).offset(kRealValue(20));
//        }];
//
//
//
//        self.moLabel = [[UILabel alloc] init];
//        self.moLabel.text = @"   ";
//        self.moLabel.textAlignment = NSTextAlignmentCenter;
//        self.moLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(25)];
//        self.moLabel.textColor = [UIColor colorWithHexString:@"#222222"];
//        [walltOrderView addSubview:self.moLabel];
//        [self.moLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(xianjinLabel.mas_bottom).offset(kRealValue(6));
//            make.left.equalTo(xianjinLabel.mas_left).offset(0);
//        }];
//
//
//
//        UILabel *jifenLabel = [[UILabel alloc] init];
//        jifenLabel.text = @"火币账户(火币）";
//        jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//        jifenLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//        [walltOrderView addSubview:jifenLabel];
//        [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(walltOrderView.mas_top).offset(kRealValue(90));
//            make.centerX.equalTo(walltOrderView.mas_centerX).offset(0);
//        }];
//
//
//
//        self.integralLabel = [[UILabel alloc] init];
//        self.integralLabel.textAlignment = NSTextAlignmentLeft;
//        self.integralLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
//        self.integralLabel.textColor = [UIColor colorWithHexString:@"222222"];
//        [walltOrderView addSubview:self.integralLabel];
//        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(jifenLabel.mas_bottom).offset(kRealValue(5));
//            make.left.equalTo(jifenLabel.mas_left).offset(0);
//        }];
//
//
//        self.allrmbLabel = [[UILabel alloc] init];
//        self.allrmbLabel.text = @"  ";
//        self.allrmbLabel.textAlignment = NSTextAlignmentLeft;
//        self.allrmbLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
//        self.allrmbLabel.textColor = [UIColor colorWithHexString:@"222222"];
//        [walltOrderView addSubview:self.allrmbLabel];
//        [self.allrmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.integralLabel.mas_bottom).offset(kRealValue(2));
//            make.left.equalTo(jifenLabel.mas_left).offset(0);
//        }];
//
//        UILabel *todayLabel = [[UILabel alloc] init];
//        todayLabel.text = @"今日收入(火币)";
//        todayLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//        todayLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//        [walltOrderView addSubview:todayLabel];
//        [todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(walltOrderView.mas_top).offset(kRealValue(90));
//            make.left.equalTo(walltOrderView.mas_left).offset(kRealValue(20));
//        }];
//
    
//
//        self.todayIntegralLabel = [[UILabel alloc] init];
//        self.todayIntegralLabel.text = @"  ";
//        self.todayIntegralLabel.textAlignment = NSTextAlignmentLeft;
//        self.todayIntegralLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
//        self.todayIntegralLabel.textColor = [UIColor colorWithHexString:@"222222"];
//        [walltOrderView addSubview:self.todayIntegralLabel];
//        [self.todayIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(jifenLabel.mas_bottom).offset(kRealValue(5));
//            make.left.equalTo(walltOrderView.mas_left).offset(kRealValue(20));
//        }];
//
//    self.todayrmbLabel = [[UILabel alloc] init];
//    self.todayrmbLabel.text = @"  ";
//    self.todayrmbLabel.textAlignment = NSTextAlignmentLeft;
//    self.todayrmbLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
//    self.todayrmbLabel.textColor = [UIColor colorWithHexString:@"222222"];
//    [walltOrderView addSubview:self.todayrmbLabel];
//    [self.todayrmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.todayIntegralLabel.mas_bottom).offset(kRealValue(2));
//        make.left.equalTo(walltOrderView.mas_left).offset(kRealValue(20));
//    }];
//
//
//
//
//
//    UILabel *huoLabel = [[UILabel alloc] init];
//    huoLabel.text = @"累计收入(火币)";
//    huoLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    huoLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//    [walltOrderView addSubview:huoLabel];
//    [huoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(walltOrderView.mas_top).offset(kRealValue(90));
//        make.right.equalTo(walltOrderView.mas_right).offset(-kRealValue(36));
//    }];
//
//
//
//    self.huoIntegralLabel = [[UILabel alloc] init];
//    self.huoIntegralLabel.text = @"  ";
//    self.huoIntegralLabel.textAlignment = NSTextAlignmentLeft;
//    self.huoIntegralLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
//    self.huoIntegralLabel.textColor = [UIColor colorWithHexString:@"222222"];
//    [walltOrderView addSubview:self.huoIntegralLabel];
//    [self.huoIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(huoLabel.mas_bottom).offset(kRealValue(5));
//        make.left.equalTo(huoLabel.mas_left).offset(0);
//    }];
//
//    self.huormbLabel = [[UILabel alloc] init];
//    self.huormbLabel.text = @"  ";
//    self.huormbLabel.textAlignment = NSTextAlignmentLeft;
//    self.huormbLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
//    self.huormbLabel.textColor = [UIColor colorWithHexString:@"222222"];
//    [walltOrderView addSubview:self.huormbLabel];
//    [self.huormbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.huoIntegralLabel.mas_bottom).offset(kRealValue(2));
//        make.left.equalTo(huoLabel.mas_left).offset(0);
//    }];
//
    

    
    
    
    self.orderTitle = [[UILabel alloc] init];
    self.orderTitle.text = @"更多服务";
    self.orderTitle.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(18)];
    self.orderTitle.textColor = [UIColor colorWithHexString:@"#222222"];
    [contentView addSubview:self.orderTitle];
    [self.orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView.mas_bottom).offset(kRealValue(13));
        make.left.equalTo(contentView.mas_left).offset(kRealValue(14));
    }];

    
    
    self.mineOrderView = [[UIImageView alloc]init];
    self.mineOrderView.userInteractionEnabled = YES;
    self.mineOrderView.image = kGetImage(@"user_mbg");
    [contentView addSubview:self.mineOrderView];
    [self.mineOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTitle.mas_bottom).offset(kRealValue(6));
        make.centerX.equalTo(contentView.mas_centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(kRealValue(363), kRealValue(226)));
    }];
    

    
    NSArray *orderPicArr = @[@"user_icon_order",@"user_icon_team",@"user_icon_ewm",@"user_icon_note"];
    NSArray *orderNameArr = @[@"我的订单",@"我的团队",@"推广二维码",@"奖励记录"];
    
    NSArray *toolPicArr = @[@"user_tool",@"user_service",@"hez_icon",@"rwgf_icon",@"user_version",@"user_set"];
    NSArray *toolNameArr = @[@"玩法攻略",@"客服中心",@"招商加盟",@"任务规范",@"版本更新",@"设置"];
    
    
    NSArray *thridPicArr = @[@"user_version",@"user_set"];
    NSArray *thridNameArr = @[@"版本更新",@"设置"];
    
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*kRealValue(363)/4, kRealValue(20), kRealValue(363)/4, kRealValue(60));
        btn.tag = 4370+i;
        [btn addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:orderNameArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:orderPicArr[i]] forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:kRealValue(12)];
        [self initButton:btn];
        [self.mineOrderView  addSubview:btn];
        
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(i*kRealValue(360)/4, kRealValue(80), kRealValue(363)/4, kRealValue(60));
        [btn1 setTitle:toolNameArr[i] forState:UIControlStateNormal];
        btn1.tag = 5200 + i;
        [btn1 addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setImage:[UIImage imageNamed:toolPicArr[i]] forState:0];
        [btn1 setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:kRealValue(12)];
        [self initButton:btn1];
        [self.mineOrderView  addSubview:btn1];
        
    }
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*kRealValue(363)/4, kRealValue(140), kRealValue(363)/4, kRealValue(60));
        btn.tag = 5300+i;
        [btn addTarget:self action:@selector(pushOtherVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:thridNameArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:thridPicArr[i]] forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:kRealValue(12)];
        [self initButton:btn];
        [self.mineOrderView  addSubview:btn];
        
    }
    

    
 
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mineOrderView.mas_bottom).with.offset(kRealValue(20));
    }];
    
    
    
}


-(void)tipShow{
    
    if (isShow == YES) {
        self.tipLabel.hidden = NO;
        self.tipArrow.hidden = NO;
    }else{
        self.tipLabel.hidden = YES;
        self.tipArrow.hidden = YES;
    }
    isShow = !isShow;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

-(void)pushWallet{
    HSMyWalletController *vc = [[HSMyWalletController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)pushMessage{
    //消息入口
//    NSString *Str1 =  [NSString stringWithFormat:@"%@%@%@%@%@",@"3581",[CTUUID getIDFA],@"1",@"1011",@"qmjrgasw6khshao1"];
//
//    NSString *Str = [NSString stringWithFormat:@"https://h5.51xianwan.com/try/iOS/try_list_ios.aspx?ptype=%@&deviceid=%@&appid=%@&appsign=%@&keycode=%@",@"1",[CTUUID getIDFA],@"3581",@"1011",[Str1 md5String]];
//    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://www.jiexunhui.com/login.html" comefrom:@""];
//     [self.navigationController pushViewController:vc animated:YES];
 
    MHMessageListViewController *VC = [[MHMessageListViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)imageClick{
    
    if (ValidStr([GVUserDefaults standardUserDefaults].shenghe)) {
        if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"SVIP"]){
            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:self.urlStr comefrom:@"charge"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            HSChargeController *vc = [[HSChargeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

}

-(void)pushOtherVC:(UIButton *)sender{
    if (sender.tag == 4371) {
        //粉丝统计
        if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
            
            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                    message:@"请先升级会员"
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@[@"去升级"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                              if (buttonIndex == 1)
                                                              {
                                                                  HSChargeController *vc = [[HSChargeController alloc] init];
                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                              }
                                                          }];
            
            [alertView show];
            
        }else{
            
            MHTeamPersionViewController *vc = [[MHTeamPersionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }else if (sender.tag == 4370){
        //我的订单
        HSOrderVC *vc = [[HSOrderVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 4372){
        if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
           
            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                    message:@"升级为会员后才可拥有推广二维码"
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@[@"去升级"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                              if (buttonIndex == 1)
                                                              {
                                                                  HSChargeController *vc = [[HSChargeController alloc] init];
                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                              }
                                                          }];
            
            [alertView show];
            
        }else{
            
            HSQRcodeVC *vc = [[HSQRcodeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }else if (sender.tag == 4373){
        
        HSRewardController *vc = [[HSRewardController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 5301){
      //设置
        MHMineUserInfoViewController *vc = [[MHMineUserInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 5201){
        //客服
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:self.kefuUrl comefrom:@"shopStr"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 5200){
        //客服
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:self.gameUrl comefrom:@"shopStr"];
        [self.navigationController pushViewController:vc animated:YES];
        
    
    }else if (sender.tag == 5300){
        MHAboutMHViewController *vc = [[MHAboutMHViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [self showUpdateView];
    }else if (sender.tag == 5202){
        //商业合
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/join.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 5203){
        //商业合作
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://mp.weixin.qq.com/mp/homepage?__biz=MzU2MTg0NjYzOA==&hid=2&sn=170ae74e46aa0950e77553aabdeb6bae" comefrom:@"shopStr"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


-(void)pushSet{
    //设置
    MHMineUserInfoViewController *vc = [[MHMineUserInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
//    if ([[GVUserDefaults standardUserDefaults].ShowAppUpdateAlert isEqualToString:@"Yes"]) {
//        [self checkAppUpdate];
//    }
    
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.userDict = response;
//            basePower
            //名字
            self.username.text  = response[@"data"][@"nickname"];
            
            //等级
            if ([response[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                self.userleverImage.image = kGetImage(@"user_novip");
            }else if ([response[@"data"][@"userRole"] isEqualToString:@"VIP"]){
                self.userleverImage.image = kGetImage(@"user_yvip");
            }else if ([response[@"data"][@"userRole"] isEqualToString:@"SVIP"]){
                self.userleverImage.image = kGetImage(@"user_vip");
            }
            if ([response[@"data"][@"vipCastellan"] integerValue]  == 1) {
                  self.chenleverImage.image = kGetImage(@"Silver_cz_icon");
            }else{
                self.chenleverImage.image = nil;
            }
            if ([response[@"data"][@"svipCastellan"] integerValue]  == 1) {
                self.chenleverImage.image = kGetImage(@"gold_cz_icon");
            }
            //头像
            [self.headimageview sd_setImageWithURL:[NSURL URLWithString: response[@"data"][@"avatar"]] placeholderImage:nil];
            
           [self.LoveLabel setAttributedText:[NSString stringWithFormat:@"友力值 %d/%d",[response[@"data"][@"availablePower"] intValue],[response[@"data"][@"basePower"]intValue]] withRegularPattern:@"[0-9.,/]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#E95520"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(11)]}];
            if ([response[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                self.LoveLabel.hidden = NO;
                self.processView.hidden = NO;
                self.processView.progress = 0;
            }else{
               self.LoveLabel.hidden = NO;
               self.processView.hidden = NO;
                //分母不能为0
                if ([response[@"data"][@"basePower"]floatValue] == 0) {
                    self.processView.hidden = YES;
                }else{
                    self.processView.hidden = NO;
                    if ([response[@"data"][@"availablePower"] floatValue]>=[response[@"data"][@"basePower"]floatValue]) {
                        self.processView.progress = 1;
                    }else{
                        self.processView.progress = [response[@"data"][@"availablePower"] floatValue]/[response[@"data"][@"basePower"]floatValue];
                    }
                }
                
            }

            [GVUserDefaults standardUserDefaults].phone = response[@"data"][@"phone"];
            [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
            [[MHUserService sharedInstance]initWithFirstPageComponent:@"3" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *imgArr = response[@"data"];
                    [imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj[@"type"] isEqualToString:@"FRIEND_STRENGTH_SHOP"]) {
      
                            [self.rightView sd_setImageWithURL:[NSURL URLWithString:obj[@"result"][0][@"sourceUrl"]] placeholderImage:kGetImage(@"emty_movie")];
                            self.shopStr = obj[@"result"][0][@"actionUrl"];
                        }
                        
                        if ([obj[@"type"] isEqualToString:@"CUSTOMER_CENTER"]) {
                            self.kefuUrl  = obj[@"result"][0][@"actionUrl"];
                        }
                        
                        if ([obj[@"type"] isEqualToString:@"GAME_STRATEGY"]) {
                            self.gameUrl  = obj[@"result"][0][@"actionUrl"];
                        }
                        
                        if ([obj[@"type"] isEqualToString:@"AD"]) {
                               [self.leftView sd_setImageWithURL:[NSURL URLWithString:obj[@"result"][0][@"sourceUrl"]] placeholderImage:kGetImage(@"emty_movie")];
                        }
                        
                        if ([obj[@"type"] isEqualToString:@"MEMBER_UPGRADE"]) {
                            
                            //等级
                            if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                                [self.adImageView sd_setImageWithURL:[NSURL URLWithString:obj[@"result"][0][@"sourceUrl"]] placeholderImage:nil];
                            }else if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"VIP"]){
                                [self.adImageView sd_setImageWithURL:[NSURL URLWithString:obj[@"result"][1][@"sourceUrl"]] placeholderImage:nil];
                            }else if ([self.userDict[@"data"][@"userRole"] isEqualToString:@"SVIP"]){
                                [self.adImageView sd_setImageWithURL:[NSURL URLWithString:obj[@"result"][2][@"sourceUrl"]] placeholderImage:nil];
                                self.urlStr = obj[@"result"][2][@"actionUrl"];
                            }
                        }
                        
                    }];
                    
                    
                }
            }];
            
        }
    }];

    [[MHUserService sharedInstance]initwithHSQiandaoInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.signBtn.hidden = NO;
            NSDictionary *dict = [response valueForKey:@"data"][@"userIntegral"];
            if ([dict[@"signIn"] integerValue] == 1) {
                self.signBtn.enabled = NO;
            }else{
                self.signBtn.enabled = YES;
            }
            if (ValidStr([GVUserDefaults standardUserDefaults].shenghe)) {
                 self.signBtn.hidden = NO;
            }else{
                self.signBtn.hidden = YES;
            }
        }
    }];
    
    
    [[MHUserService sharedInstance]initwithHSAllMoneyCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.integralLabel.text  = response[@"data"][@"withdrawIntegral"];
            self.moLabel.text  = response[@"data"][@"availableBalance"];
            self.huoIntegralLabel.text  = response[@"data"][@"integral"];
            self.todayIntegralLabel.text  = response[@"data"][@"todayIncome"];
            self.huormbLabel.text = [NSString stringWithFormat:@"≈%@元",response[@"data"][@"integralMoney"]];
            self.todayrmbLabel.text = [NSString stringWithFormat:@"≈%@元",response[@"data"][@"todayIncomeMoney"]];
            self.allrmbLabel.text = [NSString stringWithFormat:@"≈%@元",response[@"data"][@"withdrawIntegralMoney"]];
        }
    }];
    
    [[MHUserService sharedInstance]initwithHSFuliCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [self.fuliArr enumerateObjectsUsingBlock:^(UIButton  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{//2秒以后移除
                    [obj removeFromSuperview];
               
                });
            }];
            [self.fuliTitle removeFromSuperview];
            [self.fuliArr  removeAllObjects];
            NSArray *arr  = response[@"data"];
            if ([arr count] !=0) {
                self.fuliTitle = [[UILabel alloc] init];
                self.fuliTitle.text = @"福利社";
                self.fuliTitle.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(18)];
                self.fuliTitle.textColor = [UIColor colorWithHexString:@"#222222"];
                [self.contentView addSubview:self.fuliTitle];
                [self.fuliTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.leftView.mas_bottom).offset(kRealValue(13));
                    make.left.equalTo(self.contentView.mas_left).offset(kRealValue(14));
                }];
            }else{
                [self.orderTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.leftView.mas_bottom).offset(kRealValue(13));
                    make.left.equalTo(self.contentView.mas_left).offset(kRealValue(14));
                }];
            }
            [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(12) + (idx%3) * kRealValue(119), idx >= 3?kRealValue(470):kRealValue(350), kRealValue(114), kRealValue(114))];
                [btn sd_setImageWithURL:[NSURL URLWithString:obj[@"icon"]] forState:0];
                [btn bk_addEventHandler:^(id sender) {
                    //商业合作
                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:obj[@"url"] comefrom:@"shopStr"];
                    [self.navigationController pushViewController:vc animated:YES];
                } forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:btn];
                [self.fuliArr addObject:btn];
                if (idx == [arr count] -1) {
                    [self.orderTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(kRealValue(10));
                        make.left.equalTo(self.contentView.mas_left).offset(kRealValue(14));
                    }];
                }
            }];
        }
    }];
    
    
}


//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)btn{
    float  spacing = kRealValue(5);//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


-(void)pushSign{
    
    self.tabBarController.selectedIndex = 1;
}

-(void)shopClick{
    //商业合作
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/join.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)bossClick{
    //友力值
    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
