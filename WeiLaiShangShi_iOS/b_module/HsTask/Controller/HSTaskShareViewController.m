//
//  HSTaskShareViewController.m
//  HSKD
//
//  Created by yuhao on 2019/4/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskShareViewController.h"
#import "SJTableViewCell.h"
#import "SJVideoPlayer.h"
#import "MHTaskDetailModel.h"
#import "MHProductPicModel.h"
#import "AliyunOSSDemo.h"
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
#import "MHTaskDetailImagesCell.h"
#import "HSWebviewCell.h"
#import "MHLoginViewController.h"
#import "HSFriendShopViewController.h"
#import "HSChargeController.h"
#import "ZJAnimationPopView.h"
#import "HSCircle.h"
#import "HSBannerModel.h"
#import "HSDownloadModel.h"
#import "HSQRcodeVC.h"
@interface HSTaskShareViewController ()<UITableViewDelegate,UITableViewDataSource,SJPlayerAutoplayDelegate,scrollviewdelege>
@property(nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) SJVideoPlayer *player;
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *subcommitTask;
@property (nonatomic, strong)NSMutableDictionary *userDic;
@property (nonatomic, strong)ZJAnimationPopView *qiandaoPopView3;
@property (nonatomic, strong)ZJAnimationPopView *MoneyPopView;
@property(nonatomic, strong)UIView *bottomview;
@property (nonatomic, strong)dispatch_source_t timer;
@property(assign,nonatomic)CGFloat time;
@property(assign,nonatomic)CGFloat time2;
@property (nonatomic, assign)BOOL downtaskTake;
@property (nonatomic, assign)BOOL IsStop;
@property (nonatomic, assign)BOOL IsShowTimer;
@property (nonatomic, strong) NSMutableArray *shareArr;
@property (nonatomic, assign)CGFloat stopLinetime;
@end

@implementation HSTaskShareViewController

- (NSString *)filePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"course.plist"];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
   
}
-(void)someMethod
{
    MHLog(@"通知方法");
    [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {
        
        
        if (ValidResponseDict(response)) {
            
            
            //
            self.dic = [response valueForKey:@"data"];
            
          
            if ([[self.dic valueForKey:@"property"] isEqualToString:@"SHARE"]) {
                //分享
                [self getShareData];
                self.subcommitTask.hidden = NO;
                self.bottomview .hidden = NO;
              
                if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
                    
                 
                    [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                            [self.qiandaoPopView3 dismiss];
                            KLToast(response[@"message"]);
                            
                            [self showMoneyToast:response[@"data"] withtime:2];
                            [self getdata];
                        }else{
                            [self.qiandaoPopView3 dismiss];
                            
                            
                        }
                        if (error) {
                            [self.qiandaoPopView3 dismiss];
                            
                        }
                        
                    }];
                    
                    
                }
            }
            
            
            //            [MBProgressHUD hideHUD];
            [self.tableView reloadData];
            
           
        }
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";
   
     self.stopLinetime = 5;
     self.PicArr = [NSMutableArray array];
     self.dic = [NSMutableDictionary dictionary];
    self.downtaskTake = NO;
    if (self.IsshowTop) {
        self.fd_prefersNavigationBarHidden = YES;
    }
    
