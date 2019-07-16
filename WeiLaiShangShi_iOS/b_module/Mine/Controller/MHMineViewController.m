//
//  MHMineViewController.m
//  wgts
//
//  Created by AllenQin on 2018/11/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineViewController.h"
#import "MHMineHeadCell.h"
#import "MHMineAccountInfoCell.h"
#import "MHMineItemCell.h"
#import "MHMineLoginoutCell.h"
#import "MHUserModel.h"
#import "MHAssetRootVC.h"
#import "MHMineUserInfoAddressViewController.h"
#import "MHMineUserInfoViewController.h"
#import "MHTeamPersionViewController.h"
#import "MHMyOrderViewController.h"
#import "MHMessageListViewController.h"
#import "MHWithDrawVC.h"
#import "MHLoginViewController.h"
#import "MHUpdateModel.h"
#import "CTUUID.h"
#import "MHBaseTableView.h"

@interface MHMineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MHBaseTableView   *contentTableView;
@property (nonatomic, strong) MHUserModel   *userModel;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self createview];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _index  = 1;
    [self getdata];
    if ([[GVUserDefaults standardUserDefaults].ShowAppUpdateAlert isEqualToString:@"Yes"]) {
        [self checkAppUpdate];
    }
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
-(void)getdata
{
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.userModel = [MHUserModel modelWithDictionary:response[@"data"]];
            [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%ld", (long)self.userModel.userRole];
            [GVUserDefaults standardUserDefaults].phone = self.userModel.userPhone;
            [self endRefresh];
            [self.contentTableView reloadData];
        }
        if (error) {
            [self endRefresh];
//            KLToast(@"刷新失败，请重试");
        }
    }];
}
-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.contentTableView.mj_header endRefreshing];
    });
    [_contentTableView.mj_footer endRefreshing];
}

-(void)createview{
    self.navigationItem.title = @"个人中心";
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
        
    }];
    
}

-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[MHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTabBarHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xF2F3F5);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHMineHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHMineHeadCell class])];
        [_contentTableView registerClass:[MHMineAccountInfoCell class] forCellReuseIdentifier:NSStringFromClass([MHMineAccountInfoCell class])];
        [_contentTableView registerClass:[MHMineItemCell class] forCellReuseIdentifier:NSStringFromClass([MHMineItemCell class])];
        [_contentTableView registerClass:[MHMineLoginoutCell class] forCellReuseIdentifier:NSStringFromClass([MHMineLoginoutCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kRealValue(97) + kStatusBarHeight;
    }
    if (indexPath.row == 1) {
        return kRealValue(194);
    }
    if (indexPath.row == 2) {
        return kRealValue(360);
    }
    return kRealValue(64);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MHMineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineHeadCell class])];
        
        cell.username.text = self.userModel.userNickName;
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"0"]) {
            
            cell.userlever.text = @"普通用户";
            cell.userleverImage.image = kGetImage(@"icon_grade_1");
            cell.superVipImage.hidden = YES;
        }else if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]){
             cell.userlever.text = @"金牌推手";
             cell.userleverImage.image = kGetImage(@"icon_grade_2");
            if (self.userModel.vipFansCount >= 50) {
                //金牌城主
                cell.superVipImage.image =kGetImage(@"icon_grade_5");
                 cell.superVipImage.hidden = NO;
            }else{
                //无城主
//                cell.superVipImage.image =kGetImage(@"icon_grade_5");
                cell.superVipImage.hidden = YES;
            }
            
            
            
        }else if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"2"]){
             cell.userlever.text = @"钻石推手";
             cell.userleverImage.image = kGetImage(@"icon_grade_3");
             cell.superVipImage.image =kGetImage(@"icon_grade_4");
            if (self.userModel.vipFansCount >= 50) {
               
                if (self.userModel.svipFansCount >=20) {
                    //钻石城主
                     cell.superVipImage.image =kGetImage(@"icon_grade_4");
                     cell.superVipImage.hidden = NO;
                }else{
                    //金牌城主
                     cell.superVipImage.image =kGetImage(@"icon_grade_5");
                     cell.superVipImage.hidden = NO;
                }
                
            }else{
                
                if (self.userModel.svipFansCount >=20) {
                    //钻石城主
                    cell.superVipImage.image =kGetImage(@"icon_grade_4");
                     cell.superVipImage.hidden = NO;
                }else{
                    //无城主
                    cell.superVipImage.image =kGetImage(@"icon_grade_5");
                     cell.superVipImage.hidden = YES;
                }
            }
            
        }
        if (!klStringisEmpty(self.userModel.illegal)) {
            if ([self.userModel.illegal isEqualToString:@"0"]) {
                cell.MistakeInfo.hidden = YES;
            }else{
                cell.MistakeInfo.hidden = NO;
            }
        }
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.row == 1) {
        MHMineAccountInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineAccountInfoCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (_userModel) {
            [cell.richLabel setAttributedText:[NSString stringWithFormat:@"¥  %@",_userModel.availableBalance] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(27)]}];
        }
        [cell.btn  addTarget:self action:@selector(withDraw) forControlEvents:UIControlEventTouchUpInside];
        cell.leftLabel.text = _userModel.todayIncome;
        cell.midLabel.text = _userModel.totalIncome;
        cell.rightLabel.text = _userModel.totalWithdraw;
        cell.addLabel.text = _userModel.frozenAsset;
        return cell;
    }
    
    if (indexPath.row == 2) {
        MHMineItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineItemCell class])];
        cell.tapAct = ^(NSInteger tag) {
            if (tag == 15004) {
                MHAssetRootVC *assetVC = [[MHAssetRootVC alloc] init];
                [self.navigationController pushViewController:assetVC animated:YES];
            }
            if (tag == 15002) {
                MHMineUserInfoAddressViewController *assetVC = [[MHMineUserInfoAddressViewController alloc] init];
                [self.navigationController pushViewController:assetVC animated:YES];
            }
            if (tag == 15003) {
                MHTeamPersionViewController *assetVC = [[MHTeamPersionViewController alloc] init];
                [self.navigationController pushViewController:assetVC animated:YES];
            }

            if (tag == 15001) {
                MHMyOrderViewController *assetVC = [[MHMyOrderViewController alloc] init];
                [self.navigationController pushViewController:assetVC animated:YES];
            }
            if (tag == 15000) {
                MHMessageListViewController *assetVC = [[MHMessageListViewController alloc] init];
                [self.navigationController pushViewController:assetVC animated:YES];
            }
            
            
        };
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
     
        return cell;
    }
   
        MHMineLoginoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineLoginoutCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.LoginoutAct = ^{
            
            [[MHBaseClass sharedInstance]presentAlertWithtitle:@"确认退出未来商市？" message:@"退出未来商市" leftbutton:@"确定" rightbutton:@"取消" leftAct:^{
                [[MHBaseClass sharedInstance] loginOut];
                 [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshHome object:nil userInfo:nil];
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [self presentViewController:userNav animated:YES completion:^{
                    UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
                    tabBarController.selectedIndex = 0;
                }];
            } rightAct:^{
                
                
            }];
       
        };
        return cell;
    
   
}

-(void)withDraw{
    MHWithDrawVC *vc = [[MHWithDrawVC alloc]init];
    vc.withDrawMoney = _userModel.availableBalance;
    [self.navigationController pushViewController:vc animated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MHMineUserInfoViewController *vc = [[MHMineUserInfoViewController alloc]init];
        
//        vc.dic = self.dict;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


@end
