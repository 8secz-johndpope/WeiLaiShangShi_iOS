


//
//  MHRecordPresentViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHRecordPresentViewController.h"
#import "MHRecordPresentCell.h"
#import "MHRecordPresentStatuController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "HSMyWalletController.h"
#import "MHWithDrawRecordModel.h"

@interface MHRecordPresentViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) NSInteger  index;

@end

@implementation MHRecordPresentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现金流水";
    self.fd_interactivePopDisabled = YES;

    _index = 1;
    _listArr = [NSMutableArray array];
    [self createview];
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


-(void)createview{
    [self.view addSubview:self.contentTableView];
}







-(void)getData{
    
    [[MHUserService sharedInstance]initwithWithDrawDataPageIndex:_index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHWithDrawRecordModel baseModelWithArr:response[@"data"]]];
            [self.contentTableView cyl_reloadData];
            if ([ response[@"data"] count] > 0) {
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
    [self getData];
}




-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = KColorFromRGB(0xEDEFF0);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHRecordPresentCell class] forCellReuseIdentifier:NSStringFromClass([MHRecordPresentCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(69);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHRecordPresentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHRecordPresentCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =KColorFromRGB(0xffffff);
    MHWithDrawRecordModel *model =_listArr[indexPath.row];
    if ([model.bankType isEqualToString:@"BANK"]) {
        cell.RecordPresentname.text = [NSString stringWithFormat:@"提现到银行卡%@",model.cardCode];
        cell.textsLabel.text = @"提现";
        cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#F32B2B"];
    
    }else if ([model.bankType isEqualToString:@"ALIPAY"]) {
        cell.RecordPresentname.text = [NSString stringWithFormat:@"提现到支付宝%@",model.cardCode];
        cell.textsLabel.text = @"提现";
        cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#F32B2B"];
    }
    
    cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"-%@元",model.money];
    if ([model.withdrawType isEqualToString:@"INCOME"]) {
        cell.RecordPresentname.text = model.reason;
        cell.textsLabel.text = @"活动";
        cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#F5AB18"];
        cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"+%@元",model.money];
    }
    cell.RecordPresenttime.text = model.withdrawDate;

    
    if (model.withdrawState == 0) {
         cell.RecordPresentstate.text = @"审核中";
    }else if (model.withdrawState == 1){
        cell.RecordPresentstate.text = [NSString stringWithFormat:@"手续费%@元",model.fee];
    }else if (model.withdrawState == 2){
       cell.RecordPresentstate.text = @"提现失败";
    }else if (model.withdrawState == 3){
        cell.RecordPresentstate.text = @"汇款中";
    }
    
    if ([model.withdrawType isEqualToString:@"INCOME"]) {
        cell.RecordPresentstate.text = @"活动奖励";
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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


-(void)backBtnClicked{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HSMyWalletController class]]) {
            HSMyWalletController *revise =(HSMyWalletController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
        }
    }
}

@end
