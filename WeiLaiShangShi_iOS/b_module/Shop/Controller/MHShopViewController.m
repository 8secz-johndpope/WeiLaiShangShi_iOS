//
//  MHShopViewController.m
//  wgts
//
//  Created by AllenQin on 2018/11/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHShopViewController.h"
#import "MHProductCell.h"
#import "MHbannerCell.h"
#import "MHVIPlistScrollview.h"
#import "MHShopModel.h"
#import "MHProdetailViewController.h"
#import "MHLevelRecordModel.h"
#import "MHMessageListViewController.h"
#import "MHbangdanCell.h"
#import "MHUpdateModel.h"
#import "CTUUID.h"
@interface MHShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *footerView;
@property(nonatomic, strong)MHVIPlistScrollview  *scrollView1;
@property(nonatomic, strong)UIImageView *headerImageView;
@property(nonatomic, strong)NSMutableArray *shopArr;
@property (nonatomic, strong) NSMutableArray   *yaoqingArr;

@end

@implementation MHShopViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scrollView1 stopTimer];
   
}
-(void)checkAppUpdate
{
    [[MHUserService sharedInstance]initWithOS:@"IOS" channel:@"Appstore" version:[CTUUID getAppVersion] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            MHUpdateModel *model = [MHUpdateModel baseModelWithDic:response[@"data"]];
            if (model.forceUpgrade == 1) {
                MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:model.upgradeLog ];
                CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                }];
                [alertVC addAction:cancel];
                [self presentViewController:alertVC animated:NO completion:nil];
                
            }else{
                
                if (model.upgrade == 1) {
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:model.upgradeLog ];
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"暂不更新" handler:^(CKAlertAction *action) {
                         [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert = @"No";
                        [alertVC showDisappearAnimation];
                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"立即更新" handler:^(CKAlertAction *action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                        [alertVC showDisappearAnimation];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
                }
                
            }
            
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self relodShop];
    if ([[GVUserDefaults standardUserDefaults].ShowAppUpdateAlert isEqualToString:@"Yes"]) {
        [self checkAppUpdate];
    }

}



- (void)relodShop{
    if ([GVUserDefaults standardUserDefaults].userRole == nil) {
        NSString *typeList = @"VIP";
        [[MHUserService sharedInstance]initwithTypeIdList:typeList pageSize:50 pageIndex:1 completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.shopArr = [MHShopModel baseModelWithArr:response[@"data"]];
                //footView
                self.headerImageView.image = kGetImage(@"shop_header_bg");
//                self.footerView.image = kGetImage(@"shop_footer_bg");
                [self endRefresh];
                [self.tableView reloadData];
               
                //放到数据请求中
//                [[MHUserService sharedInstance]initwithYaoqingrecord:typeList   CompletionBlock:^(NSDictionary *response, NSError *error) {
//                    [self endRefresh];
//                    if (ValidResponseDict(response)) {
//                        self.yaoqingArr = [MHLevelRecordModel baseModelWithArr:response[@"data"]];
//                        if ([self.yaoqingArr  count]>0) {
//                            [self.scrollView1 stopTimer];
//                            self.scrollView1.arrData = self.yaoqingArr;
//                            [self.scrollView1 createTimer];
//                        }
//
//                        [self.tableView reloadData];
//
//                    }
//
//                    if (error) {
//
//                        KLToast(@"刷新失败，请重试");
//                    }
//                }];
                
            }
            if (error) {
                 [self endRefresh];
//                KLToast(@"刷新失败，请重试");
            }
        }];
    }else{
        
        [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                NSString *typeList = @"";
                
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"0"]) {
                    typeList = @"VIP";
                    self.headerImageView.image = kGetImage(@"shop_header_bg");
//                    self.footerView.image = kGetImage(@"shop_footer_bg");
                }else {
                    typeList = @"SVIP";
                    //高级的
                    self.headerImageView.image = kGetImage(@"shop_header_bg_2");
//                    self.footerView.image = kGetImage(@"shop_footer_bg_2");
                }
                [[MHUserService sharedInstance]initwithTypeIdList:typeList pageSize:50 pageIndex:1 completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        self.shopArr = [MHShopModel baseModelWithArr:response[@"data"]];
                        [self endRefresh];
                         [self.tableView reloadData];
                      
                        //放到数据请求中
//                        [[MHUserService sharedInstance]initwithYaoqingrecord:typeList   CompletionBlock:^(NSDictionary *response, NSError *error) {
//                             [self endRefresh];
//                            if (ValidResponseDict(response)) {
//                                self.yaoqingArr = [MHLevelRecordModel baseModelWithArr:response[@"data"]];
//
//                                if ([self.yaoqingArr  count]>0) {
//                                    [self.scrollView1 stopTimer];
//                                    self.scrollView1.arrData = self.yaoqingArr;
//                                    [self.scrollView1 createTimer];
//
//                                }
//
//                                [self.tableView reloadData];
//
//                            }
//                            if (error) {
//
//                                KLToast(@"刷新失败，请重试");
//                            }
//                        }];
                        
                        
                    }
                    if (error) {
                         [self endRefresh];
//                        KLToast(@"刷新失败，请重试");
                    }
                }];
            }
            if (error) {
                [self endRefresh];
//                KLToast(@"刷新失败，请重试");
            }
        }];
    }

}



