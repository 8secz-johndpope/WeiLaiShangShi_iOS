//
//  HSAnnouceViewController.m
//  HSKD
//
//  Created by yuhao on 2019/4/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSAnnouceViewController.h"
#import "MHmessageTwoCell.h"
#import "MHMessageModel.h"
#import "MHWebviewViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
@interface HSAnnouceViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@end

@implementation HSAnnouceViewController


-(void)getdata
{

    [[MHUserService sharedInstance]initwithHSAnnoucepageIndex:_index pageSize:10 CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
                
            }
            [self.listArr  addObjectsFromArray:[MHMessageModel baseModelWithArr:response[@"data"][@"list"]]];
            if (response[@"data"][@"list"] > 0) {
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
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.textLabel.text = @"暂无公告";
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    self.index = 1;
    self.listArr = [NSMutableArray array];
    [self getdata];
    [self createview];
    
    // Do any additional setup after loading the view.
}
-(void)clearunread
{

}

-(void)createview
{
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
    
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight  - kTabBarHeight - kRealValue(60));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        //[_contentTableView registerClass:[MHmessageOneCell class] forCellReuseIdentifier:NSStringFromClass([MHmessageOneCell class])];
        // [_contentTableView registerClass:[MHmessageTwoCell class] forCellReuseIdentifier:NSStringFromClass([MHmessageTwoCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.listArr.count >0) {
        MHMessageModel *model = [self.listArr objectAtIndex:indexPath.row];
        
        if (!klStringisEmpty(model.imgList)) {
            if (!klStringisEmpty(model.startTime)) {
                CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kRealValue(330) , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
                return   kRealValue(261+rect.size.height);
            }else{
                CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
                return  kRealValue(230+rect.size.height);
                
            }
            
        }else{
            if (!klStringisEmpty(model.startTime)) {
                CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
                return  kRealValue(125+rect.size.height);
            }else{
                CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
                return   kRealValue(90+rect.size.height);
                
            }
            
        }
        
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MHmessageTwoCell *cell = [[MHmessageTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    
    if (self.listArr.count > 0) {
        MHMessageModel *model = [self.listArr objectAtIndex:indexPath.row];
        [cell createAnnouceWithModel:model];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.listArr.count > 0) {
        MHMessageModel *model = [self.listArr objectAtIndex:indexPath.row];
        if (model.canJump == NO) {
            return;
        }
        if ([model.contentType isEqualToString:@"H5_LINK"]) {
            
            if (!klStringisEmpty(model.content)) {
                MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.content comefrom:@"home"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else{

            [[MHUserService sharedInstance]initWithHSNoticeDetailId:model.id CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithhtmlstring:response[@"data"][@"content"] comefrom:@"gonggao"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }

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
