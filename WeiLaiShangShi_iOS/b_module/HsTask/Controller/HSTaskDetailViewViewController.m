//
//  HSTaskDetailViewViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskDetailViewViewController.h"
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
#import "HSFriendShopViewController.h"
#import "HSWebviewCell.h"
#import "HSQRcodeVC.h"
#import "HSChargeController.h"
@interface HSTaskDetailViewViewController ()<UITableViewDelegate,UITableViewDataSource,SJPlayerAutoplayDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong)UIButton *subcommitTask;
@property (nonatomic, strong)UIButton *pubcommitTask;
@property (nonatomic, assign)BOOL isnotice;
@property (nonatomic, strong)NSMutableDictionary *userDic;
@property (nonatomic, strong)UIView *naviView;
@property (nonatomic, strong)UIImageView *headImgview;
@property (nonatomic, strong)UILabel *headnameview;
@property (nonatomic, strong)UILabel *headtimeview;
@property (nonatomic, strong)UILabel *headcodeview;
@property (nonatomic, strong)MHTaskDetailImagesCell *ImagesCell;
@end

@implementation HSTaskDetailViewViewController

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
    self.fd_prefersNavigationBarHidden = YES;
    self.PicArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    [self creatview];
    self.title = @"任务详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTask:) name:KNotificationRereshTask object:nil];
    [self getdata];
    [self getUserInfo];
}
-(void)getUserInfo
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        
        self.userDic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.userDic = [response valueForKey:@"data"];
                self.headnameview.text = [self.userDic valueForKey:@"nickname"];
                self.headcodeview.text = [NSString stringWithFormat:@"ID:%@",[self.userDic valueForKey:@"userCode"]];
                [self.headImgview sd_setImageWithURL:[NSURL URLWithString:[self.userDic valueForKey:@"avatar"]] placeholderImage:kGetImage(@"sm_hs_icon")];
                
            }
        }];
    }
    
}
-(void)refreshTask:(NSNotification *)noti
{
    if (_isnotice == NO) {
        _isnotice = YES;
        self.comeform = @"userlist";
//        self.taskId= [NSString stringWithFormat:@"%@",noti.userInfo];
        [self getdata];
        
    }
    
    
}

-(void)getdata{

        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
//                                [self creatview];
                self.dic = [response valueForKey:@"data"];
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]) {
                    self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                }
                if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
                    self.subcommitTask.userInteractionEnabled = NO;
                    [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                    self.pubcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
                    self.pubcommitTask.userInteractionEnabled = YES;
                }else if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
                        self.subcommitTask.userInteractionEnabled = YES;
                        [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
                        [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        self.pubcommitTask.userInteractionEnabled = NO;
                    }else  if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
                            self.subcommitTask.userInteractionEnabled = NO;
                            [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                            self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            [self.pubcommitTask setTitle:@"已完成" forState:UIControlStateNormal];
                            self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                            self.pubcommitTask.userInteractionEnabled = NO;
                    }else  if ([[self.dic valueForKey:@"status"] isEqualToString:@"AUDIT"]) {
                        self.subcommitTask.userInteractionEnabled = NO;
                        [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        [self.pubcommitTask setTitle:@"审核中" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        self.pubcommitTask.userInteractionEnabled = NO;
                    }else  if ([[self.dic valueForKey:@"status"] isEqualToString:@"FAILED"]) {
                        self.subcommitTask.userInteractionEnabled = NO;
                        [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        [self.pubcommitTask setTitle:@"未达标" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        self.pubcommitTask.userInteractionEnabled = NO;
                    }else  if ([[self.dic valueForKey:@"status"] isEqualToString:@"INVALID"]) {
                        self.subcommitTask.userInteractionEnabled = NO;
                        [self.subcommitTask setTitle:@"已领取" forState:UIControlStateNormal];
                        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
                        [self.pubcommitTask setTitle:@"已失效" forState:UIControlStateNormal];
                        self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
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
            }else{
                [MBProgressHUD hideHUD];
            }
            if (error) {
                [MBProgressHUD hideHUD];
                //                KLToast(@"加载失败，请重试");
            }
            
        }];
    
    
    
    
}
- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];//该透明色设置不会影响子视图
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"left_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 25 + kTopHeight - 64, 33, 33);
        backButton.adjustsImageWhenHighlighted = NO;
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        self.headImgview = [[UIImageView alloc]init];
//        self.headImgview.backgroundColor = kRandomColor;
        [_naviView addSubview:self.headImgview];
        [self.headImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backButton.mas_right).offset(kRealValue(0));
            make.centerY.equalTo(backButton.mas_centerY).offset(0);
            make.width.mas_equalTo(kRealValue(32));
             make.height.mas_equalTo(kRealValue(32));
        }];
        self.headImgview.layer.masksToBounds = YES;
        self.headImgview.layer.cornerRadius = kRealValue(16);
       
        
        self.headnameview = [[UILabel alloc]init];
        self.headnameview.textColor = KColorFromRGB(0x222222);
        self.headnameview.textAlignment = NSTextAlignmentLeft;
