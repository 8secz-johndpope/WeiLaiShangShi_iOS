//
//  HSTaskViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/20.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskViewController.h"
#import "HSTaskHeadCell.h"
#import "HSTsakSectionHeadCell.h"
#import "HSTaskNormalCell.h"
#import "HSTaskLastCell.h"
#import "HSTaskSkipCell.h"
#import "SGPagingView.h"
#import "HSTaskChirdViewController.h"
#import "HSTaskDetailViewViewController.h"
#import "MHBaseTableView.h"
#import "MHTaskDetailModel.h"
#import "HSTaskTopCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSTaskChirdTwoViewController.h"
#import "HSTaskSectionCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSNewsDetailViewController.h"
#import "HSChargeController.h"
#import "MHLoginViewController.h"
#import "HSFriendShopViewController.h"
#import "MHUpdateModel.h"
#import "CTUUID.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
@interface HSTaskViewController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong)NSMutableDictionary *qiandaoDic;
@property (nonatomic, strong)NSMutableArray *qiandaoArr;
@property (nonatomic, strong)NSMutableArray *fuliArr;
@property (nonatomic, assign) int limittimeindex;
@property(nonatomic, strong)NSMutableArray *listArr;
@property(nonatomic, strong)NSMutableArray *listArr2;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, strong) UIView   *naviView;//自定义导航栏
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong)NSMutableDictionary *userDic;
@property (nonatomic, strong) ZJAnimationPopView *VersionpopView;
@property (nonatomic, assign) NSInteger IndexSelect;
@end

