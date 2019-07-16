//
//  MHSearchResultViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSearchResultViewController.h"
#import "MHSearchViewController.h"
#import "MHHomeCategory.h"
#import "SGPagingView.h"
//#import "MHSearchUserListVC.h"
//#import "MHSearchProdViewController.h"
#import "MHCategorySearchView.h"

@interface MHSearchResultViewController ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property(strong,nonatomic)MHCategorySearchView *navSearchBar;
@end

@implementation MHSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowLiftBack = NO;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 30)];
    [titleView addSubview:self.navSearchBar];
    self.navigationItem.titleView = titleView;
    [_navSearchBar createSeachContent:self.descStr];
    
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kRealValue(35), kRealValue(17))];
    cancleButton.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancelDidClick)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    [self setupPageView];
}

-(void)cancelDidClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(MHCategorySearchView *)navSearchBar{
    if (!_navSearchBar) {
        _navSearchBar = [[MHCategorySearchView alloc] initWithFrame:CGRectMake(0,0, kRealValue(295), 30)];
        kWeakSelf(self);
        _navSearchBar.searchBarBlock=^(){
            kStrongSelf(weakself);
            [strongself.navigationController popToRootViewControllerAnimated:NO];
        };
    }
    return _navSearchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPageView {
    NSArray *titleArr = @[@"相关商品", @"相关店铺"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 35;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorHeight = kRealValue(3);
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    
//    MHSearchProdViewController *oneVC = [[MHSearchProdViewController alloc] initWithName:_descStr];
//    MHSearchUserListVC *twoVC = [[MHSearchUserListVC alloc] initWithName:_descStr];
//    NSArray *childArr = @[oneVC, twoVC];
    /// pageContentCollectionView
//    CGFloat ContentCollectionViewHeight = kScreenHeight- CGRectGetMaxY(_pageTitleView.frame);
//    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
//    _pageContentCollectionView.delegatePageContentCollectionView = self;
//    [self.view addSubview:_pageContentCollectionView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


@end
