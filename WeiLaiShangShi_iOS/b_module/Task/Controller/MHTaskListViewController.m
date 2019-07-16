//
//  MHTaskListViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskListViewController.h"
#import "MHTaskTwoCell.h"
#import "MHTaskListSingerModel.h"
#import "MHTaskDetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
@interface MHTaskListViewController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@end

@implementation MHTaskListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.index = 1;
    self.listArr = [NSMutableArray array];
    [self getdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self createview];
    self.title = @"任务记录";
    
    
    // Do any additional setup after loading the view.
}
-(void)createview
{
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
-(void)getdata
{
    [[MHUserService sharedInstance]initwithWGTaskUserListpageIndex:self.index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
                
            }
            [self.listArr addObjectsFromArray:[MHTaskListSingerModel baseModelWithArr:response[@"data"]]];
            if ([[response valueForKey:@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView cyl_reloadData];
        }
        if (error) {
            [self.tableView cyl_reloadData];
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
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_tableView.frame];
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}


- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[MHTaskTwoCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskTwoCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(71);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MHTaskTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskTwoCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (self.listArr.count > 0) {
        cell.singerModel =self.listArr[indexPath.row];
    }
    cell.dotask = ^{
        if (self.listArr.count > 0) {
            
            MHTaskListSingerModel *model =self.listArr[indexPath.row];
            MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.userTaskId];
            vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
            vc.comeform = @"userlist";
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {

         MHTaskListSingerModel *model =self.listArr[indexPath.row];
        MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
        vc.taskId = [NSString stringWithFormat:@"%@",model.userTaskId];
        vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
        vc.comeform = @"userlist";
        if ([model.status isEqualToString:@"INVALID"]) {
            vc.IsVaild = @"INVALID";
        }
        if ([model.status isEqualToString:@"AUDIT"]) {
            vc.IsVaild = @"AUDIT";
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
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