@implementation HSTaskViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getqiandaoInfo];
    [self getFuliInfo];
    [self getvipInfo];
    [self getSvipInfo];
    [self getUserInfo];
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
                //更新
                
                UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                contentViews.backgroundColor = [UIColor clearColor];
                
                UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(300), kRealValue(385))];
                forceUpdateImg.userInteractionEnabled = YES;
                forceUpdateImg.image = [UIImage imageNamed:@"home_update_bg"];
                [contentViews addSubview:forceUpdateImg];
                forceUpdateImg.centerX = contentViews.centerX;
                
                UILabel *leftLabel = [[UILabel alloc] init];
                leftLabel.text = @"升级到新版本";
                leftLabel.textColor = [UIColor colorWithHexString:@"#222222"];
                leftLabel.font = [UIFont systemFontOfSize:kFontValue(20)];
                [forceUpdateImg addSubview:leftLabel];
                [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(140));
                    make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                }];
                
                
                UIScrollView * updateScr = [[UIScrollView alloc]init];
                [contentViews addSubview:updateScr];
                [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                    make.right.equalTo(forceUpdateImg.mas_right).offset(kRealValue(-25));
                    make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(170));
                    make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(kRealValue(-82));
                    
                }];
                UIView *updateContentView = [[UIView alloc]init];
                [updateScr addSubview:updateContentView];
                [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(updateScr);
                    make.width.equalTo(updateScr);
                }];
                UILabel *label = [[UILabel alloc]init];
                label.numberOfLines = 0;
                label.textColor = [UIColor colorWithHexString:@"#444444"];
                NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
                label.text = str;
                label.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
                [updateContentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(updateContentView.mas_top);
                    make.left.equalTo(@0);
                    make.width.equalTo(updateContentView.mas_width);
                    
                }];
                
                [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(label.mas_bottom);
                }];
                
                UIButton *update_btn = [[UIButton alloc] init];
                [update_btn setTitle:@"立即升级" forState:UIControlStateNormal];
                update_btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
                [update_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
                [update_btn bk_addEventHandler:^(id sender) {
                    //更新按钮
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                } forControlEvents:UIControlEventTouchUpInside];
                ViewRadius(update_btn, kRealValue(5));
                [forceUpdateImg addSubview:update_btn];
                [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
                    make.centerX.equalTo(forceUpdateImg.mas_centerX);
                    make.width.mas_equalTo(kRealValue(220));
                    make.height.mas_equalTo(kRealValue(35));
                }];
                
                self.VersionpopView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                // 3.2 显示时背景的透明度
                self.VersionpopView.popBGAlpha = 0.5f;
                // 3.3 显示时是否监听屏幕旋转
                self.VersionpopView.isObserverOrientationChange = YES;
                // 3.4 显示时动画时长
                self.VersionpopView.popAnimationDuration = 0.5f;
                // 3.5 移除时动画时长
                self.VersionpopView.dismissAnimationDuration = 0.3f;
                
                // 3.6 显示完成回调
                self.VersionpopView.popComplete = ^{
                    MHLog(@"显示完成");
                };
                // 3.7 移除完成回调
                self.VersionpopView.dismissComplete = ^{
                    MHLog(@"移除完成");
                };
                [self.VersionpopView pop];
                
                
            }else{
                
                if (model.upgrade == 1) {
                    //非强制更新
                    
                    UIView *contentViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    contentViews.backgroundColor = [UIColor clearColor];
                    
                    UIImageView *forceUpdateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,kRealValue(150), kRealValue(300), kRealValue(385))];
                    forceUpdateImg.userInteractionEnabled = YES;
                    forceUpdateImg.image = [UIImage imageNamed:@"home_update_bg"];
                    [contentViews addSubview:forceUpdateImg];
                    forceUpdateImg.centerX = contentViews.centerX;
                    
                    UILabel *leftLabel = [[UILabel alloc] init];
                    leftLabel.text = @"升级到新版本";
                    leftLabel.textColor = [UIColor colorWithHexString:@"#222222"];
                    leftLabel.font = [UIFont systemFontOfSize:kFontValue(20)];
                    [forceUpdateImg addSubview:leftLabel];
                    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(140));
                        make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                    }];
                    
                    
                    UIScrollView * updateScr = [[UIScrollView alloc]init];
                    [contentViews addSubview:updateScr];
                    [updateScr mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(forceUpdateImg.mas_left).offset(kRealValue(25));
                        make.right.equalTo(forceUpdateImg.mas_right).offset(kRealValue(-25));
                        make.top.equalTo(forceUpdateImg.mas_top).offset(kRealValue(170));
                        make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(kRealValue(-82));
                        
                    }];
                    UIView *updateContentView = [[UIView alloc]init];
                    [updateScr addSubview:updateContentView];
                    [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(updateScr);
                        make.width.equalTo(updateScr);
                    }];
                    UILabel *label = [[UILabel alloc]init];
                    label.numberOfLines = 0;
                    label.textColor = [UIColor colorWithHexString:@"#444444"];
                    NSString *str = [model.upgradeLog  stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
                    label.text = str;
                    label.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
                    [updateContentView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(updateContentView.mas_top);
                        make.left.equalTo(@0);
                        make.width.equalTo(updateContentView.mas_width);
                        
                    }];
                    
                    [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(label.mas_bottom);
                    }];
                    
                    UIButton *update_btn = [[UIButton alloc] init];
                    [update_btn setTitle:@"立即升级" forState:UIControlStateNormal];
                    update_btn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
                    [update_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F6AC19"]] forState:UIControlStateNormal];
                    [update_btn bk_addEventHandler:^(id sender) {
                        //更新按钮
                        [self.VersionpopView dismiss];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                    } forControlEvents:UIControlEventTouchUpInside];
                    ViewRadius(update_btn, kRealValue(5));
                    [forceUpdateImg addSubview:update_btn];
                    [update_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.equalTo(forceUpdateImg.mas_bottom).offset(-kRealValue(29));
                        make.centerX.equalTo(forceUpdateImg.mas_centerX);
                        make.width.mas_equalTo(kRealValue(220));
                        make.height.mas_equalTo(kRealValue(35));
                    }];
                    
                    self.VersionpopView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                    // 3.2 显示时背景的透明度
                    self.VersionpopView.popBGAlpha = 0.5f;
                    // 3.3 显示时是否监听屏幕旋转
                    self.VersionpopView.isObserverOrientationChange = YES;
                    // 3.4 显示时动画时长
                    self.VersionpopView.popAnimationDuration = 0.5f;
                    // 3.5 移除时动画时长
                    self.VersionpopView.dismissAnimationDuration = 0.3f;
                    
                    // 3.6 显示完成回调
                    self.VersionpopView.popComplete = ^{
                        MHLog(@"显示完成");
                    };
                    // 3.7 移除完成回调
                    self.VersionpopView.dismissComplete = ^{
                        MHLog(@"移除完成");
                    };
                    [self.VersionpopView pop];
                    
                    
                    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
                    [closeBtn bk_addEventHandler:^(id sender) {
                        [self.VersionpopView dismiss];
                        [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert = @"No";
                        
                        
                    } forControlEvents:UIControlEventTouchUpInside];
                    [contentViews addSubview:closeBtn];
                    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
                        make.right.mas_equalTo(forceUpdateImg.mas_right);
                        make.size.mas_equalTo(CGSizeMake(25, 25));
                    }];
                }
                
            }
            
        }
        
    }];
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

