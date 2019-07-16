//
//  HSNewsViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/20.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsViewController.h"
#import "SGPagingView.h"
#import "HSNewsAllTypesViewController.h"
#import "HSNewsFilmViewController.h"
#import "MHBaseTableView.h"
#import "HSCategoryModel.h"
#import "ZJAnimationPopView.h"
#import "HSNewsVideoViewController.h"
#import "HSNewsRecommendViewController.h"
#import "MHLoginViewController.h"
#import "UIControl+BlocksKit.h"
#import "MHWebviewViewController.h"
#import "HSPlusButton.h"
#import "HSMemberViewController.h"
#import "UIGestureRecognizer+BlocksKit.h"
#import "RichStyleLabel.h"
#import "HSMyWalletController.h"
#import "HSBannerModel.h"

@interface HSNewsViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *ControllerArr;
@property (nonatomic, strong) NSMutableArray *cateArr;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;
@property (nonatomic, strong) ZJAnimationPopView *popView;
@property (nonatomic, strong) ZJAnimationPopView *popView2;
@property (nonatomic, strong) ZJAnimationPopView *VersionpopView;
@property (nonatomic, strong)UIImageView *imge1;
@property (nonatomic, strong)UIImageView *imge2;
@property (nonatomic, strong)UIImageView *imge3;
@property (nonatomic, strong)UIImageView *close ;
@property (nonatomic, assign) NSInteger *index;
@property (nonatomic, strong)UIButton *qiandaoimg;
@property (nonatomic, strong)ZJAnimationPopView *qiandaoPopView3;
@property (nonatomic, strong)NSString *qiandaoStr;
@end

@implementation HSNewsViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (int i = 0; i < window.subviews.count; i++) {
        NSLog(@"%@",window.subviews[i]);
        if ([window.subviews[i] isKindOfClass:[ZJAnimationPopView class]]) {
            window.subviews[i].hidden = YES;
        }
    }
    [self checkAppUpdate];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (int i = 0; i < window.subviews.count; i++) {
        NSLog(@"%@",window.subviews[i]);
        if ([window.subviews[i] isKindOfClass:[ZJAnimationPopView class]]) {
            window.subviews[i].hidden = NO;
            
        }
    }
     [self getqiandaoInfo];
    
    [self GetAlertData];
    
    
}
- (NSString *)filePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"alert.plist"];
}
- (NSString *)filePath1
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Havealert.plist"];
}
-(void)GetAlertData
{
    __block NSMutableArray *alertArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initwithHsAlertCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
          // 数据获取下来 本地存储
            
            for (int i = 0; i < [response[@"data"] count]; i++) {
                HSBannerModel *model = [[HSBannerModel alloc]init];;
               
                  model.title = [NSString stringWithFormat:@"%@",response[@"data"][i][@"title"]] ;
                  model.content = [NSString stringWithFormat:@"%@",response[@"data"][i][@"content"]];
                  model.contentType = [NSString stringWithFormat:@"%@",response[@"data"][i][@"contentType"]];
                  model.action_url = [NSString stringWithFormat:@"%@",response[@"data"][i][@"actionUrl"]];
                  model.type = [NSString stringWithFormat:@"%@",response[@"data"][i][@"type"]];
                  model.id = [NSString stringWithFormat:@"%@",response[@"data"][i][@"id"]];
                  model.bulletBoxType = [NSString stringWithFormat:@"%@",response[@"data"][i][@"bulletBoxType"]];
                  model.bulletBoxFilling = [NSString stringWithFormat:@"%@",response[@"data"][i][@"bulletBoxFilling"]];
                  model.onlyPopUpOnce = [NSString stringWithFormat:@"%@",response[@"data"][i][@"onlyPopUpOnce"]];
                  model.statu = @"PENDING" ;
                  model.uerphone =[GVUserDefaults standardUserDefaults].phone;
                
                
              
               
                [alertArr addObject:model];
            }
            NSMutableArray *havealertArrold = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath1]];
            NSMutableArray *samearr = [NSMutableArray array];
            [alertArr enumerateObjectsUsingBlock:^(HSBannerModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                [havealertArrold enumerateObjectsUsingBlock:^(HSBannerModel *havemodel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([[NSString stringWithFormat:@"%@",havemodel.id] isEqualToString:[NSString stringWithFormat:@"%@",model.id]]) {
                        
                        if ([havemodel.statu isEqualToString:@"PENDING"]) {
//
                        }
                        if ([havemodel.statu isEqualToString:@"ACTIVE"]) {
                            model.statu = @"ACTIVE";
//                            [samearr addObject:havemodel];
                        }
                        if ([havemodel.statu isEqualToString:@"DONE"]) {
                            [samearr addObject:havemodel];
                            //                            [samearr addObject:havemodel];
                        }

                    }
                }];
            }];
            
            MHLog(@"%@",NSHomeDirectory());
            NSMutableArray *newalert = [NSMutableArray arrayWithArray:alertArr];
            for (int i = 0; i < alertArr.count; i++) {
                HSBannerModel *model = [alertArr objectAtIndex:i];
                for (int j = 0; j < samearr.count ; j++) {
                     HSBannerModel *havmodel = [samearr objectAtIndex:j];
                    if ([[NSString stringWithFormat:@"%@",havmodel.id ] isEqualToString:[NSString stringWithFormat:@"%@",model.id]]) {
                        [newalert removeObject:model];
                    }
                }
            }
            
             [NSKeyedArchiver archiveRootObject:newalert toFile:[self filePath]];
            
            if (newalert.count > 0) {
                HSBannerModel *model = [newalert objectAtIndex:0];
                
                if ([model.statu isEqualToString:@"PENDING"]) {
                    [[MHBaseClass sharedInstance] presentActAltertWithtitle:model.title content:model.content backgroudImg:model.bulletBoxFilling contentType:model.bulletBoxType closeImg:model.title action_url:model.action_url type:model.type alertid:model.id];
                    

                }
 
            }
           
        }
    }];
    
}