//     [self creatview];
     [self getdata];
    [self getUserInfo];
    // Do any additional setup after loading the view.
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
-(void)creatview
{
    
    [self.view addSubview:self.tableView];
    
    
     self.bottomview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kScreenHeight - kRealValue(56) - kBottomHeight-kTopHeight, kScreenWidth, kRealValue(56)+ kBottomHeight)];
    self.bottomview .backgroundColor = [UIColor whiteColor];
    self.bottomview .hidden = YES;
    [self.view addSubview:self.bottomview ];
    
    
    self.subcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subcommitTask setTitle:@"分享领取奖励" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
    self.subcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.subcommitTask.frame = CGRectMake(kRealValue(16), kRealValue(7),kRealValue(343), kRealValue(42));
    self.subcommitTask.layer.cornerRadius= kRealValue(21);
    [self.subcommitTask addTarget:self action:@selector(subcomitAct) forControlEvents:UIControlEventTouchUpInside];
    self.subcommitTask.hidden = YES;
    [self.bottomview  addSubview:self.subcommitTask];
    
    
   
    
}
-(void)createBottom:(NSString *)str
{
    self.bottomview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kScreenHeight - kRealValue(66) , kScreenWidth, kRealValue(66)+ kBottomHeight)];
    self.bottomview .backgroundColor = [UIColor whiteColor];
    self.bottomview .hidden = YES;
    [self.view addSubview:self.bottomview ];
    
    
    self.subcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subcommitTask setTitle:str forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
    self.subcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.subcommitTask.frame = CGRectMake(kRealValue(16), kRealValue(7),kRealValue(343), kRealValue(42));
    self.subcommitTask.layer.cornerRadius= kRealValue(16);
    [self.subcommitTask addTarget:self action:@selector(subcomitAct) forControlEvents:UIControlEventTouchUpInside];
    self.subcommitTask.hidden = YES;
    [self.bottomview  addSubview:self.subcommitTask];
}
-(void)subcomitAct
{
    if (klObjectisEmpty(self.dic)) {
        return;
    }
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        //判断是分享任务还是领取任务
        //任务状态判断
        if ([[self.dic valueForKey:@"property"] isEqualToString:@"SHARE"]) {
            NSString *statu = [self.dic valueForKey:@"status"];
            if ([statu isEqualToString:@"ACTIVE"]) {
              //吊起分享
                [self presentshareAlert];
                  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(someMethod) name:UIApplicationDidBecomeActiveNotification object:nil];
                
            }else if ([statu isEqualToString:@"PENDING"]){
              //领取任务
                [self gettask];
                
            }else if ([statu isEqualToString:@"DONE"]){
               
              //
               
                
            }else if ([statu isEqualToString:@"AUDIT"]){
                
             
                
            }else if ([statu isEqualToString:@"FAILED"]){
                
               
                
            }else if ([statu isEqualToString:@"INVALID"]){
                
              
                
            }
        }
        if ([[self.dic valueForKey:@"property"] isEqualToString:@"DOWNLOAD"]) {
            NSString *statu = [self.dic valueForKey:@"status"];
            if ([statu isEqualToString:@"ACTIVE"]) {
                //进行中
              
                
                
            }else if ([statu isEqualToString:@"PENDING"]){
                //领取任务
                [self getDownloadtask];
                
            }else if ([statu isEqualToString:@"DONE"]){
                
                //
                
                
            }else if ([statu isEqualToString:@"AUDIT"]){
                
                
                
            }else if ([statu isEqualToString:@"FAILED"]){
                
                
                
            }else if ([statu isEqualToString:@"INVALID"]){
                
                
                
            }
        }
        
        
        
        
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
    
    
}
-(void)getreadTask
{
    if (![GVUserDefaults standardUserDefaults].accessToken) {
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
        return;
    }
    // 判断用户角色
    // 判断用户角色
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
    //根据状态判断是否要领取
    //只有pending 和 进行中 才点击
    //pengding 要领取
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            NSString *power =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"power"]];
            if ([power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"哎呀，友力值余额不足无法领取任务啦！ 解决办法：①邀友获赠②友力值商城购买" message:@"" leftbutton:@"取消" rightbutton:@"获取友力值" leftAct:^{
                 
                } rightAct:^{
                    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];;
                return ;
            }else{
                
            }
        }else{
            
        }
        

        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId taskCode:[self.dic valueForKey:@"taskType"] taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                //            KLToast(@"任务领取成功");
               
                [self getdata1];
                NSString *str  = [self.dic valueForKey:@"remark"];
                if (klStringisEmpty(str)) {
                    self.time = [str integerValue];
                     self.time2 = [str integerValue];
                }else{
                    self.time = 20;
                    self.time2 = 20;
                    
                }
                [self createtimeview2];
                [self createtimer];
                
                
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
    }
    //进行中
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
        
        //展示 分享弹框
        [self presentshareAlert];
    }
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
}
-(void)gettask
{
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
    //根据状态判断是否要领取
    //只有pending 和 进行中 才点击
    //pengding 要领取
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            NSString *power =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"power"]];
            if ([power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"哎呀，友力值余额不足无法领取任务啦！ 解决办法：①邀友获赠②友力值商城购买" message:@"" leftbutton:@"取消" rightbutton:@"获取友力值" leftAct:^{
                
                } rightAct:^{
                    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];;
                return ;
            }else{
                
            }
        }else{
            
        }
        
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId taskCode:[self.dic valueForKey:@"taskType"] taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                //            KLToast(@"任务领取成功");
                
                 //展示 分享弹框
                [self getdata];
                [self presentshareAlert];
               
                
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(someMethod) name:UIApplicationDidBecomeActiveNotification object:nil];
                
                
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
    }
    //进行中
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
       
        //展示 分享弹框
         [self presentshareAlert];
    }
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
}
-(NSString *)currentdateInterval{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970])];
    return timeSp;
    
}


