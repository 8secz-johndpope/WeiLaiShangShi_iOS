//
//  HSDTVC.m
//  HSKD
//
//  Created by AllenQin on 2019/5/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSDTVC.h"
#import "SDCycleScrollView.h"
#import "MHWebviewViewController.h"
#import "HSDTCell.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "HSDTModel.h"

@interface HSDTVC ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) NSArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation HSDTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    self.index = 1;
    _listArr = [NSMutableArray array];
    [self createTableView];
    [[MHUserService sharedInstance]initwithHSDTBannerCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *bannerArr = response[@"data"];
            self.bannerArr = bannerArr;
            NSMutableArray *crlArr = [NSMutableArray array];
            for (int i = 0; i< [bannerArr count]; i++) {
                [crlArr addObject:bannerArr[i][@"bigCover"]];
            }
            self.cycleScrollView.imageURLStringsGroup = crlArr;
        }
    }];
    [self requireData];
}

//
-(void)requireData{
    [[MHUserService sharedInstance]initwithWithDTListIndex:self.index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSDTModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView cyl_reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
    }];
}


-(void)endRefresh{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self requireData];
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView  didSelectItemAtIndex:(NSInteger)index{

    if (self.bannerArr.count > 0) {
        MHWebviewViewController *vc= [[MHWebviewViewController alloc]initWithurl:self.bannerArr[index][@"url"] comefrom:@"home"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//


- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight  - kTabBarHeight - kRealValue(60));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSDTCell class] forCellReuseIdentifier:NSStringFromClass([HSDTCell class])];
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        //轮播图
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211))];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211)) delegate:nil placeholderImage:kGetImage(@"emty_movie")];
        self.cycleScrollView.currentPageDotColor = KColorFromRGB(0xFD7215);
        self.cycleScrollView.pageDotColor = KColorFromRGB(0xffffff);
        self.cycleScrollView.delegate = self;
        [headerView addSubview:self.cycleScrollView];
        self.cycleScrollView.autoScrollTimeInterval = 5;
        [self.contentTableView setTableHeaderView:headerView];
        //下拉刷新
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self requireData];
        }];
        
        
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self requireData];
            
            [[MHUserService sharedInstance]initwithHSDTBannerCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *bannerArr = response[@"data"];
                    self.bannerArr = bannerArr;
                    NSMutableArray *crlArr = [NSMutableArray array];
                    for (int i = 0; i< [bannerArr count]; i++) {
                        [crlArr addObject:bannerArr[i][@"bigCover"]];
                    }
                    self.cycleScrollView.imageURLStringsGroup = crlArr;
                }
            }];
        }];
    }
    
    
}


- (UIView *)makePlaceHolderView {
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
}


- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    return networkErrorPlaceHolder;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_listArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSDTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSDTCell class])];
    HSDTModel *model = _listArr[indexPath.row];
    [cell.bgView sd_setImageWithURL:[NSURL URLWithString:model.cover[0]] placeholderImage:kGetImage(@"emty_movie")];
    cell.title.text = model.title;
    cell.datetitle.text = model.createTime;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return kRealValue(95);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSDTModel *model = _listArr[indexPath.row];
    MHWebviewViewController *vc= [[MHWebviewViewController alloc]initWithurl:model.url comefrom:@"home"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
