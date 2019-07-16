//
//  MHAssetDetailVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAssetDetailVC.h"
#import "MHAssestCell.h"

#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface MHAssetDetailVC ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;

@property (nonatomic, strong) NSMutableArray   *assetArr;

@property (nonatomic, assign) NSInteger  index;

@property (nonatomic, copy) NSString    *flowType;

@end

@implementation MHAssetDetailVC



- (instancetype)initWithId:(NSString *)flowType{
    self = [super init];
    if (self) {
        _flowType = flowType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
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
    
    [[MHUserService sharedInstance]initwithShopAssets:_flowType pageIndex:_index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.assetArr removeAllObjects];
            }
            [self.assetArr  addObjectsFromArray:[MHShopAssetModel baseModelWithArr:response[@"data"]]];
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
    return networkErrorPlaceHolder;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight - 44) style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
       [_contentTableView registerClass:[MHAssestCell class] forCellReuseIdentifier:NSStringFromClass([MHAssestCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHAssestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAssestCell class])];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [cell createModel:_assetArr[indexPath.row]];
    if (indexPath.row == 0) {
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners: UIRectCornerTopLeft| UIRectCornerTopRight cornerRadii: (CGSize){5.0f, 5.0f}].CGPath;
        cell.bgView.layer.masksToBounds = YES;
        cell.bgView.layer.mask = maskLayer;
    }else{
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners: UIRectCornerTopLeft| UIRectCornerTopRight cornerRadii: (CGSize){0, 0}].CGPath;
        cell.bgView.layer.masksToBounds = YES;
        cell.bgView.layer.mask = maskLayer;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     return kRealValue(58);;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.assetArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(15);
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kRealValue(15);
}
@end