-(void)getDownloadtask
{
    // 判断用户角色
    // 判断用户角色
    // 判断用户角色
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
    //根据状态判断是否要领取
    //只有pending 和 进行中 才点击
    //pengding 要领取
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"PENDING"]) {
        
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
        
//        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId taskCode:[self.dic valueForKey:@"taskType"] taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                //            KLToast(@"任务领取成功");
                //
                self.downtaskTake = YES;
                [self getdata];
                HSDownloadModel *model = [[HSDownloadModel alloc]init];
                model.taskid = self.taskId;
                model.usertaskId = @"234";
                model.user =  [self.userDic valueForKey:@"phone"];
                model.date = [self currentdateInterval];
                NSMutableArray *Arr = [NSMutableArray array];
                [Arr addObject:model];
                [NSKeyedArchiver archiveRootObject:Arr toFile:[self filePath]];
                
              
               
               
                
                
//


                
                
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
    }
    //进行中
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
        
       
       
    }
    if ([[self.dic valueForKey:@"status"] isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
}
    


-(void)CloseshareAct
{
    [self.qiandaoPopView3 dismiss];
    
}
-(void)presentshareAlert
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgview.backgroundColor = KClearColor;
    
    
    UIView *layview = [[UIView alloc]init];
    layview.backgroundColor = KColorFromRGB(0xffffff);
//    layview.layer.cornerRadius = 5;
    [bgview addSubview:layview];
    [layview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_top).offset(kScreenHeight - kRealValue(155));
        make.centerY.equalTo(bgview.mas_centerY).offset(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kRealValue(155));
    }];
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(110))];
    topview.backgroundColor= KColorFromRGB(0xF2F2F2);
    [layview addSubview:topview];
    NSArray *imageArr = @[@"组18",@"组17",@"组19",@"组20",@"组21"];
    NSArray *titleArr = @[@"微博",@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间"];
    
    for (int i = 0; i < self.shareArr.count; i++) {
        HSBannerModel *model = [self.shareArr objectAtIndex:i];
        //        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn1.tag = i;
        //        [btn1 addTarget:self action:@selector(shareActToOther:)
        //       forControlEvents:UIControlEventTouchUpInside];
        //        btn1.frame = CGRectMake(kScreenWidth/5 *i, kRealValue(22),kScreenWidth/5, kRealValue(74));
        //        [btn1 setTitle:model.name forState:UIControlStateNormal];
        //        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.sourceUrl]]];
        //        [btn1 setImage:[self originImage:img scaleToSize:CGSizeMake(kRealValue(43), kRealValue(43))] forState:0];
        //        [btn1 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        //        btn1.titleLabel.font = [UIFont systemFontOfSize:kRealValue(13)];
        //        [self initButton2:btn1];
        //        [topview  addSubview:btn1];
        //        NSInteger pading = kRealValue(30);
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/5*i, kRealValue(22), kScreenWidth/5, kRealValue(74))];
        view.tag = i;
        view.userInteractionEnabled= YES;
        [topview addSubview:view];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(43), kRealValue(43))];
        image.userInteractionEnabled = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]];
        [view addSubview:image];
        image.centerX = kScreenWidth/10;

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(53), kScreenWidth/5, kRealValue(20))];
        label.userInteractionEnabled = YES;
        label.font =[UIFont systemFontOfSize:kRealValue(13)];
        label.textColor =[UIColor colorWithHexString:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%@",model.name];
        [view addSubview:label];
        
        
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareActToOther:)];
        [view addGestureRecognizer:tapAct];
        
        
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kRealValue(0), kRealValue(110), kScreenWidth, kRealValue(45));
    [btn addTarget:self action:@selector(CloseshareAct) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kRealValue(13)];
    [layview  addSubview:btn];
    
    
    
    self.qiandaoPopView3 = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleNO dismissStyle:ZJAnimationDismissStyleDropToBottom];
    // 3.2 显示时背景的透明度
    //    self.qiandaoPopView3.popBGAlpha = 0.3f;
    // 3.3 显示时是否监听屏幕旋转
    self.qiandaoPopView3.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.qiandaoPopView3.popAnimationDuration = 0.2f;
    // 3.5 移除时动画时长
    self.qiandaoPopView3.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    self.qiandaoPopView3.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    self.qiandaoPopView3.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [self.qiandaoPopView3 pop];
    
    
}
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    CGSize size = CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)shareActToOther:(UITapGestureRecognizer *)sender
{
    if (self.shareArr.count > 0) {
        HSBannerModel *model = [self.shareArr objectAtIndex:sender.view.tag];
        
        
        if ([model.name isEqualToString:@"微博"]) {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_Sina title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:[self.dic valueForKey:@"taskUrl"] currentViewController:self success:^{
                    
//                    [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                        if (ValidResponseDict(response)) {
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//                            [self startRewardAmited:response[@"data"]];
//                            [self getdata];
//                        }else{
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//
//                        }
//                        if (error) {
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//                        }
//
//                    }];
                    
                    
                } fail:^{
                    
                    
                }];
            }else{
                KLToast(@"未安装微博，请先下载应用");
            }
       
        }
        if ([model.name isEqualToString:@"微信"]) {
            
             if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                 [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_WechatSession title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:[self.dic valueForKey:@"taskUrl"] currentViewController:self success:^{
                     
//                     [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                         if (ValidResponseDict(response)) {
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//                              [self startRewardAmited:response[@"data"]];
//                             [self getdata];
//                         }else{
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//
//                         }
//                         if (error) {
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//                         }
//
//                     }];
                     
                     
                 } fail:^{
                     
                     
                 }];
             }else{
                 KLToast(@"微信未安装，请先下载应用");
             }
            
        }
        if ([model.name isEqualToString:@"朋友圈"]) {
              if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                  
                  [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:[self.dic valueForKey:@"taskUrl"] currentViewController:self success:^{
                      
//                      [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                          if (ValidResponseDict(response)) {
//                              [self.qiandaoPopView3 dismiss];
////                              KLToast(response[@"message"]);
//                               [self startRewardAmited:response[@"data"]];
//                              [self getdata];
//                          }else{
//                              [self.qiandaoPopView3 dismiss];
////                              KLToast(response[@"message"]);
//
//                          }
//                          if (error) {
//                              [self.qiandaoPopView3 dismiss];
////                              KLToast(response[@"message"]);
//                          }
//
//                      }];
                      
                      
                  } fail:^{
                      
                      
                  }];
              }else{
                  KLToast(@"微信未安装，请先安装应用");
              }
            
        }
        if ([model.name isEqualToString:@"QQ"]) {
            
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                
                [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_QQ title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:[self.dic valueForKey:@"taskUrl"] currentViewController:self success:^{
                    
//                    [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                        if (ValidResponseDict(response)) {
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//                            [self startRewardAmited:response[@"data"]];
//                            [self getdata];
//                        }else{
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//
//                        }
//                        if (error) {
//                            [self.qiandaoPopView3 dismiss];
////                            KLToast(response[@"message"]);
//                        }
//
//                    }];
                    
                    
                } fail:^{
                    
                    
                }];
            }else{
                  KLToast(@"QQ未安装，请先安装应用");
            }
   
        }
        if ([model.name isEqualToString:@"QQ空间"]) {
             if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                 [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_Qzone title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:[self.dic valueForKey:@"taskUrl"] currentViewController:self success:^{
                     
//                     [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                         if (ValidResponseDict(response)) {
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//                             [self startRewardAmited:response[@"data"]];
//                             [self getdata];
//                         }else{
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//
//                         }
//                         if (error) {
//                             [self.qiandaoPopView3 dismiss];
////                             KLToast(response[@"message"]);
//                         }
//
//                     }];
                     
                     
                 } fail:^{
                     
                     
                 }];
             }else{
                  KLToast(@"QQ未安装，请先安装应用");
             }
            ;
        }
    }
    
   
    
}

