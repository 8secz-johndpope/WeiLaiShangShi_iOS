
//
//  MHTaskDetailViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailViewController.h"
#import "MHTaskDetailHeadCell.h"
#import "MHTaskDetailHeadTitleCell.h"
#import "MHTaskDetailNoticeCell.h"
#import "MHTaskDetailDesCell.h"
#import "MHTaskDetailImagesCell.h"
#import "MHTaskSubmitViewController.h"
#import "MHTaskDetailModel.h"
#import "MHProductPicModel.h"
#import <AFNetworking.h>
#import "SJTableViewCell.h"
#import "SJVideoPlayer.h"
#import "AliyunOSSDemo.h"
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
#import "MHLoginViewController.h"
#import "MHShopViewController.h"
#import <Photos/Photos.h>

@interface MHTaskDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SJPlayerAutoplayDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong)UIButton *subcommitTask;
@property (nonatomic, strong)UIButton *pubcommitTask;
@property (nonatomic, assign)BOOL isnotice;
@end

@implementation MHTaskDetailViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KNotificationRereshTask object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isnotice = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.PicArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    [self creatview];
    self.title = @"任务详情";
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTask:) name:KNotificationRereshTask object:nil];
    [self getdata];
    
}
-(void)refreshTask:(NSNotification *)noti
{
    if (_isnotice == NO) {
        _isnotice = YES;
        self.comeform = @"userlist";
        self.taskId= [NSString stringWithFormat:@"%@",noti.userInfo];
        [self getdata];
        
    }
    
    
}

