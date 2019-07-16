//
//  HSOrderVC.m
//  HSKD
//
//  Created by AllenQin on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSOrderVC.h"
#import "MHChildOrderTableViewCell.h"
#import "MHOrderDetailViewController.h"
#import "MHMyOrderModel.h"
#import "MHMyOrderListModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "HSUpPopView.h"
#import "MHWebviewViewController.h"
#import "HSPayResultController.h"
#import "HSPayStateWebViewController.h"

@interface HSOrderVC ()<UITableViewDataSource, UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation HSOrderVC

static NSString * const MHChildOrderViewCellId = @"MHChildOrderViewCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    _index = 1;
    _listArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight);
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
    
    [[MHUserService sharedInstance]initwithMyorder:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHMyOrderListModel baseModelWithArr:response[@"data"]]];
            [self.tableView cyl_reloadData];
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.tableView cyl_reloadData];
        }
    }];


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
    return [_listArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(194);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHChildOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHChildOrderViewCellId];
    MHMyOrderListModel *model = _listArr[indexPath.section];
    cell.superVC = self;
    [cell createModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHMyOrderListModel *model = _listArr[indexPath.section];
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
      
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            //支付
            [[MHUserService sharedInstance]initwithHSPayListCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
//                    NSMutableArray *shopArr = [NSMutableArray array];
//                    [shopArr addObject:];
                    //弹窗
                    HSUpPopView *popView = [[HSUpPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) shopList:model.shops[0][@"products"] payList:response[@"data"]];
                    [popView pop];
                    popView.payClick = ^(NSString * _Nonnull payType, NSDictionary * _Nonnull shopDict) {
                        
                        NSMutableArray *listArr = [NSMutableArray array];
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        [dict setObject:@"1" forKey:@"productNum"];
                        
                        [dict setObject:[shopDict valueForKey:@"productId"]  forKey:@"productId"];
                        [listArr addObject:dict];
                        [MBProgressHUD showActivityMessageInWindow:@""];
                        if ([payType isEqualToString:@"YOP"]) {
                            [[MHUserService sharedInstance]initwithContinuePay:model.orderId payType:@"YOP" payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                                [popView dismiss];
                                [MBProgressHUD hideHUD];
                                if (ValidResponseDict(response)) {
                                    NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSString *urlParam =  [datastr stringByURLDecode];
                                    //                                    NSLog(@"%@",urlParam);
                                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:urlParam comefrom:@"payyop"];
                                    vc.payType = payType;
                                    vc.orderCode=response[@"data"][@"orderCode"];
                                    [self.navigationController pushViewController:vc animated:YES];
                                }else{
                                    KLToast(response[@"message"]);
                                }
                            }];
                            
                        }else if ([payType isEqualToString:@"ALIPAY"]){
                            [[MHUserService sharedInstance]initwithContinuePay:model.orderId payType:@"ALIPAY" payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                                [popView dismiss];
                                [MBProgressHUD hideHUD];
                                if (ValidResponseDict(response)) {
                                    
                                    NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSString *urlParam =  [datastr stringByURLDecode];
                                    
                                    [[MHPayClass sharedApi]aliPayWithPayParam:urlParam success:^(payresult code) {
                                        if (alipaysuceess ==  code) {
                                            //回调支付宝
                                            HSPayResultController *vc = [[HSPayResultController alloc] init];
                                            vc.orderCode = response[@"data"][@"orderCode"];
                                            vc.payType = payType;
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }else{
                                            HSPayResultController *vc = [[HSPayResultController alloc] init];
                                            vc.orderCode = response[@"data"][@"orderCode"];
                                            vc.payType = payType;
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }
                                    } failure:^(payresult code) {
                                        HSPayResultController *vc = [[HSPayResultController alloc] init];
                                        vc.orderCode = response[@"data"][@"orderCode"];
                                        vc.payType = payType;
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }];
                                    
                                }else{
                                    KLToast(response[@"message"]);
                                }
                            }];
                            
                            
                            
                        }else if ([payType isEqualToString:@"WECHAT"]){
                            [[MHUserService sharedInstance]initwithContinuePay:model.orderId payType:@"WECHAT" payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                                [popView dismiss];
                                [MBProgressHUD hideHUD];
                                if (ValidResponseDict(response)) {
                                    
                                    NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSString *urlParam =  [datastr stringByURLDecode];
                                    NSData *jsonData = [urlParam dataUsingEncoding:NSUTF8StringEncoding];
                                    NSMutableDictionary *wxDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                    [[MHPayClass sharedApi]wxPayWithPayParam:wxDict success:^(payresult ResultCode) {
                                        if (wxsuceess ==  ResultCode) {
                                            HSPayResultController *vc = [[HSPayResultController alloc] init];
                                            vc.orderCode = response[@"data"][@"orderCode"];
                                            vc.payType = payType;
                                            [self.navigationController pushViewController:vc animated:YES];
                                            
                                        }else{
                                            HSPayResultController *vc = [[HSPayResultController alloc] init];
                                            vc.orderCode = response[@"data"][@"orderCode"];
                                            vc.payType = payType;
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }
                                        
                                    } failure:^(payresult ResultCode) {
                                        
                                        HSPayResultController *vc = [[HSPayResultController alloc] init];
                                        vc.orderCode = response[@"data"][@"orderCode"];
                                        vc.payType = payType;
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }];
                                    
                                }else{
                                    KLToast(response[@"message"]);
                                }
                            }];
                        }else if ([payType isEqualToString:@"ALIPAY_TRANSFER_FIXED_AMOUNT"]){
                            [[MHUserService sharedInstance]initwithContinuePay:model.orderId payType:@"ALIPAY_TRANSFER_FIXED_AMOUNT" payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                                [popView dismiss];
                                [MBProgressHUD hideHUD];
                                if (ValidResponseDict(response)) {
                                    if ([response[@"data"][@"orderPayType"] isEqualToString:@"H5"]) {
                                        NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                        NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSString *urlParam =  [datastr stringByURLDecode];
                                        HSPayStateWebViewController *vc = [[HSPayStateWebViewController alloc]initWithurl:urlParam comefrom:@"ALIPAY_AMOUNT"];
                                        vc.payType = payType;
                                        vc.orderCode=response[@"data"][@"orderCode"];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }
                                
                                }else{
                                    KLToast(response[@"message"]);
                                }
                            }];
                            
                            
                            
                        }
                    };
                }
            }];
        }
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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




- (UIView *)makePlaceHolderView {
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
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


@end