//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)btn{
    float  spacing = kRealValue(10);//图片和文字的上下间距
    CGSize imageSize = CGSizeMake(43, 43);
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
-(void)initButton2:(UIButton*)btn{
    float  spacing = kRealValue(15);//图片和文字的上下间距
    CGSize imageSize = CGSizeMake(kRealValue(43), kRealValue(43));
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


-(UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[HSWebviewCell class] forCellReuseIdentifier:NSStringFromClass([HSWebviewCell class])];
        [_tableView registerClass:[MHTaskDetailImagesCell class] forCellReuseIdentifier:NSStringFromClass([MHTaskDetailImagesCell class])];
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
-(void)getdata1
{
    [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {

        if (ValidResponseDict(response)) {

            self.dic = [response valueForKey:@"data"];
        }
        
    }];
}

-(void)getdata{
    
//    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:self.taskId completionBlock:^(NSDictionary *response, NSError *error) {
        
        
        if (ValidResponseDict(response)) {
            
            
            //
            self.dic = [response valueForKey:@"data"];
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                [self createVideo];
                
                if ([[self.dic valueForKey:@"property"] isEqualToString:@"SHARE"]) {
                    [self createBottom:@"分享领取奖励"];
                }
                if ([[self.dic valueForKey:@"property"] isEqualToString:@"DOWNLOAD"]) {
                    [self createBottom:@"下载领取奖励"];
                }
                
            }
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]) {
                self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                [self creatview];
            }
            if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"HTML"]) {
                self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"url"]];
                [self creatview];
            }
            if ([[self.dic valueForKey:@"property"] isEqualToString:@"SHARE"]) {
                //分享
                 [self getShareData];
                self.subcommitTask.hidden = NO;
                self.bottomview .hidden = NO;
                [self creteBtnstauteWithShare:[self.dic valueForKey:@"status"]];
                
            }
            if ([[self.dic valueForKey:@"property"] isEqualToString:@"DOWNLOAD"]) {
                //下载
                self.bottomview .hidden = NO;
                 self.subcommitTask.hidden = NO;
                [self creteBtnstauteWithDownload:[self.dic valueForKey:@"status"]];
                
                
            }
            if ([[self.dic valueForKey:@"property"] isEqualToString:@"READ"]) {
                //下载
                self.bottomview .hidden = YES;
                self.subcommitTask.hidden = YES;

                [self creteBtnstauteWithRead:[self.dic valueForKey:@"status"]];
            }
            
            