-(void)getqiandaoInfo
{
  
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[MHUserService sharedInstance]initwithHSQiandaoInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                NSMutableDictionary *dic= [response valueForKey:@"data"][@"userIntegral"];
                NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:@"signIn"]];
                if ([str isEqualToString:@"0"]) {
                    
                   
                    [self.qiandaoimg setImage:kGetImage(@"sign_nomal") forState:UIControlStateNormal];
                    
                }else{
                    [self.qiandaoimg setImage:kGetImage(@"renwua_icon") forState:UIControlStateNormal];
                    
                }
            }
        }];
    }
    
}


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
                        if ( [GVUserDefaults standardUserDefaults].isPrivacy != nil) {
                            if (![GVUserDefaults standardUserDefaults].accessToken) {
                                if ([[GVUserDefaults standardUserDefaults].ShowRedMoney isEqualToString:@"Yes"] ||[GVUserDefaults standardUserDefaults].ShowRedMoney ==nil ) {
                                    [self showToast];
                                }
                            }
                        }
                        if ([GVUserDefaults standardUserDefaults].isPrivacy == nil) {
                            [self showPrivetToast];
                        }
                        
                    } forControlEvents:UIControlEventTouchUpInside];
                    [contentViews addSubview:closeBtn];
                    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
                        make.right.mas_equalTo(forceUpdateImg.mas_right);
                        make.size.mas_equalTo(CGSizeMake(25, 25));
                    }];
                }else{
                    if ( [GVUserDefaults standardUserDefaults].isPrivacy != nil) {
                        if (![GVUserDefaults standardUserDefaults].accessToken) {
                            if ([[GVUserDefaults standardUserDefaults].ShowRedMoney isEqualToString:@"Yes"] ||[GVUserDefaults standardUserDefaults].ShowRedMoney ==nil ) {
                                [self showToast];
                            }
                        }
                    }
                    if ([GVUserDefaults standardUserDefaults].isPrivacy == nil) {
                        [self showPrivetToast];
                    }
                }
                
            }
            
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.index= 0;
    self.fd_prefersNavigationBarHidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reshpage) name:KNotificationRereshPAGEONE1 object:nil];
     [self getNetwork];
