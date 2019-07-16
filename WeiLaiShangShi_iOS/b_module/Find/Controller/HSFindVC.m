//
//  HSFindVC.m
//  HSKD
//
//  Created by AllenQin on 2019/4/23.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFindVC.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "SGPagingView.h"
#import "HSRankVC.h"
#import "HSHDVC.h"
#import "HSAnnouceViewController.h"
#import "HSDTVC.h"


@interface HSFindVC ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, strong) ZJAnimationPopView *VersionpopView;

@end

@implementation HSFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    //分三类
    [self createPage];
 
    
}


-(void)createPage{
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.titleAdditionalWidth = 0;
    configure.showBottomSeparator = NO;
//    configure.showIndicator = NO;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:15];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangRegular size:18];
    configure.indicatorColor = [UIColor colorWithHexString:@"#FD7215"];
    configure.indicatorHeight = 3;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"#222222"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kScreenWidth/6,kStatusBarHeight, kScreenWidth*2/3, kRealValue(60)) delegate:self titleNames:@[@"活动",@"公告",@"榜单",@"动态"] configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    self.pageTitleView.selectedIndex = 0;
    HSRankVC *one  = [[HSRankVC alloc]init];
    HSHDVC *two  = [[HSHDVC alloc]init];
    HSAnnouceViewController *three  = [[HSAnnouceViewController alloc]init];
    HSDTVC *four  = [[HSDTVC alloc]init];
    NSArray *childArr = @[two,three,one,four];
    
    CGFloat ContentCollectionViewHeight = kScreenHeight- CGRectGetMaxY(_pageTitleView.frame) - kTabBarHeight;
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
    [self.view addSubview:_pageTitleView];
    
}


- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}






































-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[GVUserDefaults standardUserDefaults].ShowAppUpdateAlert isEqualToString:@"Yes"]) {
        [self checkAppUpdate];
    }
}


-(void)checkAppUpdate{
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

@end