-(void)getdata{

    if ([self.comeform isEqualToString:@"userlist"]) {
        
         [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskUserDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
//                [self creatview];
                self.dic = [response valueForKey:@"data"];
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                    self.pubcommitTask.userInteractionEnabled = YES;
                }else if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
                        self.subcommitTask.userInteractionEnabled = YES;
                        [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                        [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        self.pubcommitTask.userInteractionEnabled = NO;
                }else if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
                            self.subcommitTask.userInteractionEnabled = NO;
                            [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                            self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            [self.pubcommitTask setTitle:@"已完成" forState:UIControlStateNormal];
                            self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            self.pubcommitTask.userInteractionEnabled = NO;
                }else if ([[self.dic valueForKey:@"status"] isEqualToString:@"INVALID"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    self.pubcommitTask.userInteractionEnabled = NO;
                } else if ([[self.dic valueForKey:@"status"] isEqualToString:@"FAILED"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"未达标" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    self.pubcommitTask.userInteractionEnabled = NO;
                }else{
                            self.subcommitTask.userInteractionEnabled = NO;
                            [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                            self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                            self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            self.pubcommitTask.userInteractionEnabled = NO;
                }
               
                
                if ([self.IsVaild isEqualToString:@"AUDIT"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"审核中" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    self.pubcommitTask.userInteractionEnabled = NO;
                }
                if ([self.IsVaild isEqualToString:@"INVALID"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    self.pubcommitTask.userInteractionEnabled = NO;
                }
                
                 [MBProgressHUD hideHUD];
                [self.tableView reloadData];
            }
            if (error) {
                [MBProgressHUD hideHUD];
//                KLToast(@"加载失败，请重试");
            }
            
        }];
    }else{
         [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
//                [self creatview];
                self.dic = [response valueForKey:@"data"];
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                    self.pubcommitTask.userInteractionEnabled = YES;
                }else
                    if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
                        self.subcommitTask.userInteractionEnabled = YES;
                        [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                        [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        self.pubcommitTask.userInteractionEnabled = NO;
                    }else
                        if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
                            self.subcommitTask.userInteractionEnabled = NO;
                            [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                            self.subcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                            [self.pubcommitTask setTitle:@"已完成" forState:UIControlStateNormal];
                            self.pubcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
                            self.pubcommitTask.userInteractionEnabled = NO;
                        }
                
                
                        else{
                            self.subcommitTask.userInteractionEnabled = NO;
                            [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                            self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                            self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            self.pubcommitTask.userInteractionEnabled = NO;
                        }
                if ([self.IsVaild isEqualToString:@"CannotDoTask"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    self.pubcommitTask.userInteractionEnabled = NO;
                }
                 [MBProgressHUD hideHUD];
                [self.tableView reloadData];
            }
            if (error) {
                 [MBProgressHUD hideHUD];
//                KLToast(@"加载失败，请重试");
            }
            
        }];
    }
   
   
    
}

-(void)creatview
{
    
    [self.view addSubview:self.tableView];
    
    self.subcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xFF3344);
    self.subcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.subcommitTask.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(105) - kBottomHeight-kTopHeight, kRealValue(343), kRealValue(41));
    self.subcommitTask.layer.cornerRadius= kRealValue(20);
    [self.subcommitTask addTarget:self action:@selector(subcomitAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subcommitTask];
    
    
    self.pubcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
     self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
     self.pubcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
     self.pubcommitTask.titleLabel.textColor = KColorFromRGB(0x6e6e6e);
     self.pubcommitTask.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(55) - kBottomHeight-kTopHeight, kRealValue(343), kRealValue(41));
     self.pubcommitTask.layer.cornerRadius= kRealValue(20);
     [self.pubcommitTask addTarget:self action:@selector(pubcommitAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.pubcommitTask];
    
}
-(void)subcomitAct
{
    if (klObjectisEmpty(self.dic)) {
        return;
    }
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        NSInteger userlever = [[GVUserDefaults standardUserDefaults].userRole integerValue];
        if (userlever >=[self.vipLever integerValue]   ) {
            //跳转到l下一个页面
//            MHTaskSubmitViewController *VC= [[MHTaskSubmitViewController alloc]init];
//            VC.dic = self.dic;
//            VC.pagetitle = @"领取任务";
//            [self.navigationController pushViewController:VC animated:YES];
            [MBProgressHUD showActivityMessageInWindow:@""];
            [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:[self.dic valueForKey:@"id"] taskCode:[self.dic valueForKey:@"taskCode"] taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    [MBProgressHUD hideHUD];
                    KLToast(@"任务领取成功");
                    self.comeform = @"userlist";
                    self.taskId= [NSString stringWithFormat:@"%@",response[@"data"]];
                    [self getdata];
                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshTask object:nil userInfo:response[@"data"]];
                    
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
            
        }else{
            NSString *str = @"";
            if ([self.vipLever integerValue] == 1) {
                str =@"你还不是金牌推手,请前往升级";
            }
            if ([self.vipLever integerValue] == 2) {
                str =@"你还不是钻石推手,请前往升级";
            }
            
            MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:str ];
            alertVC.messageAlignment = NSTextAlignmentCenter;
            CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"确认取消" handler:^(CKAlertAction *action) {
                 [alertVC showDisappearAnimation];
            }];
            CKAlertAction *sure = [CKAlertAction actionWithTitle:@"去升级" handler:^(CKAlertAction *action) {
                MHShopViewController *vc = [[MHShopViewController alloc]init];
                vc.comeform = @"webview";
                //        vc.productId = [NSString stringWithFormat:@"%@",message.body];
                [self.navigationController pushViewController:vc animated:YES];
                 [alertVC showDisappearAnimation];
            }];
            [alertVC addAction:cancel];
            [alertVC addAction:sure];
            [self presentViewController:alertVC animated:NO completion:nil];
            
        }
        
        
        
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
    
    
    
}
-(void)pubcommitAct
{
    if (klObjectisEmpty(self.dic)) {
        return;
    }
    [[MHUserService sharedInstance]initWithWGTaskIsCompeleteWithUserTaskID:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            MHTaskSubmitViewController *VC= [[MHTaskSubmitViewController alloc]init];
            VC.dic = self.dic;
            VC.iscompelete = YES;
            VC.pagetitle = @"提交任务";
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            KLToast([response valueForKey:@"message"]);
        }
        if (error) {
             KLToast([response valueForKey:@"网络不佳，请重试"]);
        }
        
    }];
    
   
}
- (UITableView *)tableView {
    if (!_tableView) {

        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[MHTaskDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
        [_tableView registerClass:[MHTaskDetailHeadTitleCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskDetailHeadTitleCell class])];
        [_tableView registerClass:[MHTaskDetailDesCell class]
           forCellReuseIdentifier:NSStringFromClass([MHTaskDetailDesCell class])];
        [_tableView registerClass:[MHTaskDetailImagesCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskDetailImagesCell class])];
        [_tableView registerClass:[MHTaskDetailNoticeCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskDetailNoticeCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        // 配置列表自动播放
//        [_tableView sj_enableAutoplayWithConfig:[SJPlayerAutoplayConfig configWithPlayerSuperviewTag:101 autoplayDelegate:self]];
//        
//        [_tableView sj_needPlayNextAsset];
        
    }
    return _tableView;
}
- (void)sj_playerNeedPlayNewAssetAtIndexPath:(NSIndexPath *)indexPath {
    SJTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ( !_player || !_player.isFullScreen ) {
        [_player stopAndFadeOut]; // 让旧的播放器淡出
        _player = [SJVideoPlayer lightweightPlayer]; // 创建一个新的播放器
        _player.generatePreviewImages = YES; // 生成预览缩略图, 大概20张
        // fade in(淡入)
        _player.view.alpha = 0.001;
        [UIView animateWithDuration:0.6 animations:^{
            self.player.view.alpha = 1;
        }];
    }
#ifdef SJMAC
    _player.disablePromptWhenNetworkStatusChanges = YES;
#endif
    [cell.view.coverImageView addSubview:self.player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    NSString *str;
    if (self.PicArr.count > 0) {
        MHProductPicModel *model = [self.PicArr objectAtIndex:0];
        str =model.filePath;
    }
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:str] playModel:[SJPlayModel UITableViewCellPlayModelWithPlayerSuperviewTag:cell.view.coverImageView.tag atIndexPath:indexPath tableView:self.tableView]];
    _player.URLAsset.title = self.taskname;
    _player.URLAsset.alwaysShowTitle = YES;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak typeof(self) _self = self;
//    cell.view.clickedPlayButtonExeBlock = ^(SJPlayView * _Nonnull view) {
//        __strong typeof(_self) self = _self;
//        if ( !self ) return;
//        [self sj_playerNeedPlayNewAssetAtIndexPath:indexPath];
//    };
//}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
    // [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kRealValue(40);
        }
        if (indexPath.row == 1) {
            return kRealValue(87);
        }
    }
    if (indexPath.section == 1) {
       
            return kRealValue(50);

    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return kRealValue(40);
        }
        if (indexPath.row == 1) {
            
            if (!klObjectisEmpty(self.dic)) {
                return  [[self.dic valueForKey:@"detail"] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)] width:kRealValue(343)] + kRealValue(60);;
            }else{
                return kRealValue(300);
            }

            return kRealValue(260);
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return kRealValue(40);
        }
        if (indexPath.row == 1) {
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]) {
                NSInteger btnoffset = 10;
                 NSInteger pading = kRealValue(10);
                for (int i = 0; i < self.PicArr.count; i++) {
                    
                    MHProductPicModel *model = [self.PicArr objectAtIndex:i];
                    btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue])+pading;
                }
                return kRealValue(btnoffset);
            }
            
            return kRealValue(500);
        }
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (!klObjectisEmpty(self.dic)) {
            return 2;
        }
    }
    if (section == 1) {
        if (!klObjectisEmpty(self.dic)) {
            return 1;
        }
    }
    if (section == 2) {
        if (!klObjectisEmpty(self.dic)) {
            return 2;
        }
    }
    if (section == 3) {
        if (!klObjectisEmpty(self.dic)) {
            return 2;
        }
        
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kRealValue(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     UIView *headerView = [[UIView alloc]init];
     headerView.backgroundColor = KColorFromRGB(0xF1F3F4);
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            MHTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.self.savePic.hidden = YES;
            if (!klObjectisEmpty(self.dic)) {
                if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"SVIP"]) {
                    cell.headtitle.text = @"钻石推手任务";
                }
                if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"VIP"]) {
                    cell.headtitle.text = @"金牌推手任务";
                }
            }
            
            return cell;
        }
        MHTaskDetailHeadTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadTitleCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (!klObjectisEmpty(self.dic)) {
            NSString *str1 =klStringisEmpty([self.dic valueForKey:@"taskName"]) ==1?@"":[self.dic valueForKey:@"taskName"];
            NSString *str2 =klStringisEmpty([self.dic valueForKey:@"produceName"]) ==1?@"":[self.dic valueForKey:@"produceName"];
            cell.taskname.text =   [NSString stringWithFormat:@"%@%@",str2,str1];
            cell.tasknum.text = klStringisEmpty([self.dic valueForKey:@"taskCode"]) ==1?@"":[self.dic valueForKey:@"taskCode"];
             cell.tasktime.text = klStringisEmpty([self.dic valueForKey:@"beginTime"]) ==1?@"":[NSString stringWithFormat:@"%@-%@",[self.dic valueForKey:@"beginTime"],[self.dic valueForKey:@"endTime"]];
        }
        
        return cell;
        
    }
    if (indexPath.section == 1) {
        
        MHTaskDetailNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailNoticeCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            MHTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
             cell.headtitle.text = @"任务描述";
             cell.self.savePic.hidden = YES;
            return cell;
        }
        MHTaskDetailDesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailDesCell class])];
        cell.CopyAct = ^{
            UIPasteboard *copy = [UIPasteboard generalPasteboard];
            [copy setString: [self.dic valueForKey:@"detail"]];
            if (copy == nil || [ [self.dic valueForKey:@"detail"] isEqualToString:@""]==YES)
            {
                
                KLToast(@"复制失败")
                
                
            }else{
                KLToast(@"复制成功")
                
                
            }
        };
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        if (!klObjectisEmpty(self.dic)) {
            cell.deslabel.text = klStringisEmpty([self.dic valueForKey:@"detail"]) ==1?@"":[self.dic valueForKey:@"detail"];
        }
        return cell;
        
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            
            MHTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
                 cell.headtitle.text = @"图片";
            }
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                cell.headtitle.text = @"视频";
            }
          
            cell.self.savePic.hidden = NO;
            cell.SaveAct = ^{
                // 获取当前App的相册授权状态
                PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
                // 判断授权状态
                if (authorizationStatus == PHAuthorizationStatusAuthorized) {
                    // 如果已经授权, 保存图片
                   [self save];
                }
                // 如果没决定, 弹出指示框, 让用户选择
                else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        // 如果用户选择授权, 则保存图片
                        if (status == PHAuthorizationStatusAuthorized) {
                            [self save];
                        }
                    }];
                } else {
                    // 前往设置
                    [[MHBaseClass sharedInstance] presentAlertWithtitle:@"提示" message:@"你已拒绝未来商市访问您的相册，前往打开设置" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
                        
                    } rightAct:^{
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];
                    }];
                    
                    
                }
           
                
                
               
                
            };
            return cell;
        }
        
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
            MHTaskDetailImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailImagesCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.PictureArr = self.PicArr;
            return cell;
            
        }
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
           
            static NSString *SJTableViewCellID = @"SJTableViewCell";
            SJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SJTableViewCellID];
            if ( !cell ) cell = [[SJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SJTableViewCellID];
            __weak typeof(self) _self = self;
            cell.view.clickedPlayButtonExeBlock = ^(SJPlayView * _Nonnull view) {
                __strong typeof(_self) self = _self;
                if ( !self ) return;
                [self.player stopAndFadeOut];
                
                // create new player
                self.player = [SJVideoPlayer player];
#ifdef SJMAC       
                self.player.disablePromptWhenNetworkStatusChanges = YES;
#endif
                [view.coverImageView addSubview:self.player.view];
                [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.offset(0);
                }];
                
                NSString *str;
                if (self.PicArr.count > 0) {
                    MHProductPicModel *model = [self.PicArr objectAtIndex:0];
                    str =model.filePath;
                }
                self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:str] playModel:[SJPlayModel UITableViewCellPlayModelWithPlayerSuperviewTag:cell.view.coverImageView.tag atIndexPath:indexPath tableView:self.tableView]];
                self.player.URLAsset.title =klStringisEmpty([self.dic valueForKey:@"taskName"]) ==1?@"":[self.dic valueForKey:@"taskName"] ;
                self.player.URLAsset.alwaysShowTitle = YES;
            };
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
           
            
        }

    }

    return nil;
    
    
}