-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
}



-(void)createview{
    self.title = @"会员商城";
    [self.view addSubview:self.tableView];
}

-(void)messagePush
{
    MHMessageListViewController *vc =[[MHMessageListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (UITableView *)tableView {
    if (!_tableView) {
        if ([self.comeform isEqualToString:@"webview"]) { 
             _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight)];
            
        }else{
             _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight)];
        }
       
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        //headerView
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(241))];
        headerView.backgroundColor = [UIColor whiteColor];
        self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(188))];
        [headerView addSubview:self.headerImageView];
        
        UIImageView *titleImageView = [[UIImageView alloc] init];
        titleImageView.image = kGetImage(@"shop_title");
        titleImageView.frame = CGRectMake(0, kRealValue(200), kRealValue(130), kRealValue(28));
        [headerView addSubview:titleImageView];
        titleImageView.centerX = kScreenWidth/2;
        [_tableView setTableHeaderView:headerView];
        
      
        
        [_tableView registerClass:[MHProductCell class] forCellReuseIdentifier:NSStringFromClass([MHProductCell class])];
        [_tableView registerClass:[MHbangdanCell class] forCellReuseIdentifier:NSStringFromClass([MHbangdanCell class])];
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self relodShop];
        }];

    }
    return _tableView;
}


-(MHVIPlistScrollview *)scrollView1{
    if (!_scrollView1) {
        _scrollView1 = [[MHVIPlistScrollview alloc]initWithFrame:CGRectMake(kRealValue(37.5), kRealValue(143), kRealValue(300), kRealValue(300)) array:self.yaoqingArr];
        ViewBorderRadius(_scrollView1, 8, 5, [UIColor colorWithHexString:@"#dcb084"]);
    }
    return _scrollView1;
}
-(UIImageView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(521))];
    }
    return _footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
//    if (self.shopArr.count > 0 ) {
//        if (indexPath.row < self.shopArr.count) {
//             return kRealValue(280);
//        }else{
//            return kRealValue(512);
//        }
//    }else{
//        return  kRealValue(512);
//    }
   return kRealValue(280);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_shopArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductCell class])];
    if ([_shopArr count] > 0) {
            [cell creatModel:_shopArr[indexPath.row]];
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
//
//    if (self.shopArr.count > 0) {
//        if (indexPath.row < self.shopArr.count) {
//            MHProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductCell class])];
//            [cell creatModel:_shopArr[indexPath.row]];
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            return cell;
//        }else{
//            MHbangdanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHbangdanCell class])];
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            [cell addSubview:self.footerView];
//           [self.footerView addSubview:self.scrollView1];
//            return cell;
//        }
//
//    }
//    MHbangdanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHbangdanCell class])];
//    cell.selectionStyle= UITableViewCellSelectionStyleNone;
//    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //push
    if (self.shopArr.count > 0 && indexPath.row <self.shopArr.count) {
        MHShopModel *model = self.shopArr[indexPath.row ];
        MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
        vc.productId = [NSString stringWithFormat:@"%ld",model.productId];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
