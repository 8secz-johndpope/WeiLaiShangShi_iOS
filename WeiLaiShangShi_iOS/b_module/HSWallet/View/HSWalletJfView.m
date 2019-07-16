//
//  HSWalletJfView.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletJfView.h"
#import "HSWalletJFCell.h"
#import "HSRewardModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface HSWalletJfView ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) NSMutableArray *listArr;
@end


@implementation HSWalletJfView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.index = 1;
        _listArr = [NSMutableArray array];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(30))];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *shouruLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(200), kRealValue(30))];
        shouruLabel.text = @"积分记录";
        shouruLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        shouruLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [headerView addSubview:shouruLabel];
        [self  addSubview:headerView];
        [self addSubview:self.contentTableView];
        [self getdata];
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
        [_contentTableView registerClass:[HSWalletJFCell class] forCellReuseIdentifier:NSStringFromClass([HSWalletJFCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getdata];
        }];
        
        
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self getdata];
            if ([self.delegate respondsToSelector:@selector(xjreloadHome)]) {
                [self.delegate xjreloadHome];
            }
        }];
    }
    return _contentTableView;
}


-(void)getdata{
    
    [[MHUserService sharedInstance]initwithWithjifenListIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSRewardModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView cyl_reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            if (error) {
                [self.contentTableView cyl_reloadData];
            }
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
    
    HSWalletJFCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWalletJFCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    HSRewardModel *model =_listArr[indexPath.row];
    cell.todayDescLabel.text = model.createTime;
    
    NSString *textStr = [NSString stringWithFormat:@"%@（积分）",model.content];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSRange range = [textStr rangeOfString:@"（积分）"];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)] range:range];
    cell.todayLabel.attributedText = attrStr;
    
    if ([model.flowType isEqualToString:@"UPGRADE_VIP_AWARD"]) {
        cell.oneImageView.image = kGetImage(@"wallet_yingshao");
    }else if ([model.flowType isEqualToString:@"UPGRADE_SVIP_AWARD"]){
        cell.oneImageView.image = kGetImage(@"wallet_jinshao");
    }else if ([model.flowType isEqualToString:@"INVITE_VIP"]){
        cell.oneImageView.image = kGetImage(@"wallet_yaoqing");
    }else if ([model.flowType isEqualToString:@"INVITE_SVIP"]){
        cell.oneImageView.image = kGetImage(@"wallet_yaoqing");
    }else if ([model.flowType isEqualToString:@"FIRE_INTEGRAL_EXPENSE"]){
        cell.oneImageView.image = kGetImage(@"wallet_duihuan");
    }else{
       cell.oneImageView.image = kGetImage(@"wallet_duihuan");
    }
    
    if ([model.recordType isEqualToString:@"INCOME"]) {
        cell.jfLabel.text = [NSString stringWithFormat:@"+%@",model.recordMoney];
    }else{
        cell.jfLabel.text = [NSString stringWithFormat:@"-%@",model.recordMoney];
    }

    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArr count];
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
    [self getdata];
}

-(void)reloadViewData{
    self.index = 1;
    [self getdata];
}




@end