-(void)getSvipInfo
{
    self.listArr2 = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initwithHSVIPTaskListWithType:@"SVIP"
                                                 CompletionBlock:^(NSDictionary *response, NSError *error) {
                                                     if (ValidResponseDict(response)) {
                                                         self.listArr2 = [MHTaskDetailModel baseModelWithArr:[response valueForKey:@"data"]];
                                                         //置顶任务
                                                         for (int i = 0; i < self.listArr2.count; i++) {
                                                             MHTaskDetailModel *model = [self.listArr2 objectAtIndex:i];
                                                             if (model.top == 1) {
                                                                 [self.listArr2 removeObject:model];
                                                                 [self.listArr2 insertObject:model atIndex:0];
                                                             }
                                                         }
                                                         
                                                         [self.tableView reloadData];
                                                     }
                                                 }];
    
    
}
-(void)getvipInfo
{
    self.listArr = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initwithHSVIPTaskListWithType:@"VIP"
                                                 CompletionBlock:^(NSDictionary *response, NSError *error) {
                                                     if (ValidResponseDict(response)) {
                                                         self.listArr = [MHTaskDetailModel baseModelWithArr:[response valueForKey:@"data"]];
                                                         //置顶任务
                                                         for (int i = 0; i < self.listArr.count; i++) {
                                                             MHTaskDetailModel *model = [self.listArr objectAtIndex:i];
                                                             if (model.top == 1) {
                                                                 [self.listArr removeObject:model];
                                                                 [self.listArr insertObject:model atIndex:0];
                                                             }
                                                         }
                                                         
                                                         [self.tableView reloadData];
                                                     }
                                                 }];
    
    
}