//注册通知
//    [self getAllApp];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewReward) name:@"pushNewReward" object:nil];
 
}


//新手奖励
-(void)showNewReward{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(375), kRealValue(450))];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(4), kRealValue(10), kRealValue(361), kRealValue(430))];
    headView.userInteractionEnabled = YES;
    headView.image = kGetImage(@"icon_redpackage_open");
    [bgView addSubview:headView];
    
    
    UIImageView *headView1 = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(4), kRealValue(10), kRealValue(361), kRealValue(430))];
    headView1.userInteractionEnabled = YES;
    headView1.image = kGetImage(@"icon_redpackage_close");


    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    popView.popAnimationDuration = 0.3f;
    // 3.5 移除时动画时长
    popView.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [popView pop];
    
    
    UITapGestureRecognizer *cleosetap = [[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithHSWithRedPackageCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                [headView removeAllSubviews];
                [bgView addSubview:headView1];
                UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(50), kRealValue(361), kRealValue(20))];
                textLabel.textAlignment = NSTextAlignmentCenter;
                textLabel.textColor = [UIColor colorWithHexString:@"#E42936"];
                textLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(18)];
                textLabel.text = @"  恭喜您获得红包";
                [headView1 addSubview:textLabel];
                
                RichStyleLabel *priceLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(0, kRealValue(70), kRealValue(361), kRealValue(80))];
                priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
                priceLabel.textColor =[UIColor colorWithHexString:@"#DA2529"];
                priceLabel.textAlignment = NSTextAlignmentCenter;
                [headView1 addSubview:priceLabel];
                
                [priceLabel setAttributedText:[NSString stringWithFormat:@"  %@火币",response[@"data"]] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#DA2529"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(60)]}];
                
                UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(150), kRealValue(361), kRealValue(20))];
                textLabel1.textAlignment = NSTextAlignmentCenter;
                textLabel1.textColor = [UIColor colorWithHexString:@"#999999"];
                textLabel1.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(12)];
                textLabel1.text = @"  红包已到账";
                [headView1 addSubview:textLabel1];
                
                //
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(180), kRealValue(410),kRealValue(24), kRealValue(24))];
                [btn setBackgroundImage:kGetImage(@"x") forState:0];
                [bgView addSubview:btn];
                [btn bk_addEventHandler:^(id sender) {
                    [popView dismiss];
                } forControlEvents:UIControlEventTouchUpInside];
                
            }
        }];
    }];
    
    [headView addGestureRecognizer:cleosetap];

    
    
    
    UITapGestureRecognizer *closetap = [[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [popView dismiss];
//        self.tabBarController.selectedIndex = 2;
        HSMyWalletController *vc = [[HSMyWalletController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headView1 addGestureRecognizer:closetap];

    
}
//-(void)getAllApp
//{
//    Class LSApplicationWorkspace_class =objc_getClass("LSApplicationWorkspace");
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//   NSArray *allApplications = [workspace performSelector:@selector(allInstalledApplications)];//这样就能获取到手机中安装的所有App
//     NSLog(@"设备上安装的所有app:%@",allApplications);
//    for (id item in allApplications) {
//        MHLog(@"%@",[item performSelector:NSSelectorFromString(@"applicationIdentifier")]);
////          MHLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleVersion")]);
////          MHLog(@"%@",[item performSelector:NSSelectorFromString(@"shortVersionString")]);
//
//    }
//
//
//}

-(void)reshpage{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshPAGEONE object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%ld",self.index]}];
    
    
}


-(void)ChaiMoney
{
    
    
 
    
    [UIView transitionWithView:self.imge2 duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{

    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.imge2 duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
        } completion:^(BOOL finished) {
            
            
            [UIView transitionWithView:self.imge2 duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            } completion:^(BOOL finished) {
                [UIView transitionWithView:self.imge2 duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                    
                } completion:^(BOOL finished) {
                    [UIView transitionWithView:self.imge2 duration:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                        
                    } completion:^(BOOL finished) {
                        self.imge1.hidden = YES;
                        self.imge2.hidden = YES;
                        self.imge3.hidden = NO;
                        self.close.hidden = NO;
                       
                    }];
                    
                }];
                
               
            }];
            
        }];
    }];
   
    
    
    
}
-(void)Imgtap
{
   
    [GVUserDefaults standardUserDefaults].ShowRedMoney = @"success";
     [self.popView dismiss];
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
        return;
    
    
}
-(void)closeAct
{
     [GVUserDefaults standardUserDefaults].ShowRedMoney = @"success";
     [self.popView dismiss];
}
-(void)showToast
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgview.backgroundColor = KClearColor;
    
    self.imge3 = [[UIImageView alloc]init];
    self.imge3.userInteractionEnabled = YES;
    self.imge3.image = kGetImage(@"red2");
    self.imge3.hidden =YES;
    [bgview addSubview:self.imge3];
    [self.imge3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview.mas_centerX).offset(0);
        make.centerY.equalTo(bgview.mas_centerY).offset(0);
                        make.width.mas_equalTo(kRealValue(342));
                        make.height.mas_equalTo(kRealValue(403));
    }];
    
   
    
