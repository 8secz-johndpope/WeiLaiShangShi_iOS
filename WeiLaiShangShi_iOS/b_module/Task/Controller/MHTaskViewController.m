//
//  MHTaskViewController.m
//  wgts
//
//  Created by AllenQin on 2018/11/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHTaskViewController.h"
#import "MHTaskCell.h"
#import "MHTaskTwoCell.h"
#import "MHTsakheadCell.h"
#import "MHtaskDesCell.h"
#import "MHTaskDesImage.h"
#import "MHTaskDetailViewController.h"
#import "MHTaskListViewController.h"
#import "MHTaskListModel.h"
#import "MHTaskListSingerModel.h"
#import "MHLoginViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHTaskThreeCell.h"
#import "MHUpdateModel.h"
#import "CTUUID.h"
@interface MHTaskViewController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *ListArr;
@property(nonatomic, strong)NSMutableArray *VIPTaskListArr;
@property(nonatomic, strong)NSMutableArray *SVIPTaskListArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHTaskViewController

-(void)viewWillAppear:(BOOL)animated
{
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
- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 1;
    [self createview];
    self.title = @"任务大厅";
    self.ListArr = [NSMutableArray array];
    self.VIPTaskListArr= [NSMutableArray array];
    self.SVIPTaskListArr = [NSMutableArray array];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kRealValue(10), kRealValue(60), kRealValue(30));
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [btn setTitle:@"任务记录" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0xFF0116) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(taskrecord) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    // Do any additional setup after loading the view.
}
-(void)getdata
{
    [[MHUserService sharedInstance]initwithWGTaskListcompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.ListArr  removeAllObjects];
            }
            self.ListArr = [MHTaskListModel baseModelWithArr:response[@"data"]];
            for (int i = 0; i < self.ListArr.count; i++) {
                MHTaskListModel *model = self.ListArr[i];
                if ([model.taskType isEqualToString:@"VIP"]) {
                    self.VIPTaskListArr = [MHTaskListSingerModel baseModelWithArr:model.list];
                }
                if ([model.taskType isEqualToString:@"SVIP"]) {
                    self.SVIPTaskListArr = [MHTaskListSingerModel baseModelWithArr:model.list];
                }
            }
            [self endRefresh];
            [self.tableView reloadData];
        }
        if (error) {
            [self endRefresh];
//            KLToast(@"刷新失败，请重试");
        }
    }];
}
-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshing];
}