-(void)getqiandaoInfo
{
    self.qiandaoArr = [NSMutableArray array];
    self.qiandaoDic = [NSMutableDictionary dictionary];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[MHUserService sharedInstance]initwithHSQiandaoInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.qiandaoDic = [response valueForKey:@"data"][@"userIntegral"];
                self.qiandaoArr = [response valueForKey:@"data"][@"integrals"];
                [self.tableView reloadData];
            }
        }];
    }
   
}
-(void)getFuliInfo
{
    self.fuliArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initwithHSFuliTaskListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.fuliArr = [MHTaskDetailModel baseModelWithArr:[response valueForKey:@"data"]];
            //置顶任务
        for (int i = 0; i < self.fuliArr.count; i++) {
            MHTaskDetailModel *model = [self.fuliArr objectAtIndex:i];
            if (model.top == 1) {
                [self.fuliArr removeObject:model];
                [self.fuliArr insertObject:model atIndex:0];
            }
            }
            
            [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_header endRefreshing];
        }
        if (error) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self createview];
    self.canScroll = YES;
    self.IndexSelect=0;
    self.selectIndex = 1;
 
    
    
   
    // Do any additional setup after loading the view.
}
-(void)createview
{
    [self.view addSubview:self.tableView];
     [self.view addSubview:self.naviView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self getvipInfo];
        [self getSvipInfo];
         [self getFuliInfo];
        [self getqiandaoInfo];
    }];
    
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[MHBaseTableView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth, kScreenHeight-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        [_tableView registerClass:[HSTaskHeadCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskHeadCell class])];
        [_tableView registerClass:[HSTsakSectionHeadCell class] forCellReuseIdentifier:NSStringFromClass([HSTsakSectionHeadCell class])];
        [_tableView registerClass:[HSTaskSkipCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskSkipCell class])];
           [_tableView registerClass:[HSTaskTopCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskTopCell class])];
         [_tableView registerClass:[HSTaskLastCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskLastCell class])];
        
        [_tableView registerClass:[HSTaskSectionCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskSectionCell class])];
        [_tableView registerClass:[HSTaskNormalCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskNormalCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return kRealValue(253)+kStatusBarHeight;
    }
    if (indexPath.section ==1) {
        
        
        if (self.fuliArr.count > 0) {
            if (indexPath.row == 0) {
                return kRealValue(50);
            }
            if (self.fuliArr.count >1) {
                if (indexPath.row<self.fuliArr.count) {
                    MHTaskDetailModel *model = [self.fuliArr objectAtIndex:indexPath.row];
                    if (model.top == 1) {
                        return  kRealValue(71);
                    }
                    return kRealValue(67);
                }else{
                     return kRealValue(86);
                }
            }else{
                  return kRealValue(86);
            }
            
        }
        return 0;
      
    }
    if (indexPath.section ==2) {
        if (indexPath.row == 0) {
            return kRealValue(50);
        }
        if (self.selectIndex == 1) {
            if (self.listArr.count >1) {
                if (indexPath.row<self.listArr.count) {
                    MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
                    if (model.top == 1) {
                        return  kRealValue(71);
                    }
                    return kRealValue(67);
                }else{
                    return kRealValue(86);
                }
            }else{
                return kRealValue(86);
            }
        }else{
            if (self.listArr2.count >1) {
                if (indexPath.row<self.listArr2.count) {
                    MHTaskDetailModel *model = [self.listArr2 objectAtIndex:indexPath.row];
                    if (model.top == 1) {
                        return  kRealValue(71);
                    }
                    return kRealValue(67);
                }else{
                    return kRealValue(86);
                }
            }else{
                return kRealValue(86);
            }
            
        }
        
        
    }
    
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 1;
    }
    if (section == 1) {
        if (self.fuliArr.count>0) {
            return self.fuliArr.count+1;
        }
        return 0;
    }
    if (section == 2) {
        if (self.selectIndex == 1) {
            if (self.listArr.count>0) {
                return self.listArr.count+1;
            };
            return 0;
        }else{
            if (self.listArr2.count>0) {
                return self.listArr2.count+1;
            };
            return 0;
        }
       
    }
    
     return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HSTaskHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskHeadCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (self.qiandaoArr.count > 0) {
            [cell createviewWithArr:self.qiandaoArr withDic:self.qiandaoDic];
        }
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            [cell createViewIndenglu];
        }
        
        cell.Qiandao = ^{
            
            if (![GVUserDefaults standardUserDefaults].accessToken) {
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [self presentViewController:userNav animated:YES completion:nil];
                return;
            }
            
            [[MHUserService sharedInstance]initwithHSDoQiandaoCompletionBlock:^(NSDictionary *response, NSError *error) {
                
                if (ValidResponseDict(response)) {
                    KLToast([response valueForKey:@"message"]);
                    [self getqiandaoInfo];
                }else{
                      KLToast([response valueForKey:@"message"]);
                }
                if (error) {
                    KLToast([response valueForKey:@"message"]);
                }
            }];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        
        if (self.fuliArr.count > 0) {
            if (indexPath.row == 0) {
                HSTsakSectionHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTsakSectionHeadCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                
                return cell;
            }
            if (indexPath.row == self.fuliArr.count) {
                
                HSTaskLastCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskLastCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createWithModel:[self.fuliArr objectAtIndex:indexPath.row-1]];
                return cell;
            }
            MHTaskDetailModel *model = [self.fuliArr objectAtIndex:indexPath.row-1];
            if (model.top == 1) {
                HSTaskTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskTopCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell.bgview sd_setImageWithURL:[NSURL URLWithString:model.title]];
                return cell;
            }
            HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            [cell createWithModel:[self.fuliArr objectAtIndex:indexPath.row-1]];
            return cell;
        }
        HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.dotask = ^{
            HSTaskDetailViewViewController *vc =[[HSTaskDetailViewViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }
    if (indexPath.section == 2) {
        if (self.selectIndex ==1) {
            if (self.listArr.count > 0) {
                if (indexPath.row == 0) {
                    HSTaskSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskSectionCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
//                    [cell setselecttab:self.selectIndex];
                      [cell setSelectTab:self.IndexSelect];
                    cell.ChangeTab = ^(NSInteger index) {
                        self.selectIndex = index;
                        self.IndexSelect = index-1;
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//                        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                         [self.tableView reloadData];
                    };
                    
                    return cell;
                }
                if (indexPath.row == self.listArr.count) {
                    
                    HSTaskLastCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskLastCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createWithModel:[self.listArr objectAtIndex:indexPath.row-1]];
                    return cell;
                }
                MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row-1];
                if (model.top == 1) {
                    HSTaskTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskTopCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell.bgview sd_setImageWithURL:[NSURL URLWithString:model.title]];
                    return cell;
                }
                HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createWithModel:[self.listArr objectAtIndex:indexPath.row-1]];
               
                return cell;
            }
        }else{
            if (self.listArr2.count > 0) {
                if (indexPath.row == 0) {
                    HSTaskSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskSectionCell class])];
