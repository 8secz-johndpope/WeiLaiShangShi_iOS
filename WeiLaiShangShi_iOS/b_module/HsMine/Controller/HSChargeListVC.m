//
//  HSRewardController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSChargeListVC.h"
#import "HSRewardTableViewCell.h"
#import "MHRecordPresentStatuController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "HSRewardModel.h"

@interface HSChargeListVC ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation HSChargeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    _index = 1;
    _listArr = [NSMutableArray array];
    [self createview];
    [self getData];
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    
    
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getData];
    }];
}


-(void)createview{
    [self.view addSubview:self.contentTableView];
}




-(void)getData{

    [[MHUserService sharedInstance]initwithWithChargeListIndex:_index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSRewardModel baseModelWithArr:response[@"data"]]];
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
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSRewardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HSRewardTableViewCell class])];
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
    
    HSRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSRewardTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    HSRewardModel *model =_listArr[indexPath.row];
    cell.textsLabel.text = model.detail;
    if ([model.recordType isEqualToString:@"INCOME"]) {
        cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#FBBB56"];
        cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"+%@友利值",model.power];
        cell.RecordPresentcardnum.textColor = [UIColor colorWithHexString:@"#F32B2B"];
    }else{
        
        cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"-%@友利值",model.power];
        cell.RecordPresentcardnum.textColor = [UIColor colorWithHexString:@"#222222"];
        if ([model.flowType isEqualToString:@"RREEZE_INTEGRAL_INVALID"]) {
            cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#D1D1D1"];
        }else{
            cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#3BBEF4"];
        }
    }
    
    if (model.deductPower == 0) {
        cell.RecordPresentstate.text = @"";
    }else{
        cell.RecordPresentstate.text = [NSString stringWithFormat:@"消耗%.2f友利值",model.deductPower];
    }
    
    
    cell.RecordPresentname.text = [NSString stringWithFormat:@"%@",model.content];
    
    cell.RecordPresenttime.text = model.createTime;
    
    
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


@end