-(void)taskrecord
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        MHTaskListViewController *vc =[[MHTaskListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
   
}

-(void)createview
{
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
       
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[MHTaskTwoCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskTwoCell class])];
        [_tableView registerClass:[MHTsakheadCell class] forCellReuseIdentifier:NSStringFromClass([MHTsakheadCell class])];
        [_tableView registerClass:[MHtaskDesCell class]
           forCellReuseIdentifier:NSStringFromClass([MHtaskDesCell class])];
        [_tableView registerClass:[MHTaskDesImage class] forCellReuseIdentifier:NSStringFromClass([MHTaskDesImage class])];
         [_tableView registerClass:[MHTaskThreeCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskThreeCell class])];
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
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kRealValue(44);
        }
       
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return kRealValue(44);
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return kRealValue(44);
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            NSString  *testString = @"1、购买任意一款会员商品即可成为金牌推手；购买任意一款高级会员商品成为钻石会员；\n2、金牌推手每天可领取2条金牌推手任务；钻石推手每天可领取2条金牌推手任务之外，还可领取2条钻石推手任务；\n3、做任务时，复制任务文案，保存任务图片/视频，去朋友圈发布广告，注意：朋友圈广告格式必须为：【任务文案+任务图片/视频】；不得屏蔽微信好友查看您的朋友圈；\n4、朋友圈广告发布完毕，回到APP内，点击领取任务按钮，领取任务；2小时候，去朋友圈截图保存，回到APP内，点击提交任务按钮，提交截图。\n5、提交的截图必须是朋友圈全屏截图；\n6、请严格按照以上任务规范完成任务，若后台审核时检查到用户上传虚假任务截图，该用户可能会被冻结账号；\n7、任务当天有效，每日24点清零重置，届时，未完成任务默认过期。";
            
            return [testString heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)] width:kRealValue(343)]+kRealValue(20) ;
            
        }
        if (indexPath.row == 2) {
            return kRealValue(402);
        }
    }
    return kRealValue(71);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.VIPTaskListArr.count > 0) {
            return 1 + self.VIPTaskListArr.count;
        }else{
            return 2;
        }
    }
    if (section == 1) {
        if (self.SVIPTaskListArr.count > 0) {
            return 1 + self.SVIPTaskListArr.count;
        }else{
            return 2;
        }
        
    }
    if (section == 2) {
        return 3;
    }
    
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        MHTsakheadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTsakheadCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (self.ListArr.count >0) {
            for (int i = 0; i < self.ListArr.count; i++) {
                MHTaskListModel *model = self.ListArr[i];
                if ([model.taskType isEqualToString:@"VIP"]) {
                    cell.headprosess.text = [NSString stringWithFormat:@"今日可领任务次数(%@/%@)",[NSString stringWithFormat:@"%@",model.count],
                                             [NSString stringWithFormat:@"%@",model.totalCount]];
                    
                    
                }
            }
        }
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row != 0) {
       
        if (self.VIPTaskListArr.count > 0) {
            
            MHTaskTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskTwoCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.statubtn.hidden = NO;
            cell.moneylabel.hidden = NO;
            cell.Tasktitlelabel.hidden = NO;
            cell.singerModel =self.VIPTaskListArr[indexPath.row-1];
            cell.dotask = ^{
                if (self.VIPTaskListArr.count > 0) {
                    MHTaskListSingerModel *model =self.VIPTaskListArr[indexPath.row-1];
                    MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                    vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            };
             return cell;
        }
        if (self.VIPTaskListArr.count == 0) {
            
            MHTaskThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskThreeCell class])];
           cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.titlelabel.text = @"暂无金牌推手任务";
             return cell;
            
        }
       
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        MHTsakheadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTsakheadCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.headtitle.text = @"钻石推手任务";
        if (self.ListArr.count >0) {
            for (int i = 0; i < self.ListArr.count; i++) {
                MHTaskListModel *model = self.ListArr[i];
                if ([model.taskType isEqualToString:@"SVIP"]) {
                    cell.headprosess.text = [NSString stringWithFormat:@"今日可领任务次数(%@/%@)",[NSString stringWithFormat:@"%@",model.count],
                                             [NSString stringWithFormat:@"%@",model.totalCount]];
                }
            }
        }
        return cell;
    }
    if (indexPath.section == 1 && indexPath.row != 0) {
       
        if (self.SVIPTaskListArr.count > 0) {
            MHTaskTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskTwoCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.statubtn.hidden = NO;
            cell.moneylabel.hidden = NO;
            cell.Tasktitlelabel.hidden = NO;
            cell.singerModel =self.SVIPTaskListArr[indexPath.row-1];
            cell.dotask = ^{
                if (self.SVIPTaskListArr.count > 0) {
                    MHTaskListSingerModel *model =self.SVIPTaskListArr[indexPath.row-1];
                    MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                    vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
             return cell;
        }
        if (self.SVIPTaskListArr.count == 0) {
            
            MHTaskThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskThreeCell class])];
             cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.titlelabel.text = @"暂无钻石推手任务";
            return cell;

        }
        
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        MHTsakheadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTsakheadCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
         cell.headtitle.text = @"任务完成规范";
        cell.headprosess.hidden = YES;
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        MHtaskDesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHtaskDesCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        MHTaskDesImage *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDesImage class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0 && indexPath.row != 0) {
        if (self.VIPTaskListArr.count > 0) {
            MHTaskListSingerModel *model =self.VIPTaskListArr[indexPath.row-1];
            MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
            if ([model.status isEqualToString:@"PENDING"]) {
                if (self.ListArr.count >0) {
                    MHTaskListModel *model = self.ListArr[0];
                    if ([model.taskType isEqualToString:@"VIP"] ) {
                        
                        if ([[NSString stringWithFormat:@"%@",model.count] integerValue] >=[[NSString stringWithFormat:@"%@",model.totalCount] integerValue]) {
                            vc.IsVaild = @"CannotDoTask";
                        }
                    }
                }
            }
             vc.vipLever = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
       
        
    }
    if (indexPath.section == 1 && indexPath.row != 0) {
        if (self.SVIPTaskListArr.count > 0) {
            MHTaskListSingerModel *model =self.SVIPTaskListArr[indexPath.row-1];
            MHTaskDetailViewController *vc = [[MHTaskDetailViewController alloc]init];
            if ([model.status isEqualToString:@"PENDING"]) {
                if (self.ListArr.count >0) {
                    for (int i = 0; i < self.ListArr.count; i++) {
                        MHTaskListModel *model = self.ListArr[i];
                        if ([model.taskType isEqualToString:@"SVIP"] ) {
                            if ([[NSString stringWithFormat:@"%@",model.count] integerValue] >=[[NSString stringWithFormat:@"%@",model.totalCount] integerValue]) {
                                vc.IsVaild = @"CannotDoTask";
                            }
                        }
                    }
                }
            }
            vc.vipLever = @"2";
            vc.taskId = [NSString stringWithFormat:@"%@",model.id];
            vc.taskname =[NSString stringWithFormat:@"%@",model.taskName];
            [self.navigationController pushViewController:vc animated:YES];
        }

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