//        self.headnameview.text = @"lallala";
        self.headnameview.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [_naviView addSubview:self.headnameview];
        [self.headnameview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgview.mas_top).offset(0);
            make.left.equalTo(self.headImgview.mas_right).offset(kRealValue(13));
        }];
        
        self.headcodeview = [[UILabel alloc]init];
        self.headcodeview.textColor = KColorFromRGB(0x666666);
        self.headcodeview.textAlignment = NSTextAlignmentLeft;
//        self.headcodeview.text = @"id:1234456789";
        self.headcodeview.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        [_naviView addSubview:self.headcodeview];
        [self.headcodeview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImgview.mas_bottom).offset(0);
            make.left.equalTo(self.headImgview.mas_right).offset(kRealValue(13));
        }];
        
        self.headtimeview = [[UILabel alloc]init];
        self.headtimeview.textColor = KColorFromRGB(0x222222);
        self.headtimeview.textAlignment = NSTextAlignmentCenter;
        NSDate *date=[NSDate date];
        NSDateFormatter *format1=[[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"yyyyMMdd"];
        NSString *dateStr;
        dateStr=[format1 stringFromDate:date];
        NSLog(@"%@",dateStr);
        self.headtimeview.text =[NSString stringWithFormat:@"Date:%@",dateStr];
        self.headtimeview.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        [_naviView addSubview:self.headtimeview];
        [self.headtimeview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImgview.mas_centerY).offset(0);
            make.right.equalTo(_naviView.mas_right).offset(-kRealValue(16));
            
        }];
        
        
    }
    return _naviView;
}
-(void)creatview
{
   
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.tableView];
    
    self.subcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subcommitTask setTitle:@"领取任务" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
    self.subcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.subcommitTask.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(105) - kBottomHeight, kRealValue(343), kRealValue(41));
    self.subcommitTask.layer.cornerRadius= kRealValue(20);
    [self.subcommitTask addTarget:self action:@selector(subcomitAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subcommitTask];
    
    
    self.pubcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pubcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
    self.pubcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
    self.pubcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.pubcommitTask.titleLabel.textColor = KColorFromRGB(0x6e6e6e);
    self.pubcommitTask.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(55) - kBottomHeight, kRealValue(343), kRealValue(41));
    self.pubcommitTask.layer.cornerRadius= kRealValue(20);
    [self.pubcommitTask addTarget:self action:@selector(pubcommitAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.pubcommitTask];
    
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(void)subcomitAct
{
    if (klObjectisEmpty(self.dic)) {
        return;
    }
    if ([GVUserDefaults standardUserDefaults].accessToken) {
      
        // 判断用户角色
        if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"SVIP"]) {
            if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                NSString *str = @"";
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                    str =@"最高等级会员才可以做的任务被你发现啦~你还差一点点就可以领取了，快去升级吧！";
                }
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                    str =@"最高等级会员才可以做的任务被你发现啦~奖励是不是很诱人，想要就去升级吧！";
                }
                
                
                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                    
                } rightAct:^{
                    HSChargeController *vc = [[HSChargeController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }];
                
                return;
                
                
                
            }
        }
        if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"VIP"]) {
            if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] &&
                ![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                NSString *str = @"";
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                    str =@"银勺专享任务您暂时还无法领取。别伤心，一键升级就可以做任务得奖励哦！";
                }
                
                
                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                    
                } rightAct:^{
                    HSChargeController *vc = [[HSChargeController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }];
                return ;
            }
        }
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            NSString *power =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"power"]];
            if ([power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"哎呀，友力值余额不足无法领取任务啦！ 解决办法：①邀友获赠②友力值商城购买" message:@"" leftbutton:@"取消" rightbutton:@"获取友力值" leftAct:^{
                   
                } rightAct:^{
                    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                return ;
            }else{
                
            }
        }else{
            
        }
        
        
            [MBProgressHUD showActivityMessageInWindow:@""];
            [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:[self.dic valueForKey:@"id"] taskCode:[self.dic valueForKey:@"taskType"] taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    [MBProgressHUD hideHUD];
                    KLToast(@"任务领取成功");
                    self.comeform = @"userlist";
//                    self.taskId= [NSString stringWithFormat:@"%@",response[@"data"]];
                    [self getdata];
                    NSString *content = [self.dic valueForKey:@"taskUrl"];
                    if (!klStringisEmpty(content)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:content]];
                    }
                   
                    
                    
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshTask object:nil userInfo:response[@"data"]];
                    
                }else{
                    [MBProgressHUD hideHUD];
                    if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20501" ]) {
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去邀请" leftAct:^{
                            
                        } rightAct:^{
                            HSQRcodeVC *vc =[[HSQRcodeVC alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                        
                        
                    }
                    else if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20500" ]) {
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                        
                        
                    }else{
                        KLToast(response[@"message"])
                    }
                   
                    
                    
                    
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
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight,kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
          [_tableView registerClass:[HSWebviewCell class] forCellReuseIdentifier:NSStringFromClass([HSWebviewCell class])];
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
    [MBProgressHUD hideHUD];
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
     if (!klObjectisEmpty(self.dic)) {
         if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]) {
             return 1;
         }
         return 5;
     }
   
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!klObjectisEmpty(self.dic)) {
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"HTML"]) {
            return kScreenHeight - kTopHeight;
        }else{
     
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                return kRealValue(182);
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
                    return  [[self.dic valueForKey:@"introduce"] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)] width:kRealValue(343)] + kRealValue(30);;
                }else{
                    return kRealValue(270);
                }
                
                return kRealValue(230);
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                return kRealValue(40);
            }
            if (indexPath.row == 1) {
                
                if (!klObjectisEmpty(self.dic)) {
                    return  [[self.dic valueForKey:@"detail"] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)] width:kRealValue(343)] + kRealValue(30);;
                }else{
                    return kRealValue(270);
                }
                
                return kRealValue(230);
            }
        }
        
        if (indexPath.section == 4) {
            if (indexPath.row == 0) {
                return kRealValue(40);
            }
            if (indexPath.row == 1) {
                if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]) {
                    NSInteger btnoffset = 10;
                    NSInteger pading = kRealValue(10);
                    for (int i = 0; i < self.PicArr.count; i++) {
                        
                        MHProductPicModel *model = [self.PicArr objectAtIndex:i];
                        btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
                    }
                    return kRealValue(btnoffset);
                }
                
                return kRealValue(500);
            }
        }
            
        }
    }
    
    return 0;
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (!klObjectisEmpty(self.dic)) {
   
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]) {
        return 1;
    }else{
        
        if (section == 0) {
            if (!klObjectisEmpty(self.dic)) {
                return 1;
            }
            return 1;
        }
        if (section == 1) {
            if (!klObjectisEmpty(self.dic)) {
                return 0;
            }
        }
        if (section == 2) {
            if (!klObjectisEmpty(self.dic)) {
                if (!klStringisEmpty([self.dic valueForKey:@"introduce"])) {
                    return 2;
                }
                
                return 0;
            }
            return 0;
        }
        if (section == 3) {
            if (!klObjectisEmpty(self.dic)) {
                if (klStringisEmpty([self.dic valueForKey:@"detail"])) {
                    return 0;
                }
                return 2;
            }
            return 0;
        }
        if (section == 4) {
           
            if (self.PicArr.count > 0) {
                return 2;
            }
            
            return 0;
            
        }
    }
   }
  
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    if (section == 1) {
        return CGFLOAT_MIN;
    }
    return kRealValue(5);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = KColorFromRGB(0xF1F3F4);
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //F1F3F4
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = KColorFromRGB(0xF1F3F4);
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"HTML"]) {
        HSWebviewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWebviewCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        NSString *str;
        if (self.PicArr.count > 0) {
            MHProductPicModel *model = [self.PicArr objectAtIndex:0];
            str =model.filePath;
        }
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
            request.timeoutInterval = 20;
            request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            [cell.webView loadRequest:request];
            return cell;
        }else{
            NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
            
            [cell.webView loadHTMLString:[headerString stringByAppendingString:str] baseURL:nil];
            
            return cell;
        }
        
    }else{
   
    if (indexPath.section == 0) {

        MHTaskDetailHeadTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadTitleCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (!klObjectisEmpty(self.dic)) {
            NSString *str1 =klStringisEmpty([self.dic valueForKey:@"taskName"]) ==1?@"":[self.dic valueForKey:@"taskName"];
            cell.taskname.text =   [NSString stringWithFormat:@"%@",str1];
            cell.tasknum.text = klStringisEmpty([self.dic valueForKey:@"integral"]) ==1?@"":[NSString stringWithFormat:@"%@火币",[self.dic valueForKey:@"integral"]];
//
            
            
            NSString *strr1 = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"remainCount"]];
            NSString *strr2 = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"taskCount"]];
            if (!klStringisEmpty(strr2) && !klStringisEmpty(str1)) {
                NSString *Str = [NSString stringWithFormat:@"%@/%@",[self.dic valueForKey:@"remainCount"],[self.dic valueForKey:@"taskCount"]];
                NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
                [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0x999999) range:NSMakeRange(strr1.length+1,  strr2.length)];
                cell.tasktime.attributedText = attstring;
            }else{
                cell.tasktime.text =[NSString stringWithFormat:@"%@/%@",[self.dic valueForKey:@"remainCount"],[self.dic valueForKey:@"taskCount"]];
            }
           
            

            if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"ORD"]) {
                cell.tasklimit.text =@"无限制";
            }
            if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"VIP"]) {
                cell.tasklimit.text =@"仅银勺会员以上用户可参与";
            }
            if ([[self.dic valueForKey:@"taskType"] isEqualToString:@"SVIP"]) {
                cell.tasklimit.text =@"仅金勺会员以上用户可参与";
            }
            
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
            cell.headtitle.text = @"任务介绍";
            cell.self.savePic.hidden = YES;
            return cell;
        }
        MHTaskDetailDesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailDesCell class])];
       
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        if (!klObjectisEmpty(self.dic)) {
            cell.deslabel.text = klStringisEmpty([self.dic valueForKey:@"introduce"]) ==1?@"":[self.dic valueForKey:@"introduce"];
        }
        return cell;
        
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            
            MHTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.headtitle.text = @"任务文案";
            cell.savePic.hidden = NO;
            cell.savePic.text =@"复制" ;
            cell.SaveAct = ^{
                UIPasteboard *copy = [UIPasteboard generalPasteboard];
                [copy setString: [self.dic valueForKey:@"detail"]];
                if (copy == nil || [ [self.dic valueForKey:@"detail"] isEqualToString:@""]==YES)
                {
                    
                    KLToast(@"复制失败")
                    
                    
                }else{
                    KLToast(@"复制成功")
                    
                    
                }
                
            };
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
    
    
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            
            MHTaskDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
                cell.headtitle.text = @"任务图片";
            }
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                cell.headtitle.text = @"任务视频";
            }
             cell.savePic.text =@"保存" ;
            cell.savePic.hidden = NO;
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
            self.ImagesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailImagesCell class])];
            self.ImagesCell .selectionStyle= UITableViewCellSelectionStyleNone;
            self.ImagesCell .PictureArr = self.PicArr;
            return self.ImagesCell ;
            
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
    }
    
    return nil;
    
    
}