//    self.close = [[UIImageView alloc]init];
//    self.close.userInteractionEnabled = YES;
//    self.close.image = kGetImage(@"x");
//    self.close.hidden = YES;
//    [bgview addSubview:self.close];
//    [self.close mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.imge3.mas_right).offset(-kRealValue(50));
//        make.top.equalTo(self.imge3.mas_top).offset(kRealValue(-50));
//        make.width.mas_equalTo(kRealValue(35));
//        make.height.mas_equalTo(kRealValue(35));
//    }];
//    UITapGestureRecognizer *cleosetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAct)];
//    [self.close addGestureRecognizer:cleosetap];
    
    
    
    
    self.imge1 = [[UIImageView alloc]init];
    self.imge1.userInteractionEnabled = YES;
    self.imge1.image = kGetImage(@"red");
//    self.imge1.frame= CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    [bgview addSubview:self.imge1];
    [self.imge1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview.mas_centerX).offset(0);
        make.centerY.equalTo(bgview.mas_centerY).offset(0);
        make.width.mas_equalTo(kRealValue(342));
        make.height.mas_equalTo(kRealValue(403));
    }];
    UITapGestureRecognizer *Img3tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Imgtap)];
    [self.imge1 addGestureRecognizer:Img3tap];
    
  
    
  
    
    
    // 拆红包
