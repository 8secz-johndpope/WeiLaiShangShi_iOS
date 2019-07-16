//
//  HSHDVC.m
//  HSKD
//
//  Created by AllenQin on 2019/4/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSHDVC.h"
#import "HSHDCell.h"
#import "HSHDModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "MHWebviewViewController.h"

@interface HSHDVC ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate,MHNoDataPlaceHolderDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;

@property (nonatomic, strong) NSMutableArray   *assetArr;

@property (nonatomic, assign) NSInteger  index;

@end

@implementation HSHDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _index = 1;
    _assetArr = [NSMutableArray array];
    [self.view addSubview:self.contentTableView];
    [self getData];
    
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getData];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
}


- (void)getData{
    
    [[MHUserService sharedInstance]initwithHSHDList:_index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.assetArr removeAllObjects];
            }
            [self.assetArr  addObjectsFromArray:[HSHDModel baseModelWithArr:response[@"data"][@"list"]]];
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
    [self.contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [self.contentTableView.mj_footer endRefreshingWithNoMoreData];
}



- (UIView *)makePlaceHolderView {
    //    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
}


- (void)NodataemptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}



- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight  - kTabBarHeight - kRealValue(60)) style:UITableViewStylePlain];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSHDCell class] forCellReuseIdentifier:NSStringFromClass([HSHDCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSHDCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSHDCell class])];
    
    [cell createModel:_assetArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(120);;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.assetArr.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSHDModel *model =    _assetArr[indexPath.row];
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.url comefrom:@"LauchImage"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
