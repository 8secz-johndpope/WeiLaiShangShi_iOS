//
//  HSNewsVideoViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsVideoViewController.h"
#import "HSNewsModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSNewsOneCell.h"
#import "HSNewTwoCell.h"
#import "HSNewsThirdCell.h"
#import "HSNewsFourCell.h"
#import "HSNewsDetailViewController.h"
@interface HSNewsVideoViewController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *filmArr;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation HSNewsVideoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self getdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    self.index = 1;
    self.listArr = [NSMutableArray array];
  
    // Do any additional setup after loading the view.
}
-(void)getdata
{
    
    [[MHUserService sharedInstance]initwithHSAriticeCategorypageIndex:self.index pageSize:10 categoryId:self.categoryID advIds:@"" dateTime:@""  CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSNewsModel baseModelWithArr:response[@"data"][@"list"]]];
          
            
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView cyl_reloadData];
        }
        if (error) {
            [self endRefresh];
            [self.tableView cyl_reloadData];
            KLToast(@"请检查网络情况");
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
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}



-(void)createview
{
    //    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    //    bgview.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:bgview];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
       _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.1,kScreenWidth, kScreenHeight-kTabBarHeight-kBottomHeight-kRealValue(54)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HSNewsOneCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsOneCell class])];
        [_tableView registerClass:[HSNewTwoCell class] forCellReuseIdentifier:NSStringFromClass([HSNewTwoCell class])];
        [_tableView registerClass:[HSNewsThirdCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsThirdCell class])];
        [_tableView registerClass:[HSNewsFourCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsFourCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.listArr.count > 0) {
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        if ([model.articleType isEqualToString:@"ARTICLE"]) {
            //文章
            if (model.cover.count == 0 ) {
                return kRealValue(110);
            }
            if (model.cover.count == 3 ) {
                return   kRealValue(174);
            }
            return   kRealValue(306);
        }
        if ([model.articleType isEqualToString:@"VIDEO"]) {
            return   kRealValue(223) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(356)];
        }
        if ([model.articleType isEqualToString:@"ADV"]) {
            //广告
             return   kRealValue(306);
            
        }
    }
    
    return   0;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(self);
    
    if (self.listArr.count > 0 ) {
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        if ([model.articleType isEqualToString:@"ARTICLE"]) {
            //文章
            if (model.cover.count == 0 ) {
                HSNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                return cell;
            }
            if (model.cover.count == 3 ) {
                HSNewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewTwoCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                return cell;
            }
            HSNewsThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsThirdCell class])];
            [cell createviewWithModel:model];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
        }
        if ([model.articleType isEqualToString:@"VIDEO"]) {
            HSNewsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsFourCell class])];
            [cell createviewWithModel:model];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
         
        }
        if ([model.articleType isEqualToString:@"ADV"]) {
            //广告
            
        }
    }
    
    
    HSNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        vc.ariticeID =model.id;
        if ([model.articleType isEqualToString:@"VIDEO"]) {
            vc.IsshowTop = YES;
            
        }
        if ([model.articleType isEqualToString:@"ARTICLE"]) {
            vc.IsshowTop = NO;
            
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