//    self.imge2 = [[UIImageView alloc]init];
//    self.imge2.image = kGetImage(@"red_but");
//    self.imge2.userInteractionEnabled = YES;
//    [self.imge1 addSubview:self.imge2];
//    [self.imge2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.imge1.mas_centerX).offset(kRealValue(0));
//        make.bottom.equalTo(self.imge1.mas_bottom).offset(-30);
//        make.width.height.mas_equalTo(90);
//    }];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChaiMoney)];
//    [self.imge2 addGestureRecognizer:tap];
   
    self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    self.popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    self.popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.popView.popAnimationDuration = 0.5f;
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
    
    
    
    
    
}
-(void)showPrivetToast
{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(320), kRealValue(450))];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(40), kRealValue(320), kRealValue(410))];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = kRealValue(5);
    [bgView addSubview:contentView];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(10), kRealValue(80), kRealValue(80))];
    headView.image = kGetImage(@"alert_logo");
    [bgView addSubview:headView];
    headView.centerX = kRealValue(160);
    
    UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(60), kRealValue(320), kRealValue(30))];
    titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(18)];
    titleLabel.text = @"未来商市隐私协议";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"282828"];
    [contentView addSubview:titleLabel];
    
    
    
    NSString *desc = @"欢迎使用“未来商市”！我们非常重视您的个人信息和隐私保护。在您使用“未来商市”服务之前，请仔细阅读《未来商市隐私政策》，我们将严格按照经您同意的各项条款使用您的个人信息，以便为您提供更好的服务。\r\r如您同意此政策，请点击“同意”并开始使用我们的产品和服务，我们尽全力保护您的个人信息安全。";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    textdesc.color = [UIColor colorWithHexString:@"858384"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《火勺看点隐私政策》"]
                              color:[UIColor colorWithHexString:@"FF8F00"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              
                              [self.popView2 dismiss];
                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/yinsi.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
                              [self.navigationController pushViewController:vc animated:YES];
                          }];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(280), CGFLOAT_MAX) text:textdesc];
    YYLabel *textLabel = [YYLabel new];
    textLabel.numberOfLines = 0;
    [contentView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(280));
        make.height.mas_equalTo(layout.textBoundingSize.height);
        make.top.equalTo(contentView.mas_top).offset(kRealValue(100));
    }];
    
    textLabel.attributedText = textdesc;
    
    
    
    
    self.popView2 = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    self.popView2.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    self.popView2.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.popView2.popAnimationDuration = 0.3f;
    // 3.5 移除时动画时长
    self.popView2.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    self.popView2.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    self.popView2.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [self.popView2 pop];
    
    
    
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(340), kRealValue(130), kRealValue(40))];
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.cornerRadius = kRealValue(15);
    [leftBtn bk_addEventHandler:^(id sender) {
        [self.popView2 dismiss];
        MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"请放心，未来商市坚决保障您的隐私信息安全，您的信息仅用于为您提供服务或改善用户体验。如果您确实无法认同此政策，可点击“不同意”并退出应用。" ];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"不同意并退出" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            exit(0);
        }];
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"同意" handler:^(CKAlertAction *action) {
             [self.popView2 dismiss];;
            [alertVC showDisappearAnimation];
            [GVUserDefaults standardUserDefaults].isPrivacy = @"success";
           
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:sure];
        [self presentViewController:alertVC animated:NO completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"282828"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"不同意" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    ViewBorderRadius(leftBtn, 3, 1/kScreenScale, [UIColor colorWithHexString:@"f0f0f0"]);
    [contentView addSubview:leftBtn];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(170), kRealValue(340), kRealValue(130), kRealValue(40))];
    rightBtn.backgroundColor = [UIColor colorWithHexString:@"#FF8F00"];
    rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"同意" forState:UIControlStateNormal];
    rightBtn.layer.masksToBounds = YES;
    ViewBorderRadius(rightBtn, 3, 1/kScreenScale, [UIColor colorWithHexString:@"FF8F00"]);
    [rightBtn bk_addEventHandler:^(id sender) {
        [self.popView2 dismiss];
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            if ([[GVUserDefaults standardUserDefaults].ShowRedMoney isEqualToString:@"Yes"] ||[GVUserDefaults standardUserDefaults].ShowRedMoney ==nil ) {
              
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self showToast];
                });

            }
        }
        [GVUserDefaults standardUserDefaults].isPrivacy = @"success";
        
    } forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightBtn];
    
    
    
    
}
-(void)getNetwork
{
     self.cateArr = [[NSMutableArray alloc]init];
   
    [[MHUserService sharedInstance]initwithHSAriticeCategoryCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.cateArr = [HSCategoryModel baseModelWithArr:[response objectForKey:@"data"]];
            [self createview];
        }else{
            KLToast(response[@"message"]);
        }
        if (error) {
            [self creatError];
        }
        
    }];
    
}
- (void)creatError{
    if (!self.emptyView) {
        self.emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:self.emptyView];
        
        self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 130)];
        self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 - 100);
        self.emptyOverlayImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
        [self.emptyView addSubview:self.emptyOverlayImageView];
        
        CGRect emptyOverlayViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.emptyView.frame), 20);
        UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel.numberOfLines = 0;
        emptyOverlayLabel.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel.text = @"网络异常";
        emptyOverlayLabel.font = [UIFont boldSystemFontOfSize:14];
        emptyOverlayLabel.frame = ({
            CGRect frame = emptyOverlayLabel.frame;
            frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 30;
            frame;
        });
        emptyOverlayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        emptyOverlayLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.emptyView addSubview:emptyOverlayLabel];
        
        
        UILabel *emptyOverlayLabel1 = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel1.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel1.numberOfLines = 0;
        emptyOverlayLabel1.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel1.text = @"点击屏幕，重新加载";
        emptyOverlayLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        emptyOverlayLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        emptyOverlayLabel1.font = [UIFont boldSystemFontOfSize:12];
        emptyOverlayLabel1.frame = ({
            CGRect frame = emptyOverlayLabel1.frame;
            frame.origin.y = CGRectGetMaxY(emptyOverlayLabel.frame) + 20;
            frame;
        });
        [self.view addSubview:emptyOverlayLabel1];
        
        //        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
        [longPressUIemptyOverlay setMinimumPressDuration:0.001];
        [self.emptyView addGestureRecognizer:longPressUIemptyOverlay];
        self.emptyView.userInteractionEnabled = YES;
    }
    
}

- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        [self getNetwork];
    }
}
-(void)createview
{
    self.titleArr = [NSMutableArray arrayWithObjects:@"精选",@"会员", nil];
    NSMutableArray *childArr =[NSMutableArray array];
    for (int i = 0; i < self.cateArr.count; i++) {
        HSCategoryModel *model = [self.cateArr objectAtIndex:i];
        [self.titleArr addObject:model.name];
    }
    for (int i = 0; i < self.titleArr.count; i++) {
        if (i ==0 ) {
            
            HSNewsRecommendViewController *vc = [[HSNewsRecommendViewController alloc]init];
            vc.locx = 0;
              [childArr addObject:vc];
            
        }else if (i ==1 ){
            HSMemberViewController *vc1 =[[HSMemberViewController alloc]init];
            
              [childArr addObject:vc1];
        }else{
            HSCategoryModel *model1 = [self.cateArr objectAtIndex:i-2];
            HSNewsAllTypesViewController *vc = [[HSNewsAllTypesViewController alloc]init];
            vc.categoryID = model1.id;
            vc.locx = i+2;
            [childArr addObject:vc];
            
        }
    }
    
    
   
   
  
    
    
    
    
    // 首页标题 和签到
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kRealValue(42))];
    [self.view addSubview:headview];
    
    UIImageView *logoimg = [[UIImageView alloc]init];
    logoimg.image= kGetImage(@"logo_icon_index");
    [headview addSubview:logoimg];
    [logoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headview.mas_centerX).offset(0);
        make.centerY.equalTo(headview.mas_centerY).offset(0);
        make.width.mas_equalTo(kRealValue(88));
        make.height.mas_equalTo(kRealValue(20));
    }];
    self.qiandaoimg = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.qiandaoimg setImage:kGetImage(@"renwua_icon") forState:UIControlStateSelected];
    [self.qiandaoimg setImage:kGetImage(@"sign_nomal") forState:UIControlStateNormal];
    [headview addSubview:self.qiandaoimg];
    [self.qiandaoimg addTarget:self action:@selector(qiandao) forControlEvents:UIControlEventTouchUpInside];
    [self.qiandaoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headview.mas_right).offset(-14);
        make.centerY.equalTo(headview.mas_centerY).offset(0);
        make.width.mas_equalTo(kRealValue(64));
        make.height.mas_equalTo(kRealValue(22));
       
    }];
    
    
  
    
    
    
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = kRealValue(23);
    configure.showBottomSeparator = YES;
    configure.bottomSeparatorColor= KColorFromRGB(0xF2F2F2);
