//
//  MHHomeViewController.m
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeViewController.h"
#import "SGPagingView.h"
#import "MHMineViewController.h"
//#import "MHHomeCategory.h"
#import "MHHomeCustomViewController.h"
//#import "MHProdCateroyViewController.h"
#import "MHLoginViewController.h"
#import "MHCategoryModel.h"
//#import "MHMessageViewController.h"
//#import "MHSearchViewController.h"
//#import "MHSearchResultViewController.h"
#import "MHUpdateModel.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "CTUUID.h"
#import "MHWebviewViewController.h"
#import "JPUSHService.h"
#import "MHProdCateroyViewController.h"


@interface MHHomeViewController ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray *cateArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;
@property (nonatomic, strong) ZJAnimationPopView *popView;
@end
@implementation MHHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"未来商市";
    [self getNetwork];

   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptTimeLimtMsg) name:KNotificationFatherSrcoll object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(huadong) name:KNotificationChildSrcoll object:nil];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_righticon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(messagePush)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_lefticon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(searchPush)];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    ;
    
    
    
}



-(void)getNetwork{
    self.cateArr = [[NSMutableArray alloc]init];
    [[MHUserService sharedInstance] initWithProductTypes:@"" scene:@"0"  completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.cateArr = [MHCategoryModel baseModelWithArr:[response objectForKey:@"data"]];
             [self setupPageView];
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
        
        self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
        self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 - 150);
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
            frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
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


-(void)messagePush{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        //消息
//        MHMessageViewController *vc= [[MHMessageViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
}

- (void)acceptTimeLimtMsg{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.pageTitleView.frame = CGRectMake(0, 0, kScreenWidth, 30);
        self.pageContentCollectionView.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight-44);
    }];
    
}

-(void)huadong{
    [UIView animateWithDuration:0.1 animations:^{
        self.pageTitleView.frame = CGRectMake(0, -30, kScreenWidth, 30);
        self.pageContentCollectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight);
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([GVUserDefaults standardUserDefaults].isPrivacy == nil) {
        [self showToast];
    }
    [[MHUserService sharedInstance]initWithOS:@"IOS" channel:@"Appstore" version:[CTUUID getAppVersion] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            MHUpdateModel *model = [MHUpdateModel baseModelWithDic:response[@"data"]];
            if (model.forceUpgrade == 1) {
                MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:model.upgradeLog ];
                CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                }];
                [alertVC addAction:cancel];
                [self presentViewController:alertVC animated:NO completion:nil];
                
            }else{
                
                if (model.upgrade == 1) {
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:model.upgradeLog ];
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"暂不更新" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                        [alertVC showDisappearAnimation];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
                }
                
            }
            
        }
        
    }];
    
}
- (void)setupPageView {
    
    self.titleArr = [NSMutableArray array];
    NSMutableArray *childArr =[NSMutableArray array];
    for (int i = 0; i < self.cateArr.count; i++) {
        MHCategoryModel *model = [self.cateArr objectAtIndex:i];
         [self.titleArr addObject:model.categoryName];
        if (i != 0) {
            MHHomeCustomViewController *vc = [[MHHomeCustomViewController alloc]init];
            vc.parentId = model.id;
            [childArr addObject:vc];
        }else{
            MHHomeCustomViewController *vc = [[MHHomeCustomViewController alloc]init];
            vc.parentId = model.id;
            [childArr addObject:vc];
        }
    }
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 25;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 3;
    configure.titleColor = [UIColor colorWithHexString:@"000000"];
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:14];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"e91111"];
    configure.indicatorColor = [UIColor colorWithHexString:@"e91111"];
    configure.indicatorHeight = 2;

    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 30) delegate:self titleNames:self.titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
    [self.view addSubview:_pageTitleView];
    

    
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = kScreenHeight- CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)searchPush{
    
    MHProdCateroyViewController *vc= [[MHProdCateroyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
//    NSArray *hotSeaches = [GVUserDefaults standardUserDefaults].hotSearchArr;
//    // 2. Create a search view controller
//
//    MHSearchViewController *searchViewController = [MHSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder: [[GVUserDefaults standardUserDefaults].hotSearchArr count] > 0 ? [GVUserDefaults standardUserDefaults].hotSearchArr[0]:@"" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        MHSearchResultViewController *vc = [[MHSearchResultViewController alloc] init];
//        vc.descStr = searchText;
//        [searchViewController.navigationController pushViewController:vc animated:NO];
//    }];
//    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
//    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
//    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModeModal;
////    searchViewController.delegate = self;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self  presentViewController:nav animated:NO completion:nil];
}



- (void)showToast{
    
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
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《未来商市隐私政策》"]
                              color:[UIColor colorWithHexString:@"FF8F00"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              
                              [self.popView dismiss];
                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/privacy_policy.html" comefrom:@"home"];
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

    
    
    
    self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
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
    
    
    
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(340), kRealValue(130), kRealValue(40))];
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.cornerRadius = kRealValue(15);
    [leftBtn bk_addEventHandler:^(id sender) {
         [self.popView dismiss];
        MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"请放心，未来商市坚决保障您的隐私信息安全，您的信息仅用于为您提供服务或改善用户体验。如果您确实无法认同此政策，可点击“不同意”并退出应用。" ];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"不同意并退出" handler:^(CKAlertAction *action) {
             [alertVC showDisappearAnimation];
            exit(0);
        }];
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"同意" handler:^(CKAlertAction *action) {
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
        [self.popView dismiss];
        [GVUserDefaults standardUserDefaults].isPrivacy = @"success";
        
    } forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightBtn];
    
    
    
    
}




//#pragma mark - PYSearchViewControllerDelegate
//- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
//{
//    if (searchText.length) {
//        // Simulate a send request to get a search suggestions
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"小姐姐 吃ji'ba"];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // Refresh and display the search suggustions
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
//    }
//}

@end