//            [MBProgressHUD hideHUD];
            [self.tableView reloadData];
            
            if (self.downtaskTake == YES) {
                self.time = 30 +  (arc4random() % 15);
                if (!self.timer) {
                   
                    [self createtimer];
                    
                }
               
             
                
            }
            
        }else{
            if (self.downtaskTake == YES) {
                self.time = 30 +  (arc4random() % 15);
                if (!self.timer) {
                    [self createtimer];
                }
              
               
                
            }
            [MBProgressHUD hideHUD];
        }
        if (error) {
            if (self.downtaskTake == YES) {
                self.time = 30 +  (arc4random() % 15);
                if (!self.timer) {
                   
                    [self createtimer];
                }
                
                
                
            }
            [MBProgressHUD hideHUD];
            //                KLToast(@"加载失败，请重试");
        }
        
    }];
    
    
    
    
}
-(void)getShareData
{
    [[MHUserService sharedInstance]initWithFirstPageComponent:@"7" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *bannerArr = response[@"data"];
            [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"type"] isEqualToString:@"BANNER"]) {
                    NSMutableArray *picArr = obj[@"result"];
                    self.shareArr = [HSBannerModel baseModelWithArr:picArr];
                    
                }
            }];
        }
    }];
}
-(void)createtimeview2
{
    self.bgviewtime = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(70), kRealValue(530)-kTopHeight, kRealValue(60), kRealValue(60))];
    self.bgviewtime.layer.cornerRadius = kRealValue(30);
    self.bgviewtime.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgviewtime];
    
    
    self.pathView =[[HSCircle alloc]initWithFrame:CGRectMake(kRealValue(5), kRealValue(5), self.bgviewtime.frame.size.width - kRealValue(10), self.bgviewtime.frame.size.width - kRealValue(10)) lineWidth:kRealValue(5)];
    //    self.pathView.center = self.window.center;
    
    self.pathView.backgroundColor =[UIColor clearColor];
    [self.bgviewtime addSubview:self.pathView];
    
    
    
    self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(30), kRealValue(30))];
    self.moneyImage.image = kGetImage(@"sm_hs_icon");
    [self.bgviewtime addSubview:self.moneyImage];
    
    self.SmallmoneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(14), kRealValue(25), kRealValue(0), kRealValue(0))];
    //    self.SmallmoneyImage.image = kGetImage(@"all_gold_animation");
    self.SmallmoneyImage.hidden = YES;
    [self.bgviewtime addSubview:self.SmallmoneyImage];
    
    
    self.moneylabel = [[UILabel alloc]init];
    self.moneylabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    self.moneylabel.textColor = KColorFromRGB(0xFFAF12);
    self.moneylabel.text = @"+10";
    self.moneylabel.hidden = YES;
    [self.bgviewtime addSubview:self.moneylabel];
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgviewtime.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.bgviewtime.mas_centerY).offset(kRealValue(0));
    }];
    
}
-(void)backAct
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createVideo
{
    //    self.title = @"视频详情";
    self.fd_prefersNavigationBarHidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    if (!_player) {
        _player = [SJVideoPlayer player];
        [self.view addSubview:_player.view];
    }
    // create a player of the default type
    
  
    
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.leading.trailing.offset(0);
        make.height.mas_equalTo(kScreenHeight);
    }];
    if (self.PicArr.count > 0) {
        MHProductPicModel *model = [self.PicArr objectAtIndex:0];
        _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:model.filePath]];
        
    }
   ;
   
    
    _player.URLAsset.title =@"";
    _player.URLAsset.alwaysShowTitle = NO;
    _player.hideBackButtonWhenOrientationIsPortrait = YES;
    _player.pausedToKeepAppearState = YES;
    _player.generatePreviewImages = NO;
    _player.enableFilmEditing = NO;
    _player.filmEditingConfig.saveResultToAlbumWhenExportSuccess = YES;
    _player.resumePlaybackWhenAppDidEnterForeground = NO;
    _player.disabledGestures = SJPlayerDisabledGestures_Pan_H;
    if (isiPhoneX) {
        if (self.PicArr.count > 0) {
            MHProductPicModel *model = [self.PicArr objectAtIndex:0];
            CGFloat a = [[NSString stringWithFormat:@"%@",model.height] floatValue];
            CGFloat b = [[NSString stringWithFormat:@"%@",model.width] floatValue];
            if (a/b>1.5) {
                _player.videoGravity = AVLayerVideoGravityResizeAspectFill;
            }
          
        }
       
        
    }
    SJVideoPlayer.update(^(SJVideoPlayerSettings * _Nonnull commonSettings) {
        commonSettings.progress_trackColor = KColorFromRGB(0xffffff);
        commonSettings.progress_traceColor = KColorFromRGB(0xEA5520);
        
        
    });
    kWeakSelf(self);
    _player.playStatusDidChangeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull videoPlayer) {
        if (videoPlayer.playStatus  ==SJVideoPlayerPlayStatusPaused) {
            if (videoPlayer.pausedReason == SJVideoPlayerPausedReasonPause) {
                //停止计时器方法s
                
                if (weakself.timer) {
                    dispatch_source_cancel(weakself.timer);
                    weakself.IsStop = YES;
                }
                
            }
        }
        if (videoPlayer.playStatus ==SJVideoPlayerPlayStatusPlaying) {
            
            if (weakself.IsStop) {
                [weakself createtimer];
            }
            
        }
    };
    //    SJEdgeControlButtonItem *titleItem = [_player.defaultEdgeControlLayer.topAdapter itemForTag:SJEdgeControlLayerTopItem_Title];
    