//                      [cell setselecttab:self.selectIndex];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell setSelectTab:self.IndexSelect];
                    cell.ChangeTab = ^(NSInteger index) {
                        self.selectIndex = index;
                           self.IndexSelect = index-1;;
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//                        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView reloadData];
                    };
                    
                    return cell;
                }
                if (indexPath.row == self.listArr2.count) {
                    
                    HSTaskLastCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskLastCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createWithModel:[self.listArr2 objectAtIndex:indexPath.row-1]];
                    return cell;
                }
                MHTaskDetailModel *model = [self.listArr2 objectAtIndex:indexPath.row-1];
                if (model.top == 1) {
                    HSTaskTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskTopCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell.bgview sd_setImageWithURL:[NSURL URLWithString:model.title]];
                    return cell;
                }
                HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createWithModel:[self.listArr2 objectAtIndex:indexPath.row-1]];
                return cell;
            }
        }

        HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
//        [cell createWithModel:[self.fuliArr objectAtIndex:indexPath.row]];
        return cell;
    }
    HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
   
    return cell;
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![GVUserDefaults standardUserDefaults].accessToken) {
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
        return;
    }
    
    
    if (indexPath.section == 1) {
        if (self.fuliArr.count>0) {
            MHTaskDetailModel *model = [self.fuliArr objectAtIndex:indexPath.row-1];
            if ([model.property isEqualToString:@"REVIEW"]) {
                //审核任务
                HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                  vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([model.property isEqualToString:@"READ"]) {
                //阅读任务
                 [self getMHTaskDetailModel2:model];
            }else if ([model.property isEqualToString:@"APPOINT"]) {
                //阅读指定任务
                 [self getMHTaskDetailModel:model];
                
            }else if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                
                //阅读指定任务
                [self getMHTaskDetailModel:model];
                
            }else{
                [self doOthertaskModel2:model];
            }
            
        }
    }
    if (indexPath.section == 2) {
        if (self.selectIndex == 1) {
     
        if (self.listArr.count>0) {
            MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row-1];
            //1 先判断用户角色
           
            // 任务类型
            
            
            
            if ([model.property isEqualToString:@"REVIEW"]) {
                //审核任务
                HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                [self.navigationController pushViewController:vc animated:YES];
            }
           else if ([model.property isEqualToString:@"READ"]) {
                //阅读任务
                if ([model.taskType isEqualToString:@"SVIP"]) {
                    if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                        NSString *str = @"";
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                            str =@"你还不是金勺会员,请前往升级";
                        }
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                            str =@"你还不是银勺会员,请前往升级";
                        }
                        
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }];
                        
                        return;
                        
                        
                        
                    }
                }
                if ([model.taskType isEqualToString:@"VIP"]) {
                    if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] &&
                        ![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                        NSString *str = @"";
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                            str =@"你还不是银勺会员,请前往升级";
                        }
                        
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }];
                        return ;
                    }
                }
                //先判断友力值
                 [self getMHTaskDetailModel2:model];
               
                
            }
           else if ([model.property isEqualToString:@"APPOINT"]) {
                //阅读指定任务
                if ([model.taskType isEqualToString:@"SVIP"]) {
                    if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                        NSString *str = @"";
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                            str =@"你还不是金勺会员,请前往升级";
                        }
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                            str =@"你还不是银勺会员,请前往升级";
                        }
                        
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }];
                        
                        return;
                        
                        
                        
                    }
                }
                if ([model.taskType isEqualToString:@"VIP"]) {
                    if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] &&
                        ![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                        NSString *str = @"";
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                            str =@"你还不是银勺会员,请前往升级";
                        }
                        
                        
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }];
                        return ;
                    }
                }
                //先判断友力值
                [self getMHTaskDetailModel:model];
                
                
            }
           else if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                
                //阅读指定任务
                [self getMHTaskDetailModel:model];
                
            }else{
                
                  [self doOthertaskModel2:model];
            }
            
            
    }
        }else{
            if (self.listArr2.count) {
                {
                    MHTaskDetailModel *model = [self.listArr2 objectAtIndex:indexPath.row-1];
                  
                    
                    
                    
                    if ([model.property isEqualToString:@"REVIEW"]) {
                        //审核任务
                        HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                        vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                   else if ([model.property isEqualToString:@"READ"]) {
                        //阅读任务
                        // 领取任务
                        //1 先判断用户角色
                        if ([model.taskType isEqualToString:@"SVIP"]) {
                            if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                                NSString *str = @"";
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                                    str =@"你还不是金勺会员,请前往升级";
                                }
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                                    str =@"你还不是银勺会员,请前往升级";
                                }
                                
                                
                                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                                    
                                } rightAct:^{
                                    HSChargeController *vc = [[HSChargeController alloc]init];
                                    [self.navigationController pushViewController:vc animated:YES];
                                    
                                }];
                                return;
                            }
                        }
                        if ([model.taskType isEqualToString:@"VIP"]) {
                            if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"]) {
                                NSString *str = @"";
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                                    str =@"你还不是银勺会员,请前往升级";
                                }
                                
                                //
                                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                                    
                                } rightAct:^{
                                    HSChargeController *vc = [[HSChargeController alloc]init];
                                    [self.navigationController pushViewController:vc animated:YES];
                                     return ;
                                    
                                }];
                                return;
                            }
                        }
                        // 任务类型
                        //先判断友力值
                         [self getMHTaskDetailModel2:model];
                       
                        
                    }
                   else if ([model.property isEqualToString:@"APPOINT"]) {
                        //阅读指定任务
                        //1 先判断用户角色
                        if ([model.taskType isEqualToString:@"SVIP"]) {
                            if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                                NSString *str = @"";
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                                    str =@"你还不是金勺会员,请前往升级";
                                }
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                                    str =@"你还不是银勺会员,请前往升级";
                                }
                                
                                
                                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                                    
                                } rightAct:^{
                                    HSChargeController *vc = [[HSChargeController alloc]init];
                                    [self.navigationController pushViewController:vc animated:YES];
                                     return ;
                                }];
                                return;
                            }
                        }
                        if ([model.taskType isEqualToString:@"VIP"]) {
                            if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"]) {
                                NSString *str = @"";
                                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                                    str =@"你还不是银勺会员,请前往升级";
                                }
                                
                                //
                                [[MHBaseClass sharedInstance] presentAlertWithtitle:str message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                                    
                                } rightAct:^{
                                    HSChargeController *vc = [[HSChargeController alloc]init];
                                    [self.navigationController pushViewController:vc animated:YES];
                                    
                                }];
                                return;
                            }
                        }
                        // 任务类型
                        //先判断友力值
                         [self getMHTaskDetailModel:model];
                       
                        
                    }
                 else   if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                        
                        //阅读任务
                        [self getMHTaskDetailModel:model];
                        
                    }else{
                        //其他任务
                        
                          [self doOthertaskModel2:model];
                    }
                    
                    
                }
            }
            
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
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"您当前账户友力值不足。您可以通过邀请好友或者直接充值的方式补充友力值。" message:@"" leftbutton:@"取消" rightbutton:@"立即补充" leftAct:^{
                    
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
-(void)getMHTaskDetailModel2:(MHTaskDetailModel *)model
{
    // 阅读任务
    //只有pending 和 进行中 才点击
    //pengding 要领取
    if ([model.status isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            if ([model.power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"您当前账户友力值不足。您可以通过邀请好友或者直接充值的方式补充友力值。" message:@"" leftbutton:@"取消" rightbutton:@"立即补充" leftAct:^{
                    
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
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                //            KLToast(@"任务领取成功");
            
                [self.tabBarController setSelectedIndex:0];
                
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
         [self.tabBarController setSelectedIndex:0];
    }
    if ([model.status isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
   
    
}
-(void)doOthertaskModel2:(MHTaskDetailModel *)model
{
    if ([model.status isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            if ([model.power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"您当前账户友力值不足。您可以通过邀请好友或者直接充值的方式补充友力值。" message:@"" leftbutton:@"取消" rightbutton:@"立即补充" leftAct:^{
                    
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
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                 KLToast(@"任务领取成功");
                [self getFuliInfo];
                [self getvipInfo];
                [self getSvipInfo];
                [self getUserInfo];
              
                
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
       
    }
    if ([model.status isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        //当前偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        MHLog(@"%f",yOffset);
        
        //更改导航栏的背景图的透明度
        CGFloat alpha = 0;
        if (yOffset<=0) {
            alpha = 0;
        } else if(yOffset < (10)){
//            alpha = yOffset/(kTopHeight+0);
        }else if(yOffset >= (10)){
            alpha = 1;
        }else{
            alpha = 0;
        }
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:alpha];
        self.naviView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:alpha];
    }
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
        backButton.hidden =YES;
        [_naviView addSubview:backButton];
        
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
        _titleLabel.text = @"任务中心";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
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