//    configure.indicatorDynamicWidth = kRealValue(21);
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"777777"];
    configure.titleSelectedColor = KColorFromRGB(kThemecolor);
    configure.indicatorColor = KClearColor;
    configure.indicatorHeight = 1.5;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangMedium size:kFontValue(21)];
   
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kStatusBarHeight + kRealValue(42), kScreenWidth, kRealValue(44)) delegate:self  titleNames:self.titleArr configure:configure];
    CGFloat ContentCollectionViewHeight = kScreenHeight-kTabBarHeight-kRealValue(44)-kStatusBarHeight- kRealValue(42);
    self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, kRealValue(44)+kStatusBarHeight+ kRealValue(42), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    [self.view addSubview:self.pageTitleView ];
    [self.view addSubview:self.pageContentCollectionView];
    _pageContentCollectionView.delegatePageContentScrollView = self;
    [_pageContentCollectionView setPageContentScrollViewCurrentIndex:0];
}
#pragma mark 签到
-(void)qiandao
{
    
    if (![GVUserDefaults standardUserDefaults].accessToken) {
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
        return;
    }
    
    [[MHUserService sharedInstance]initwithHSDoQiandaoCompletionBlock:^(NSDictionary *response, NSError *error) {
        
        if (ValidResponseDict(response)) {
            self.qiandaoStr = [NSString stringWithFormat:@"%@",[[[response valueForKey:@"data"] valueForKey:@"userIntegral"] valueForKey:@"integral"]];
             [self.qiandaoimg setImage:kGetImage(@"renwua_icon") forState:UIControlStateNormal];
          [self showQiandaoToast];
        
        }else if([response[@"code"] intValue] == 20010){
            [self.qiandaoimg setImage:kGetImage(@"renwua_icon") forState:UIControlStateNormal];
            KLToast([response valueForKey:@"message"]);
        }
        else{
            KLToast([response valueForKey:@"message"]);
        }
        if (error) {
            KLToast([response valueForKey:@"message"]);
        }
    }];
}
-(void)showQiandaoToast
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgview.backgroundColor = KClearColor;
    
    
    UIView *layview = [[UIView alloc]init];
    layview.backgroundColor = KColorFromRGBA(0x000000, 0.5);
    layview.layer.cornerRadius = 5;
    [bgview addSubview:layview];
    [layview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview.mas_centerX).offset(0);
        make.centerY.equalTo(bgview.mas_centerY).offset(0);
        make.width.mas_equalTo(kRealValue(130));
        make.height.mas_equalTo(kRealValue(145));
    }];
    
    UIImageView *layimg = [[UIImageView alloc]init];
    [layview addSubview:layimg];
    layimg.image = kGetImage(@"组14");
    [layimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(layview.mas_centerX).offset(0);
        make.top.equalTo(layview.mas_top).offset(kRealValue(5));
    }];
    
    UILabel *laylabel = [[UILabel alloc]init];
    laylabel.text = [NSString stringWithFormat:@"+%@火币",self.qiandaoStr];
    laylabel.textColor = KColorFromRGB(0xFBC00B);
    laylabel.textAlignment = NSTextAlignmentCenter;
    laylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(19)];
    [layview addSubview:laylabel];
    [laylabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(layview.mas_centerX).offset(0);
        make.top.equalTo(layimg.mas_bottom).offset(kRealValue(0));
    }];
    
    
    self.qiandaoPopView3 = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
//    self.qiandaoPopView3.popBGAlpha = 0.3f;
    // 3.3 显示时是否监听屏幕旋转
    self.qiandaoPopView3.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.qiandaoPopView3.popAnimationDuration = 0.2f;
    // 3.5 移除时动画时长
    self.qiandaoPopView3.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    self.qiandaoPopView3.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    self.qiandaoPopView3.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [self.qiandaoPopView3 pop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.qiandaoPopView3 dismiss];
    });

    
    
}

#pragma mark 代理
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
    self.index= selectedIndex;
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    self.index= targetIndex;
}

@end