#pragma mark
    
   
    
    
    [self.view addSubview:self.titlelabel];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(kRealValue(-150));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(12));
        make.width.mas_equalTo(kRealValue(356));
        
    }];
    
    
    if (!klStringisEmpty([self.dic valueForKey: @"title"])) {
        self.titlelabel.text =[self.dic valueForKey: @"title"];
    }
    
    
    
    
    UIImageView *backimg = [[UIImageView alloc]init];
    backimg.image = kGetImage(@"back_icon");
    backimg.userInteractionEnabled = YES;
    [self.view addSubview:backimg];
    [backimg mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isiPhoneX) {
            make.top.equalTo(self.view.mas_top).with.offset(25 + kTopHeight - 64);
        }else{
            make.top.equalTo(self.view.mas_top).with.offset(25 + kTopHeight - 64);
        }
        
        make.left.equalTo(self.view.mas_left).offset(kRealValue(12));
    }];
    
    UITapGestureRecognizer *backActtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAct)];
    [backimg addGestureRecognizer:backActtap];
    
   
    

}

-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.textColor = KColorFromRGB(0xffffff);
        _titlelabel.numberOfLines = 2;
        _titlelabel.text = @"";
        _titlelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        
    }
    return  _titlelabel;
}

-(void)creteBtnstauteWithRead:(NSString *)statu
{
    if ([statu isEqualToString:@"ACTIVE"]) {
        
        NSString *str  = [self.dic valueForKey:@"remark"];
        if (!klStringisEmpty(str)) {
             self.time = [str integerValue];
            self.time2 = [str integerValue];
        }else{
             self.time = 20;
             self.time2 = 20;
            
        }
        [self createtimeview2];
        [self createtimer];
        
    }else if ([statu isEqualToString:@"PENDING"]){
        // 调用领取
    
        [self getreadTask];
       
        
    }else if ([statu isEqualToString:@"DONE"]){
        

        [self createtimeview2];
        self.pathView.progress = 1.0;
        self.moneylabel.textColor = KColorFromRGB(0xF96150);
        self.moneylabel.text = @"完成";
        self.moneyImage.hidden=YES;
        self.moneylabel.hidden=NO;
     
        
    }else if ([statu isEqualToString:@"AUDIT"]){
        
     
        
    }else if ([statu isEqualToString:@"FAILED"]){
        
      
        
    }else if ([statu isEqualToString:@"INVALID"]){
        
       
        
    }
}
-(void)creteBtnstauteWithShare:(NSString *)statu
{
    if ([statu isEqualToString:@"ACTIVE"]) {
    
    [self.subcommitTask setTitle:@"分享领取奖励" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
       
    }else if ([statu isEqualToString:@"PENDING"]){
        
    [self.subcommitTask setTitle:@"分享领取奖励" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
        
        
    }else if ([statu isEqualToString:@"DONE"]){
        
    [self.subcommitTask setTitle:@"已分享" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"AUDIT"]){
        
    [self.subcommitTask setTitle:@"任务审核中" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"FAILED"]){
        
    [self.subcommitTask setTitle:@"未达标" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"INVALID"]){
    
    [self.subcommitTask setTitle:@"已失效" forState:UIControlStateNormal];
    self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
    
    }else{
        [self.subcommitTask setTitle:@"分享领取奖励" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
    }
}
#pragma mark 计时器方法
-(void)createtimer
{
    
    kWeakSelf(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //开始的时间
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC);
    //间隔的时间
    uint64_t interval = 0.1 * NSEC_PER_SEC;
    dispatch_source_set_timer(_timer,startTime,interval, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(self.time<0){ //倒计时结束，关闭
            dispatch_source_cancel(weakself.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //取消计时器
                dispatch_cancel(weakself.timer);
                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                       
                       
                        [self startRewardAmited:response[@"data"]];
                        
                        if (![[self.dic valueForKey:@"property"] isEqualToString:@"READ"]) {
                            [self getdata];
                        }
                        
                        
                    }else{
                      
                        KLToast(response[@"message"]);
                        
                    }
                    if (error) {
                        [self.qiandaoPopView3 dismiss];
                        KLToast(response[@"message"]);
                    }
                    
                }];
                
            });
        }else{
            //            int minutes = timeout / 60;
        
         dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                NSInteger index =  self.time;
                 NSLog(@"timer called");
                if (self.downtaskTake == YES) {
                    self.downtaskTake = NO;
                    NSString *content = [self.dic valueForKey:@"taskUrl"];
                     NSDictionary *dic  = [self dictionaryWithJsonString:content];
                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dic valueForKey:@"ios"]]];
                }else{
                   
                    CGFloat singerproess = (CGFloat)1 /self.time2/10 ;
                    self.proess += singerproess;
                    self.pathView.progress = self.proess;
                }

               self.time= self.time - 0.1;
                 self.stopLinetime= self.stopLinetime-0.1;
                if (![[self.dic valueForKey:@"detailType"] isEqualToString:@"VIDEO"]) {
                    if (![[self.dic valueForKey:@"property"] isEqualToString:@"DOWNLOAD"]) {
                        if (self.stopLinetime < 0 ) {
                            //暂停计时器方法
                            if (self.time >0) {
                              dispatch_cancel(weakself.timer);
                            }
                          
                        }
                    }
                   
                }
            });
            
        }
    });
    //启动定时器
    dispatch_resume(_timer);
    
    
    
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
-(void)showMoneyToast:(NSString *)str withtime:(NSInteger )time
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgview.backgroundColor = KClearColor;
    
    
    UIView *layview = [[UIView alloc]init];
    layview.backgroundColor = KColorFromRGBA(0x000000, 0.5);
    layview.layer.cornerRadius = 5;
    [bgview addSubview:layview];
    [layview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgview.mas_centerX).offset(0);
        make.centerY.equalTo(bgview.mas_centerY).offset(0);
        make.width.mas_equalTo(kRealValue(130));
        make.height.mas_equalTo(kRealValue(145));
    }];
    
    UIImageView *layimg = [[UIImageView alloc]init];
    [layview addSubview:layimg];
    layimg.image = kGetImage(@"组14");
    [layimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(layview.mas_centerX).offset(0);
        make.top.equalTo(layview.mas_top).offset(kRealValue(5));
    }];
    
    UILabel *laylabel = [[UILabel alloc]init];
    laylabel.text = [NSString stringWithFormat:@"+%@火币",str];
    laylabel.textColor = KColorFromRGB(0xFBC00B);
    laylabel.textAlignment = NSTextAlignmentCenter;
    laylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(19)];
    [layview addSubview:laylabel];
    [laylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(layview.mas_centerX).offset(0);
        make.top.equalTo(layimg.mas_bottom).offset(kRealValue(0));
    }];
    
    
    self.MoneyPopView = [[ZJAnimationPopView alloc] initWithCustomView:bgview popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
        self.qiandaoPopView3.popBGAlpha = 0.3f;
    // 3.3 显示时是否监听屏幕旋转
    self.MoneyPopView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.MoneyPopView.popAnimationDuration = 0.2f;
    // 3.5 移除时动画时长
    self.MoneyPopView.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    self.MoneyPopView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    self.MoneyPopView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [self.MoneyPopView pop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.MoneyPopView dismiss];
    });
    
    
    
}

