//
//  MHTeamPersionListDetailViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/12.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTeamPersionListDetailViewController.h"
#import "MHhucaiListCell.h"
#import "MHFansModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSQRcodeVC.h"

@interface MHTeamPersionListDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong)UITableView *contentTableView;
@property (nonatomic, strong)NSMutableArray  *listArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHTeamPersionListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xF1F3F4);
    _index  = 1;
    self.title = self.pagetitle;
    self.listArr = [NSMutableArray array];
    [self.view addSubview:self.contentTableView];
    [self getdata];
    
    
}
-(void)getdata{
    [[MHUserService sharedInstance]initwithShopFans:self.relation userRole:self.level pageIndex:self.index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
            }
            [self.listArr addObjectsFromArray:[MHFansModel baseModelWithArr:response[@"data"]]];
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.contentTableView cyl_reloadData];
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
    }];
    
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
    [self getdata];
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    
    UIView *bgView = [[UIView alloc] initWithFrame:_contentTableView.frame];
    bgView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(210), kScreenWidth, kRealValue(30))];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    label.textColor = [UIColor colorWithHexString:@"666666"];
    label.numberOfLines = 0;
    if (self.relation == 0) {
        label.text = @"您还没有直属粉丝";
    }else{
        label.text = @"您还没有二级粉丝";
    }
    
    [bgView addSubview:label];
    
    
    UIButton *signBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, kRealValue(250), kRealValue(118), kRealValue(28))];
    ViewRadius(signBtn, kRealValue(14));
    [signBtn setTitle:@"立即邀请" forState:0];
    signBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    [signBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F6AC19"]] forState:0];
    [signBtn  addTarget:self action:@selector(pushSign) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:signBtn ];
    signBtn.centerX = bgView.centerX;
   
    
    return bgView;
}

-(void)pushSign{
    HSQRcodeVC *vc = [[HSQRcodeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)endRefresh{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}

-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(kRealValue(0), kRealValue(0),kScreenWidth, kScreenHeight - kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHhucaiListCell class] forCellReuseIdentifier:NSStringFromClass([MHhucaiListCell class])];
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self getdata];
        }];
        
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getdata];
        }];
        
    }
    return _contentTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(60);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHhucaiListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHhucaiListCell class])];
    MHFansModel *model = self.listArr[indexPath.row];
    [cell.headimage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    cell.username.text = model.nickname;
    cell.acttime.text = model.createTime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.listArr count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
