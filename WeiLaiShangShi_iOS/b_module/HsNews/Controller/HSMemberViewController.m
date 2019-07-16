//
//  HSMemberViewController.m
//  HSKD
//
//  Created by yuhao on 2019/4/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSMemberViewController.h"
#import "HSMemberThreeCell.h"
#import "HSMemberNoImgCell.h"
#import "HSMemberOneCell.h"
#import "HSMemberOneRight.h"
#import "MHTaskDetailModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSMemberOneLeftCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSFriendShopViewController.h"
#import "HSNewsDetailViewController.h"
#import "HSTaskShareViewController.h"
#import "HSBannerModel.h"
#import "MHWebviewViewController.h"
#import "HSEmporCell.h"
#import "HSQRcodeVC.h"
#import "SDCycleScrollView.h"
@interface HSMemberViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@property (nonatomic, strong)NSMutableDictionary *userDic;
@property (nullable, strong)NSMutableArray *bannerArr;
@property (nonatomic, strong)UIImageView *headimg;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation HSMemberViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfo];
    [self getdata];
    [self getbanner];
    
}
-(void)getUserInfo
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        
        self.userDic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.userDic = [response valueForKey:@"data"];
            }
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    self.index = 1;
    self.listArr = [NSMutableArray array];
    
    
    // Do any additional setup after loading the view.
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView  didSelectItemAtIndex:(NSInteger)index
{
    if (self.bannerArr.count > 0) {
        HSBannerModel *model = [self.bannerArr objectAtIndex:index];
        MHWebviewViewController *vc= [[MHWebviewViewController alloc]initWithurl:model.actionUrl comefrom:@"home"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


-(void)getbanner
{
    [[MHUserService sharedInstance]initWithFirstPageComponent:@"6" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *bannerArr = response[@"data"];
            [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"type"] isEqualToString:@"BANNER"]) {
                    NSMutableArray *picArr = obj[@"result"];
                    self.bannerArr = [HSBannerModel baseModelWithArr:picArr];
                    if (self.bannerArr.count > 0) {
                        HSBannerModel *model = [self.bannerArr objectAtIndex:0];
                        [self.headimg sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:kGetImage(@"emty_movie")];
                        NSMutableArray *crlArr = [NSMutableArray array];
                        [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [crlArr addObject:obj[@"sourceUrl"]];
                        }];
                        self.cycleScrollView.imageURLStringsGroup = crlArr;
                       
                    }
                }
            }];
        }
    }];
}
-(void)getdata
{
    [[MHUserService sharedInstance]initwithWGTaskListcompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
                
            }
            self.listArr = [MHTaskDetailModel baseModelWithArr:[response valueForKey:@"data"]];
            if ([[response valueForKey:@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView cyl_reloadData];
        }
        if (error) {
            [self endRefresh];
            [self.tableView cyl_reloadData];
        }
    }]
    
    ;
}