-(void)startRewardAmited:(NSString *)str
{
     [self showMoneyToast:str withtime:2];
    [UIView transitionWithView:self.moneyImage duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 animations:^{
            //            self.moneyImage.frame = CGRectMake(kRealValue(30), kRealValue(50), 0, 0);
            self.moneyImage.alpha=0;
            
        } completion:^(BOOL finished) {
            
            self.moneylabel.hidden = NO;
            self.moneylabel.textColor = KColorFromRGB(0xF96150);
            self.moneylabel.text = @"完成";
            self.moneyImage.hidden=YES;
            
        }];
        
        
    }];
}


-(void)creteBtnstauteWithDownload:(NSString *)statu
{
    if ([statu isEqualToString:@"ACTIVE"]) {
        
        [self.subcommitTask setTitle:@"任务审核中" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
       
          NSMutableArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        BOOL isSave = YES;
        for (int i = 0 ; i< arr2.count; i++) {
            HSDownloadModel *model = [arr2 objectAtIndex:i];
            if (!klDicisEmpty(self.userDic)) {
                if (![model.user isEqualToString:[self.userDic valueForKey:@"phone"]]) {
                    return;
                }
            }
            
            if ([model.taskid isEqualToString:self.taskId]) {
                
                isSave = NO;
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
                
                NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.date doubleValue]];
                NSString *dateString = [formatter stringFromDate:date];
                NSLog(@"开始时间: %@", dateString);
                
                NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[[self currentdateInterval] doubleValue]];
                NSString *dateString2 = [formatter stringFromDate:date2];
                NSLog(@"结束时间: %@", dateString2);
                
                NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
                NSLog(@"两个时间相隔：%f", seconds);
                
                if (seconds > 30) {
                    //调用完成接口
                    [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                         
                            KLToast(response[@"message"]);
                            [self getdata];
                             [self startRewardAmited:response[@"data"]];
                            [arr2 removeObject:model];
                             [NSKeyedArchiver archiveRootObject:arr2 toFile:[self filePath]];
                            
                        }else{
                         
                            KLToast(response[@"message"]);
                            
                        }
                        if (error) {
                         
                            KLToast(response[@"message"]);
                        }
                        
                    }];
                }else{
                    //
                    self.time  = arc4random()%10;
                    [self createtimer];
                }
                 
                
               
            }
        }
        if (isSave == YES) {
            [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    
                    KLToast(response[@"message"]);
                    [self getdata];
                   [self startRewardAmited:response[@"data"]];
                  
                    
                }else{
                    
                    KLToast(response[@"message"]);
                    
                }
                if (error) {
                    
                    KLToast(response[@"message"]);
                }
                
            }];
        }
        
        
    }else if ([statu isEqualToString:@"PENDING"]){
        
        [self.subcommitTask setTitle:@"下载领取奖励" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
       
        
    }else if ([statu isEqualToString:@"DONE"]){
        
        [self.subcommitTask setTitle:@"下载完成" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"AUDIT"]){
        
        [self.subcommitTask setTitle:@"任务审核中" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"FAILED"]){
        
        [self.subcommitTask setTitle:@"未达标" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else if ([statu isEqualToString:@"INVALID"]){
        
       [self.subcommitTask setTitle:@"已失效" forState:UIControlStateNormal];
       self.subcommitTask.backgroundColor = KColorFromRGB(0xe0e0e0);
        
    }else{
        
        [self.subcommitTask setTitle:@"下载领取奖励" forState:UIControlStateNormal];
        self.subcommitTask.backgroundColor = KColorFromRGB(0xF6AC19);
    }
}
-(void)webviewscroller
{
    
        if (self.stopLinetime > 0) {
            
        }else{
            MHLog(@"继续计算时间");
            self.stopLinetime =  5 ;;
            if (self.time > 0 ) {
                [self createtimer];
            }
            
            
        }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        if (self.stopLinetime > 0) {
            
        }else{
            MHLog(@"继续计算时间");
            self.stopLinetime =  5 ;;
            if (self.time > 0 ) {
                [self createtimer];
            }
            
            
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        if (self.stopLinetime > 0) {
            
        }else{
            MHLog(@"继续计算时间");
            self.stopLinetime =  5 ;;
            if (self.time > 0 ) {
                [self createtimer];
            }
            
            
        }
    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

        if (self.stopLinetime > 0) {
            
        }else{
            MHLog(@"继续计算时间");
            self.stopLinetime =  5 ;;
            if (self.time > 0 ) {
                [self createtimer];
            }
    
            
        }
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
    if (self.timer) {
        //        [self.timer invalidate];
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!klObjectisEmpty(self.dic)) {
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]) {
            NSInteger btnoffset = 10;
            NSInteger pading = kRealValue(10);
            for (int i = 0; i < self.PicArr.count; i++) {
                
                MHProductPicModel *model = [self.PicArr objectAtIndex:i];
                btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue])+pading;
            }
            return kRealValue(btnoffset);
        }
        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"HTML"]) {
            return kScreenHeight - kTopHeight;
        }
         return kRealValue(500);
    }

    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      if (!klObjectisEmpty(self.dic)) {
           return 1;
      }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"PICTURE"]) {
            MHTaskDetailImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTaskDetailImagesCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.PictureArr = self.PicArr;
            return cell;
            
        }
    if ([[self.dic valueForKey:@"detailType"] isEqualToString:@"URL"]||[[self.dic valueForKey:@"detailType"] isEqualToString:@"HTML"]) {
        HSWebviewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWebviewCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.delegate =self;
        NSString *str;
        if (self.PicArr.count > 0) {
            MHProductPicModel *model = [self.PicArr objectAtIndex:0];
            str =model.filePath;
        }
        if ([[self.dic valueForKey:@"property"] isEqualToString:@"SHARE"]||[[self.dic valueForKey:@"property"] isEqualToString:@"DOWNLOAD"]) {
            [cell createwebviewheight2];
        }else{
            [cell createwebviewheight];
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
        
    
    
    return nil;
    
    
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
