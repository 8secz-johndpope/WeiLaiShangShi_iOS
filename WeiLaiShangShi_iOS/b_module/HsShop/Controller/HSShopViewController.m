//
//  HSShopViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/20.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopViewController.h"
#import "HSShopNewCell.h"
#import "SGPagingView.h"
#import "HSShopChildVC.h"
#import "HSShopTableViewCell.h"
#import "HSShopItemModel.h"
#import "MHBaseTableView.h"
#import "SDCycleScrollView.h"
#import "MHWebviewViewController.h"
#import "HSShopDetailVC.h"
#import "UIControl+BlocksKit.h"

@interface HSShopViewController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) MHBaseTableView *contentTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray *recommendArr;
@property (nonatomic, strong) NSMutableArray *categroyIdArr;
@property (nonatomic, strong) NSMutableArray *categroyNameArr;

@property (nonatomic, strong) NSArray *bannerArr;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation HSShopViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"积分商城";
    self.view.backgroundColor  = [UIColor colorWithHexString:@"#F2F2F2"];
    self.categroyIdArr = [NSMutableArray array];
    self.categroyNameArr = [NSMutableArray array];
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptTimeLimtMsg) name:KNotificationFatherSrcoll object:nil];

    [self requireData];
    
}



-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView  didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dict = self.bannerArr[index];
    NSInteger actionType  = [dict[@"actionUrlType"] integerValue];
    if (actionType == 0) {
        //web
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:dict[@"actionUrl"] comefrom:@"LauchImage"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        NSDictionary *dicts = [NSJSONSerialization JSONObjectWithData:[dict[@"actionUrl"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        if ([dicts[@"code"] integerValue] == 5) {
            //产品详情
            HSShopDetailVC *VC = [[HSShopDetailVC alloc] initWithProdId:[NSString stringWithFormat:@"%@",dicts[@"param"]]];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }

}

//


- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[MHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSShopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HSShopTableViewCell class])];
        [_contentTableView registerClass:[HSShopNewCell class] forCellReuseIdentifier:NSStringFromClass([HSShopNewCell class])];
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        //轮播图
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(181))];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(kRealValue(12), kRealValue(16), kRealValue(350), kRealValue(141)) delegate:nil placeholderImage:kGetImage(@"emty_movie")];
        self.cycleScrollView.delegate = self;
        [headerView addSubview:self.cycleScrollView];
        self.cycleScrollView.autoScrollTimeInterval = 5;
        ViewRadius(self.cycleScrollView, kRealValue(8));
        //self.cycleScrollView.imageURLStringsGroup = self.picItemArr;
        [self.contentTableView setTableHeaderView:headerView];
        //下拉刷新
        _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requireData];
        }];

    }
    
    
}


-(void)requireData{
    
    
    [[MHUserService sharedInstance] initwithHSShopCategorycompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            [self createTableView];
            [[MHUserService sharedInstance]initWithFirstPageComponent:@"1" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *bannerArr = response[@"data"];
                    [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj[@"type"] isEqualToString:@"BANNER"]) {
                            NSArray *picArr = obj[@"result"];
                            self.bannerArr = picArr;
                            NSMutableArray *crlArr = [NSMutableArray array];
                            [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                [crlArr addObject:obj[@"sourceUrl"]];
                            }];
                            self.cycleScrollView.imageURLStringsGroup = crlArr;
                        }
                    }];
                }
            }];
            
            [self.categroyIdArr removeAllObjects];
            [self.categroyNameArr removeAllObjects];
            NSArray *categoryArr = response[@"data"];
            [categoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.categroyIdArr addObject:obj[@"id"]];
                [self.categroyNameArr addObject:obj[@"categoryName"]];
            }];
            
            
            SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
            configure.indicatorStyle = SGIndicatorStyleFixed;
            configure.titleAdditionalWidth = 25;
            configure.showVerticalSeparator= YES;
            configure.verticalSeparatorColor = [UIColor colorWithHexString:@"#DCDCDC"];
            configure.verticalSeparatorReduceHeight = kRealValue(30);
            configure.showBottomSeparator = NO;
            configure.showIndicator = NO;
            configure.indicatorCornerRadius = 3;
            configure.titleColor = [UIColor colorWithHexString:@"#222222"];
            configure.titleFont = [UIFont fontWithName:kPingFangRegular size:16];
            configure.titleSelectedColor = [UIColor colorWithHexString:@"#FF273F"];
            
            if (!self.pageTitleView) {
                self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50)) delegate:self titleNames:self.categroyNameArr configure:configure];
                self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
            }
            
            [self.contentTableView.mj_header endRefreshing];
            
            [[MHUserService sharedInstance]initwithHSRecommendcompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.recommendArr = [HSShopItemModel baseModelWithArr:response[@"data"]];
                    [self.contentTableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
            
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HSShopNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSShopNewCell class])];
        [cell creatItemArr:self.recommendArr];
        cell.shopNav = self.navigationController;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        
        HSShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSShopTableViewCell class])];
        
        if (!self.pageContentCollectionView) {
            
            NSMutableArray *childArr =[NSMutableArray array];
            for (int i = 0; i < [self.categroyIdArr count]; i++) {
                HSShopChildVC *vc = [[HSShopChildVC alloc]initWithCategoryId:[NSString stringWithFormat:@"%@",self.categroyIdArr[i]]];
                [childArr addObject:vc];
            }
            CGFloat ContentCollectionViewHeight = kScreenHeight - kTopHeight ;
            self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
            _pageContentCollectionView.delegatePageContentCollectionView = self;
            [cell addSubview:self.pageContentCollectionView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //当前偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    
    CGFloat bottomCellOffset =  [self.contentTableView rectForSection:1].origin.y ;
    if (yOffset >= bottomCellOffset ) {
        
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            [self changeChildCanScroll:YES];
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
}


-(void)changeChildCanScroll:(BOOL)canScroll{
    for (HSShopChildVC *VC in _pageContentCollectionView.childViewControllers) {
        VC.vcCanScroll = canScroll;
        if (!canScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.collectionView.contentOffset = CGPointZero;
        }
    }
}

- (void)acceptTimeLimtMsg{
    self.canScroll = YES;
    [self changeChildCanScroll:NO];
}




- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1 ) {

        return self.pageTitleView;
    }
    
    return nil;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return kRealValue(50);
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kRealValue(210);
    }
    return kScreenHeight - kTopHeight;
}

@end
