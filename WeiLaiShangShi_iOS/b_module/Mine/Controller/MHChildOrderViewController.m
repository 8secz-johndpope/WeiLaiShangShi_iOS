//
//  MHChildOrderViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHChildOrderViewController.h"
#import "MHChildOrderTableViewCell.h"
#import "MHOrderDetailViewController.h"
#import "MHMyOrderModel.h"
#import "MHMyOrderListModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface MHChildOrderViewController ()<UITableViewDataSource, UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, copy) NSString  *indexId;
@property (nonatomic, assign) NSInteger  index;

@end

@implementation MHChildOrderViewController

static NSString * const MHChildOrderViewCellId = @"MHChildOrderViewCellId";



- (instancetype)initWithId:(NSString *)indexId {
    if (self = [super init]) {
        _indexId  = indexId;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
    _index = 1;
    _listArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    
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
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    return networkErrorPlaceHolder;
}








- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.index = 1;
    [self getData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight- 44);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight= 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MHChildOrderTableViewCell class] forCellReuseIdentifier:MHChildOrderViewCellId];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        

    }
    return _tableView;
}



- (void)getData{
    
//    [[MHUserService sharedInstance]initwithMyorder:_indexId pageIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
//
//        if (ValidResponseDict(response)) {
//            if (self.index == 1) {
//                [self.listArr removeAllObjects];
//            }
//            [self.listArr  addObjectsFromArray:[MHMyOrderListModel baseModelWithArr:response[@"data"]]];
//            [self.tableView cyl_reloadData];
//            if ([ response[@"data"] count] > 0) {
//                [self endRefresh];
//            }else{
//                [self endRefreshNoMoreData];
//            }
//        }
//        if (error) {
//            [self.tableView cyl_reloadData];
//        }
//    }];
}


-(void)endRefresh{
   [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(181);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHChildOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHChildOrderViewCellId];
    MHMyOrderListModel *model = _listArr[indexPath.section];
    cell.superVC = self;
    cell.cancleClick = ^{
        self.index = 1;
        [self getData];
    };
    [cell createModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHMyOrderListModel *model = _listArr[indexPath.section];
    MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
    vc.orderId  = model.orderId;
    [self.navigationController pushViewController:vc animated:YES];

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}




@end
