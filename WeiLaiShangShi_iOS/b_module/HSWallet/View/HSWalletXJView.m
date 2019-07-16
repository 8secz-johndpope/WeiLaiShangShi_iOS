//
//  HSWalletXJView.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletXJView.h"
#import "HSWalletXJCell.h"
#import "MHWithDrawRecordModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface HSWalletXJView ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) NSInteger  index;
@end


@implementation HSWalletXJView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentTableView];
        _index = 1;
        _listArr = [NSMutableArray array];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(200), kRealValue(30))];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *shouruLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(200), kRealValue(30))];
        shouruLabel.text = @"现金流水";
        shouruLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        shouruLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [headerView addSubview:shouruLabel];
        [self addSubview:headerView];
        [self getData];

    }
    return self;
}



-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, kRealValue(30),kRealValue(345), kScreenHeight - kRealValue(210) - kTopHeight - kTabBarHeight - kRealValue(30));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSWalletXJCell class] forCellReuseIdentifier:NSStringFromClass([HSWalletXJCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self getData];
            if ([self.delegate respondsToSelector:@selector(reloadHome)]) {
                [self.delegate reloadHome];
            }
        }];
        
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getData];
        }];
        
    }
    return _contentTableView;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(82);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSWalletXJCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWalletXJCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    MHWithDrawRecordModel *model =_listArr[indexPath.row];
    if ([model.bankType isEqualToString:@"BANK"]) {
        
        NSString *textStr = [NSString stringWithFormat:@"提现到银行卡(%@)",model.cardCode];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSRange range = [textStr rangeOfString:[NSString stringWithFormat:@"(%@)",model.cardCode]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:range];
        cell.todayLabel.attributedText = attrStr;
        
        
    }else if ([model.bankType isEqualToString:@"ALIPAY"]) {
        NSString *textStr = [NSString stringWithFormat:@"提现到支付宝(%@)",model.cardCode];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSRange range = [textStr rangeOfString:[NSString stringWithFormat:@"(%@)",model.cardCode]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:range];
        cell.todayLabel.attributedText = attrStr;
    }
    
    cell.jfLabel.text = [NSString stringWithFormat:@"-%@",model.money];
    if ([model.withdrawType isEqualToString:@"INCOME"]) {
        cell.jfLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    }
    cell.todayDescLabel.text = model.withdrawDate;
    
    
    if (model.withdrawState == 0) {
        cell.stateLabel.text = @"审核中";
    }else if (model.withdrawState == 1){
        cell.stateLabel.text = [NSString stringWithFormat:@"手续费%@元",model.fee];
    }else if (model.withdrawState == 2){
        cell.stateLabel.text = @"提现失败";
    }else if (model.withdrawState == 3){
        cell.stateLabel.text = @"汇款中";
    }
    
    if ([model.withdrawType isEqualToString:@"INCOME"]) {
        cell.stateLabel.text = @"活动奖励";
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


- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}

-(void)reloadViewData{
    self.index = 1;
    [self getData];
}

@end