-(void)save
{
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
        
        for (int i = 0; i < self.PicArr.count; i++) {
            
            MHProductPicModel *model = [self.PicArr objectAtIndex:i];
            [self toSaveImage:model.filePath];
            
        }
    }
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
        
        for (int i = 0; i < self.PicArr.count; i++) {
            
            MHProductPicModel *model = [self.PicArr objectAtIndex:i];
            [self playerDownload:model.filePath];
            
        }
    }
}
#pragma mark 保存图片
- (void)toSaveImage:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __block UIImage *img;
    [manager diskImageExistsForURL:url completion:^(BOOL isInCache) {
        if (isInCache) {
            img =  [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
            // 保存图片到相册中
            UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }else{
            //从网络下载图片
            NSData *data = [NSData dataWithContentsOfURL:url];
            img = [UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }
    }];
    
    
   
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message…
        KLToast(@"图片保存失败");
    }
    else  // No errors
    {

         KLToast(@"图片保存成功");
    }
}

#pragma mark 保存图片
//-----下载视频--
- (void)playerDownload:(NSString *)url{
    
   
    
    [MBProgressHUD showActivityMessageInWindow:@"正在保存"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"jaibaili.mp4"];
    NSURL *urlNew = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlNew];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                return [NSURL fileURLWithPath:fullPath];
                            }
                   completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                       MHLog(@"%@",response);
                       [self saveVideo:fullPath];
                   }];
    [task resume];
    
}

//videoPath为视频下载到本地之后的本地路径
- (void)saveVideo:(NSString *)videoPath{
    
    if (videoPath) {
        NSURL *url = [NSURL URLWithString:videoPath];
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([url path]);
        if (compatible)
        {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([url path], self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {

//        NSString *str = [NSString stringWithFormat:@"保存视频失败%@", error.localizedDescription];
//         KLToast(str);
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [MBProgressHUD showActivityMessageInWindow:@"保存视频失败" timer:5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        });
        
    }
    else {
//        NSLog(@"保存视频成功");
//         KLToast(@"保存视频成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [MBProgressHUD showActivityMessageInWindow:@"保存视频成功" timer:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [MBProgressHUD hideHUD];
            });

            
        });
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