-(void)save
{
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@""]) {
        
        for (int i = 0; i < self.PicArr.count; i++) {
            
//            MHProductPicModel *model = [self.PicArr objectAtIndex:i];
//            // 先生成水印照片
//            NSArray *array = [model.filePath  componentsSeparatedByString:@"?"];
//            MHLog(@"%@",array[0]);
//
            NSDate *date=[NSDate date];
            NSDateFormatter *format1=[[NSDateFormatter alloc] init];
            [format1 setDateFormat:@"yyyyMMdd"];
            NSString *dateStr;
            dateStr=[format1 stringFromDate:date];
            NSLog(@"%@",dateStr);
//
            NSString *str = [NSString stringWithFormat:@"ID:%@  Date:%@",[self.userDic valueForKey:@"userCode"],dateStr];
//
//            NSString *basestr = [NSString stringWithFormat:@"x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,size_47,text_%@,color_000000,g_north,x_20,y_20",[str base64EncodedString]];
//            NSString *fishstr = [NSString stringWithFormat:@"%@?%@",array[0],basestr];
//            MHLog(@"%@",fishstr);
//            [self toSaveImage:fishstr];
            
            // 设置绘制图片的大小
            
            UIImageView *saveView = [[UIImageView alloc]init];
            saveView= [self.ImagesCell viewWithTag:20190+i];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(0), kScreenWidth, kRealValue(50))];
            label.text = str;
            label.tag = 20290+i;
            label.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(21)];
            label.textAlignment =NSTextAlignmentCenter;
            label.backgroundColor = KColorFromRGB(0xffffff);
            [saveView addSubview:label];
          
            UIGraphicsBeginImageContextWithOptions(saveView.bounds.size, NO, 0.0);
            // 绘制图片
            [saveView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
           
            // 保存图片到相册   如果需要获取保存成功的事件第二和第三个参数需要设置响应对象和方法，该方法为固定格式。
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            UILabel *labelold = [saveView viewWithTag:20290+i];
            [labelold removeFromSuperview];
            
            
            
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        [MBProgressHUD showActivityMessageInWindow:@"正在保存"];
    });
    
  
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