-(void)createview
{
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getdata];
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
    [self getbanner];
}
-(void)NodataemptyOverlayClicked:(id)sender
{
    self.index = 1;
    [self getdata];
    [self getbanner];
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.textLabel.text= @"点击刷新";
    networkErrorPlaceHolder.delegate = self;
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
-(void)headAct
{
    if (self.bannerArr.count > 0) {
        HSBannerModel *model = [self.bannerArr objectAtIndex:0];
        MHWebviewViewController *vc= [[MHWebviewViewController alloc]initWithurl:model.actionUrl comefrom:@"home"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.1,kScreenWidth, kScreenHeight-kTabBarHeight-kRealValue(44)-kRealValue(42)-kStatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(145))];
        headview.backgroundColor = [UIColor whiteColor];
    
        _tableView.tableHeaderView = headview;
//        self.headimg = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(16), kRealValue(351), kRealValue(65))];
//        self.headimg.userInteractionEnabled = YES;
//        self.headimg.image = kGetImage(@"emty_movie");
////        self.headimg.backgroundColor = kRandomColor;
//        [headview addSubview:self.headimg];
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(kRealValue(12), kRealValue(5), kRealValue(350), kRealValue(140)) delegate:nil placeholderImage:kGetImage(@"emty_movie")];
        self.cycleScrollView.delegate = self;
        self.cycleScrollView.currentPageDotColor = KColorFromRGB(0xFD541B);
        self.cycleScrollView.pageDotColor = KColorFromRGB(0xffffff);
        [headview addSubview:self.cycleScrollView];

        UITapGestureRecognizer *headtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headAct)];
        [self.headimg addGestureRecognizer:headtap];
      
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(104), kScreenWidth, 1/kScreenScale)];
        [headview addSubview:line];
        
        
        [_tableView registerClass:[HSMemberThreeCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberThreeCell class])];
        [_tableView registerClass:[HSMemberOneCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneCell class])];
        [_tableView registerClass:[HSMemberNoImgCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
         [_tableView registerClass:[HSMemberOneRight class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneRight class])];
        [_tableView registerClass:[HSMemberOneLeftCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
         [_tableView registerClass:[HSEmporCell class] forCellReuseIdentifier:NSStringFromClass([HSEmporCell class])];
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
        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
        if (model.cover.count == 0) {
            if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
                return kRealValue(105);
            }
            return kRealValue(55) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
        }
        if (model.cover.count >1 ) {
            if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
                return kRealValue(185);
            }
              return kRealValue(133) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
        }
        if (model.cover.count == 1) {
            if ([model.coverPos isEqualToString:@"LEFT"]) {
                
                 return   kRealValue(124);
            }
            else if ([model.coverPos isEqualToString:@"RIGHT"]) {
                
                return   kRealValue(124);
            }
            else {
                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
                    return kRealValue(320);
                }
                return kRealValue(267) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
            
            
        }
    }
    return 0;
    
    
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
    
    if (self.listArr.count > 0) {
        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
        if (model.cover.count == 0) {
            HSMemberNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            [cell createviewWithModel:model];
            return cell;
        }
        if (model.cover.count >1 ) {
            HSMemberThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberThreeCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            [cell createviewWithModel:model];
            return cell;
        }
        if (model.cover.count == 1) {
            if ([model.coverPos isEqualToString:@"LEFT"]) {
                
                HSMemberOneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                 [cell createviewWithModel:model];
                return cell;
            }
            else if ([model.coverPos isEqualToString:@"RIGHT"]) {
                HSMemberOneRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneRight class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                 [cell createviewWithModel:model];
                return cell;
            }
            else {
                HSMemberOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                 [cell createviewWithModel:model];
                return cell;
            }
            
            
        }
    }
    
    HSEmporCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSEmporCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
        if ([model.property isEqualToString:@"REVIEW"]) {
            //审核任务
            HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([model.property isEqualToString:@"APPOINT"]){
           //阅读指定任务
             [self getMHTaskDetailModel:model];
            
        }else if ([model.property isEqualToString:@"APPOINT_ADV"]) {
            //阅读指定广告
            [self getMHTaskDetailModel:model];
            
        }else if ([model.property isEqualToString:@"SHARE"]) {
            //分享任务
           
            HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            if ([model.detailType isEqualToString:@"VIDEO"]) {
                vc.IsshowTop = YES;
                
            }else{
                vc.IsshowTop = NO;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([model.property isEqualToString:@"DOWNLOAD"]) {
            //下载任务
            HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            if ([model.detailType isEqualToString:@"VIDEO"]) {
                vc.IsshowTop = YES;
                
            }else{
                vc.IsshowTop = NO;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([model.property isEqualToString:@"READ_ADV"]) {
            //阅读广告任务
            
            
        }else if ([model.property isEqualToString:@"READ"]) {
            //阅读广告任务
            //下载任务
            HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            if ([model.detailType isEqualToString:@"VIDEO"]) {
                vc.IsshowTop = YES;
                
            }else{
                vc.IsshowTop = NO;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
}

-(void)getMHTaskDetailModel:(MHTaskDetailModel *)model
{
    // 阅读指定任务
    // 未领取
    if ([model.status isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            if ([model.power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"哎呀，友力值余额不足无法领取任务啦！ 解决办法：①邀友获赠②友力值商城购买" message:@"" leftbutton:@"取消" rightbutton:@"获取友力值" leftAct:^{
                  
                } rightAct:^{
                    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                return;
            }else{
                
            }
        }else{
            
        }
        
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                //获取任务类型
                [[MHUserService sharedInstance]initwithHSAriticeDetailariticeId:model.remark ISAd:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        [MBProgressHUD hideHUD];
                        if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                            //视频
                            
                            HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                            vc.ariticeID = model.remark;
                            if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                                vc.IsAd = @"ad";
                            }else{
                                vc.IsAd =@"no";
                            }
                            
                            vc.IsshowTop =YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                        }
                        if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"ARTICLE"]) {
                            //文章
                            HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                            vc.ariticeID = model.remark;
                            if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                                vc.IsAd = @"ad";
                            }else{
                                vc.IsAd =@"no";
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                        }
                        
                        
                    }else{
                        [MBProgressHUD hideHUD];
                        KLToast(response[@"message"]);
                    }
                    if (error) {
                        [MBProgressHUD hideHUD];
                    }
                    
                    
                }];
            }else{
                
                [MBProgressHUD hideHUD];
                KLToast([response valueForKey:@"message"]);
                
            }
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [MBProgressHUD showActivityMessageInWindow:@"领取失败,请刷新后重试"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                    });
                    
                });
            }
        }];
    }
    //进行中
    if ([model.status isEqualToString:@"ACTIVE"]) {
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithHSAriticeDetailariticeId:model.remark ISAd:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                    //视频
                    
                    HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                    vc.ariticeID = model.remark;
                    if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                        vc.IsAd = @"ad";
                    }else{
                        vc.IsAd =@"no";
                    }
                    vc.IsshowTop =YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"ARTICLE"]) {
                    //文章
                    HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                    if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                        vc.IsAd = @"ad";
                    }else{
                        vc.IsAd =@"no";
                    }
                    vc.ariticeID = model.remark;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                
                
            }else{
                [MBProgressHUD hideHUD];
                KLToast(response[@"message"]);
            }
            if (error) {
                [MBProgressHUD hideHUD];
            }
            
            
        }];
    }
    if ([model.status isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
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
