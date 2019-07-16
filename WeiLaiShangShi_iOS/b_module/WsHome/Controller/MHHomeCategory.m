//
//  MHHomeCategory.m
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//
#import "MHHomeCategory.h"
#import "HomeproductCell.h"
#import "MHProductModel.h"
#import "MHbannerCell.h"
#import "MHActivityCell.h"
#import "MHNewerActCell.h"
#import "MHtitleCell.h"
#import "MHGuessActivityCell.h"
#import "MHTimeCell.h"
//#import "MHLimitTimer.h"
#import "SGPagingView.h"
#import "MHChildOrderViewController.h"
#import "MHHomeNoticeView.h"
#import "MHHomeDetailViewController.h"
#import "MHPageSectionModel.h"
#import "MHPageItemModel.h"
//#import "MHProductDetailViewController.h"
//#import "MHLimitbuyListModel.h"
//#import "MHgradeshowInfomodel.h"
//#import "MHHuGuessViewController.h"
//#import "MHProDetailViewController.h"
//#import "MHPriceMoreViewController.h"
#import "UIScrollView+MJRefreshEX.h"
#import "MHWebviewViewController.h"
//#import "MHNewbeeVC.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
//#import "MHHomefleaShopViewController.h"
//#import "MHSignViewController.h"
#import "MHLoginViewController.h"

@interface MHHomeCategory ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate, SGPageContentScrollViewDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) MHHomeNoticeView *showVipView;
@property (nonatomic, copy)   NSString *typeId;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *limitBuyListArr;
@property (nonatomic, strong) NSMutableArray *gradeArr;
//升级会员信息
@property (nonatomic, assign) int  gradeIndex;
@property (nonatomic, strong) NSMutableArray *limittitleArr;
//限时抢购(正在抢购下标)
@property (nonatomic, assign) int limittimeindex;
@property (nonatomic, assign) NSInteger  index;

#define PADDING 15.0
@end
@implementation MHHomeCategory

- (instancetype)initWithTypeId:(NSString *)typeId
{
    self = [super init];
    if (self) {
       
        _typeId = typeId;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradeIndex =0;
    self.view.backgroundColor = kBackGroudColor;
   
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
