//
//  MHMyOrderViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMyOrderViewController.h"
#import "SGPagingView.h"
#import "MHChildOrderViewController.h"


@interface MHMyOrderViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, assign) NSInteger   index;
@end
@implementation MHMyOrderViewController


-(instancetype)initWitIndex:(NSInteger )index
{
    self = [super init];
    if (self) {
        _index  = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";


    [self setupPageView];
}

- (void)setupPageView {
    NSArray *titleArr = @[@"全部", @"待付款", @"已发货", @"退换货",];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
//    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 35;
    configure.showBottomSeparator = NO;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"#FF3344"];
    configure.indicatorColor = [UIColor colorWithHexString:@"#FF3344"];
    configure.indicatorHeight = kRealValue(3);
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
//
    [self.view addSubview:_pageTitleView];
    
    MHChildOrderViewController *oneVC = [[MHChildOrderViewController alloc] initWithId:@""];
    MHChildOrderViewController *twoVC = [[MHChildOrderViewController alloc] initWithId:@"UNPAID"];
    MHChildOrderViewController *threeVC = [[MHChildOrderViewController alloc] initWithId:@"UNRECEIPT"];
    MHChildOrderViewController *fourVC = [[MHChildOrderViewController alloc] initWithId:@"RETURN_GOOD"];
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC];
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentCollectionView];
    
     self.pageTitleView.selectedIndex = _index;
}



- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (index == 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)backBtnClicked{
//    if (ValidStr(self.type)) {
//        MHMyOrderViewController *vc =  [[MHMyOrderViewController alloc] initWitIndex:0];
//        vc.type = self.type;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//
//    }
       [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
