//
//  HSNewsDetailViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsDetailViewController.h"
#import "SJVideoPlayer.h"
#import <WebKit/WebKit.h>
#import "HSRewardViewClass.h"
#import "HSChargeController.h"
#import "MHLoginViewController.h"
#import "HSQRcodeVC.h"
#import "HSMemberThreeCell.h"
#import "HSAriiceShareCell.h"
#import "ZJAnimationPopView.h"
#import "HSCircle.h"
#import "HSBannerModel.h"
#import "HSNewsModel.h"
#import "HSEmporCell.h"
#import "MHTaskDetailModel.h"
#import "HSMemberThreeCell.h"
#import "HSMemberNoImgCell.h"
#import "HSMemberOneCell.h"
#import "HSMemberOneRight.h"
#import "HSMemberOneLeftCell.h"
#import "HSNewsOneCell.h"
#import "HSNewTwoCell.h"
#import "HSNewsThirdCell.h"
#import "HSNewsFourCell.h"
#import "HSNewsSixCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSTaskShareViewController.h"
#import "MHWebviewViewController.h"
@interface HSNewsDetailViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UILabel *typelabel;
@property(nonatomic,strong)UILabel *authlabel;
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIImageView *image;
//@property(strong,nonatomic)NSTimer *timer;
@property(assign,nonatomic)CGFloat time;
@property(assign,nonatomic)CGFloat time2;
@property(assign,nonatomic)CGFloat time3;
@property (nonatomic, strong) UIView   *naviView;//自定义导航栏
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign)BOOL IsStop;
@property (nonatomic, assign)BOOL IsShowTimer;
@property(nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic, strong)UILabel *Arititlelabel;
@property(nonatomic, strong)UILabel *Ariauthorlabel;
@property(nonatomic, strong)UILabel *Aritimelabel;
@property(nonatomic, strong)NSString *h5funName;
@property (nonatomic, strong)NSMutableDictionary *respondic;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong)ZJAnimationPopView *qiandaoPopView3;
@property (nonatomic, strong)ZJAnimationPopView *MoneyPopView;
@property (nonatomic, strong) NSMutableArray *shareArr;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong)NSString * urlStr;
@property (nonatomic, assign)CGFloat stopLinetime;
@property (nonatomic, strong)UIImageView *lauchbgView;
@end

@implementation HSNewsDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
  
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    if (self.player) {
        [self.player vc_viewDidDisappear];
    };
    if (self.timer) {
//        [self.timer invalidate];
         dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    if (self.window) {
        self.bgview.hidden = YES;
        self.showTimeLabel.hidden = YES;
        [self.bgview removeFromSuperview];
        [self.showTimeLabel removeFromSuperview];
        
    }
//     [self.view removeAllSubviews];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    if (self.player) {
        [self.player vc_viewWillDisappear];
    };
   
   
   
}


- (void)Timered:(NSTimer*)timer {
    NSLog(@"timer called");
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        NSInteger index =  self.time--;
        NSString *str1 =[NSString stringWithFormat:@"%ld",index];
        NSString *Str = [NSString stringWithFormat:@"倒计时%ld秒",index];
        NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
        [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xEA5520) range:NSMakeRange(3, str1.length)];
        [attstring addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(11)] range:NSMakeRange(3, str1.length)];
        self.showTimeLabel.attributedText = attstring;
        if (self.time == -1) {
//            [self. timer invalidate];
            
            [[MHUserService sharedInstance]initwithHSAriticeTimerOverWIthID:self.ariticeID ISAd:self.IsAd title:[self.dic valueForKey:@"title"]  CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast([response objectForKey:@"message"]);
//                    self.bgview.hidden = YES;
//                    self.showTimeLabel.hidden = YES;
                }
            }];
        }
    });
   
   
   
    
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
#pragma mark 计时器方法
-(void)createtime
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
               
                [[MHUserService sharedInstance]initwithHSAriticeTimerOverWIthID:self.ariticeID ISAd:self.IsAd title:[self.dic valueForKey:@"title"]  CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                      
                            
                            //开始奖励动画
                        [self startRewardAmited:response[@"data"]];
                        self.bgview.hidden = YES;
                        self.showTimeLabel.hidden = YES;
                    }
                    if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20501" ]) {
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去邀请" leftAct:^{
                            
                        } rightAct:^{
                            
                        }];
                    }
                    if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20500" ]) {
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            
                        }];
                    }
                    
                }];
                
            });
        }else{
            //            int minutes = timeout / 60;
          
          
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
              

                
                NSLog(@"timer called");
                
                CGFloat singerproess = (CGFloat)1.0 /(CGFloat)self.time2/10 ;
                self.time= self.time - 0.1;
//                self.stopLinetime--;
                self.stopLinetime= self.stopLinetime-0.1;
                self.proess += singerproess;
                self.pathView.progress = self.proess;
                
                if (![[self.dic valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                    if (self.stopLinetime < 0 ) {
                        //暂停计时器方法
                        if (self.time > 0) {
                             dispatch_cancel(weakself.timer);
                        }
                       
                    }
                }
                
               
                
                
               
            });
           
        }
    });
    //启动定时器
    dispatch_resume(_timer);
    
    

}
-(void)showMoneyToast:(NSString *)str
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
    //    self.qiandaoPopView3.popBGAlpha = 0.3f;
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.MoneyPopView dismiss];
    });
    
    
    
}



-(void)startRewardAmited:(NSString *)str
{
    [self showMoneyToast:str];
    [UIView transitionWithView:self.moneyImage duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.IsStop = NO;
    self.IsshowTop = NO;
    self.stopLinetime = 5;
    self.listArr = [NSMutableArray array];
    [self getdata];
    [self getAriticedata];
    [self getShareData];
    self.dic = [NSMutableDictionary dictionary];
    self.view.backgroundColor = KColorFromRGB(0xF2F2F2);
  self.fd_prefersNavigationBarHidden =YES;
    
   
    
    ;
    
    // Do any additional setup after loading the view.
}
-(void)getAriticedata
{
    [[MHUserService sharedInstance]initwithHsRecommenFirstPageAriticeID:self.ariticeID CompletionBlock:^(NSDictionary *response, NSError *error) {
         if (ValidResponseDict(response)) {
              [self.listArr  addObjectsFromArray:[HSNewsModel baseModelWithArr:response[@"data"]]];
             [self.tableView reloadData];
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
-(void)getdata
{
    [[MHUserService sharedInstance]initwithHSAriticeDetailariticeId:self.ariticeID ISAd:self.IsAd  CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
             MHLog(@"2");
            
            
            
            self.dic = [response valueForKey:@"data"];
            
//            if (![[self.dic valueForKey:@"tag"] isEqualToString:@"广告"]) {
            
          
            
            [[MHUserService sharedInstance]initwithHSAriticeTimerWIthID:self.ariticeID ISAd:self.IsAd  CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    MHLog(@"1");
                    if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"data"]] isEqualToString:@"1"]) {
                        
                        self.IsShowTimer = YES;
                        
                        
                    }else{
                        self.IsShowTimer = NO;
                    }
                    
                    if (self.IsShowTimer) {
                        NSString *str =[self.dic valueForKey:@"readTime"];
                        if ( [str integerValue] > 0) {
                            // 展示
                            [self showTimer];
                        }
                        
                    }else{
                        self.bgview.hidden = YES;
                        self.showTimeLabel.hidden = YES;
//                        [self createtimeview2];
//                        self.pathView.progress = 1.0;
//                        self.moneylabel.textColor = KColorFromRGB(0xF96150);
//                        self.moneylabel.text = @"完成";
//                        self.moneyImage.hidden=YES;
//                        self.moneylabel.hidden=NO;
//
                      
                    }
                    
                }
              
          
            
                if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20501" ]) {
                    
                    if ([[GVUserDefaults standardUserDefaults].ShowYaoqingalert isEqualToString:@"NO"]) {
                        [GVUserDefaults standardUserDefaults].ShowYaoqingalert = @"YES";
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去邀请" leftAct:^{
                            
                        } rightAct:^{
                            HSQRcodeVC *vc =[[HSQRcodeVC alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                        
                        
                    }
                    
                }
                if ([[NSString stringWithFormat:@"%@",response[@"code"]] isEqualToString:@"20500" ]) {
                    if ([[GVUserDefaults standardUserDefaults].Showshenjialert isEqualToString:@"NO"]) {
                        
                        [GVUserDefaults standardUserDefaults].Showshenjialert = @"YES";
                        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"温馨提示" message:response[@"message"] leftbutton:@"取消" rightbutton:@"去升级" leftAct:^{
                            
                        } rightAct:^{
                            HSChargeController *vc = [[HSChargeController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                    
                }
                
            }];
//            }
            
            if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                //视频
                self.lauchbgView.hidden = YES;
                [self createview];
               
                
                
            }
            if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"ARTICLE"]) {
                //文章
                if ([[[response valueForKey:@"data"] valueForKey:@"contentType"] isEqualToString:@"URL"]) {
                    [self.view addSubview:self.naviView];
                    [self createview1];
                    self.lauchbgView = [[UIImageView alloc]init];
                    self.lauchbgView.image = kGetImage(@"loadingicon");
                    [self.view addSubview:self.lauchbgView];
                    [self.lauchbgView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.view.mas_centerX).offset(0);
                        make.centerY.equalTo(self.view.mas_centerY).offset(0);
                        
                    }];
                    
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"contentType"] isEqualToString:@"HTML"]) {
                    [self.view addSubview:self.naviView];
                    [self createview11];
                    self.lauchbgView = [[UIImageView alloc]init];
                    self.lauchbgView.image = kGetImage(@"loadingicon");
                    [self.view addSubview:self.lauchbgView];
                    [self.lauchbgView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.view.mas_centerX).offset(0);
                        make.centerY.equalTo(self.view.mas_centerY).offset(0);
                        
                    }];
                    
                }
                
                
            }
           
            
            
        }else{
            KLToast(response[@"message"]);
        }
        
        
    }];
    
}
-(void)showTimer
{
   
    NSString *str =[self.dic valueForKey:@"readTime"];
    NSString *content = [self.dic valueForKey:@"content"];
    if ([[self.dic valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
        NSDictionary *dic  = [self dictionaryWithJsonString:content];
        if (dic) {
            NSString *longtimer = [dic valueForKey:@"duration"];
            NSInteger a =[longtimer integerValue];
            NSInteger b =[str integerValue];
            if (a < [str integerValue]) {
                self.time= a;
                   self.time2 = a;
            }else{
                self.time= b;
                   self.time2 = b;
            }
        }else{
            self.time = [str integerValue];
             self.time2 = [str integerValue];
            int num = arc4random()%2;
             self.time3 = [str integerValue]/(num + 2);
        }
    }else{
        self.time = [str integerValue];
        self.time2 = [str integerValue];
        int num = arc4random()%2;
         self.time3 = [str integerValue]/(num + 2);
    }
    
//     [self createtimeview];
    [self createtimeview2];
    [self createtime];
    
  
}

-(void)createview
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
   
    NSString *content = [self.dic valueForKey:@"content"];
    NSDictionary *dic  = [self dictionaryWithJsonString:content];
   
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.leading.trailing.offset(0);
        make.height.mas_equalTo(kScreenHeight);
    }];
    if (dic) {
         _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:[dic valueForKey: @"playUrl"]]];
    }else{
         _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:[self.dic valueForKey: @"url"]]];
    }
   
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
       
        if (dic) {
            CGFloat a = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"height"]] floatValue];
            CGFloat b = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"width"]] floatValue];
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
                [weakself createtime];
            }
            
        }
    };
//    SJEdgeControlButtonItem *titleItem = [_player.defaultEdgeControlLayer.topAdapter itemForTag:SJEdgeControlLayerTopItem_Title];
    
#pragma mark
    
    [self.view addSubview:self.typelabel];
    [self.typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(kRealValue(-150));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(12));
    }];
    if (!klStringisEmpty([self.dic valueForKey: @"author"])) {
         self.typelabel.text =[self.dic valueForKey: @"author"];
    }else{
         self.typelabel.text =@"";
    }
   
    
    [self.view addSubview:self.timelabel];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typelabel.mas_centerY).offset(0);
        make.left.equalTo(self.typelabel.mas_right).offset(kRealValue(12));
    }];
    
    if (!klStringisEmpty([self.dic valueForKey: @"createTime"])) {
        self.timelabel.text =@"";
    }
    
   
    
    
     [self.view addSubview:self.titlelabel];
  
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typelabel.mas_bottom).with.offset(kRealValue(15));
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
    
    //  分享和免责
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     btn.frame = CGRectMake(kRealValue(301), kRealValue(368), kRealValue(60), kRealValue(60));
    [btn addTarget:self action:@selector(shareAct) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setImage:kGetImage(@"组22") forState:0];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kRealValue(13)];
    [self initButton:btn];
    [self.view  addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(mianzeAct)
   forControlEvents:UIControlEventTouchUpInside];
     btn1.frame = CGRectMake(kRealValue(301), kRealValue(450), kRealValue(60), kRealValue(60));
    [btn1 setTitle:@"免责声明" forState:UIControlStateNormal];
    [btn1 setImage:kGetImage(@"组23") forState:0];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:kRealValue(13)];
    [self initButton:btn1];
    [self.view  addSubview:btn1];
    
    
   

    
}
-(void)mianzeAct
{
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/article/mianze.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shareAct
{
    [self showShareAlert];
}
-(void)closeshareAlet
{
    [self.qiandaoPopView3 dismiss];
}
-(void)showShareAlert
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgview.backgroundColor = KClearColor;
    
//    UITapGestureRecognizer *closealert = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeshareAlet)];
//    [bgview addGestureRecognizer:closealert];
    
    UIView *layview = [[UIView alloc]init];
    layview.backgroundColor = KColorFromRGB(0xffffff);
    layview.layer.cornerRadius = 5;
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


-(UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



-(void)shareActToOther:(UITapGestureRecognizer *)sender
{
    if (self.shareArr.count > 0) {
        HSBannerModel *model = [self.shareArr objectAtIndex:sender.view.tag];
        if ([model.actionUrl rangeOfString:@"?"].location !=NSNotFound) {
            //&
            NSData *data = [[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"id"]] dataUsingEncoding:NSUTF8StringEncoding];
            NSString *strbase =  [data base64EncodedStringWithOptions:0];
            NSData *data1 = [[self.dic valueForKey:@"tag"] dataUsingEncoding:NSUTF8StringEncoding];
            NSString *strbase1 =  [data1 base64EncodedStringWithOptions:0];
            self.urlStr =  [NSString stringWithFormat:@"%@&id=%@&tag=%@",model.actionUrl, strbase,strbase1];

        }else{
            NSData *data = [[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"id"]] dataUsingEncoding:NSUTF8StringEncoding];
            NSString *strbase =  [data base64EncodedStringWithOptions:0];
            NSData *data1 = [[self.dic valueForKey:@"tag"] dataUsingEncoding:NSUTF8StringEncoding];
            NSString *strbase1 =  [data1 base64EncodedStringWithOptions:0];
            self.urlStr =  [NSString stringWithFormat:@"%@?id=%@&tag=%@",model.actionUrl, strbase,strbase1];
        }
        if ([model.name isEqualToString:@"微博"]) {
              if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
           
            
            [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_Sina title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:self.urlStr currentViewController:self success:^{
                
                [self.qiandaoPopView3 dismiss];
//                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                    if (ValidResponseDict(response)) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                        [self getdata];
//                    }else{
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//
//                    }
//                    if (error) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                    }
//
//                }];
                
                
            } fail:^{
                
                
            }];
              }else{
                  KLToast(@"微博未安装，请先下载安装");
              }
        }
        if ([model.name isEqualToString:@"微信"]) {
            
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {

            [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_WechatSession title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:self.urlStr currentViewController:self success:^{
                
                [self.qiandaoPopView3 dismiss];
//                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                    if (ValidResponseDict(response)) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                        [self getdata];
//                    }else{
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//
//                    }
//                    if (error) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                    }
//
//                }];
                
                
            } fail:^{
                
                
            }];
            }else{
                KLToast(@"微信未安装，请先下载安装");
            }
            
        }
        if ([model.name isEqualToString:@"朋友圈"]) {
            
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                
         
            
            [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:self.urlStr currentViewController:self success:^{
                
                [self.qiandaoPopView3 dismiss];
//                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                    if (ValidResponseDict(response)) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                        [self getdata];
//                    }else{
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//
//                    }
//                    if (error) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                    }
//
//                }];
                
                
            } fail:^{
                
                
            }];
            }else{
                KLToast(@"微信未安装，请先下载安装");
            }
        }
        if ([model.name isEqualToString:@"QQ"]) {
            
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                
           
            [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_QQ title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:self.urlStr currentViewController:self success:^{
                
                [self.qiandaoPopView3 dismiss];
//                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                    if (ValidResponseDict(response)) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                        [self getdata];
//                    }else{
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//
//                    }
//                    if (error) {
//                        [self.qiandaoPopView3 dismiss];
//                        KLToast(response[@"message"]);
//                    }
//
//                }];
                
                
            } fail:^{
                
                
            }];
            }else{
                  KLToast(@"QQ未安装，请先下载安装");
            }
            
        }
        if ([model.name isEqualToString:@"QQ空间"]) {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                [[MHBaseClass sharedInstance] shareWebPageToPlatformType:UMSocialPlatformType_Qzone title:@"未来商市" desc:[self.dic valueForKey:@"title"] shareUrl:self.urlStr currentViewController:self success:^{
                    
                    [self.qiandaoPopView3 dismiss];
//                    [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[self.dic valueForKey:@"userTaskId"] completionBlock:^(NSDictionary *response, NSError *error) {
//                        if (ValidResponseDict(response)) {
//                            [self.qiandaoPopView3 dismiss];
//                            KLToast(response[@"message"]);
//                            [self getdata];
//                        }else{
//                            [self.qiandaoPopView3 dismiss];
//                            KLToast(response[@"message"]);
//
//                        }
//                        if (error) {
//                            [self.qiandaoPopView3 dismiss];
//                            KLToast(response[@"message"]);
//                        }
//
//                    }];
                    
                    
                } fail:^{
                    
                    
                }];
            }else{
                 KLToast(@"应用未安装，请先下载安装");
            }
            
            
        }
    }
    
    
    
}

-(void)CloseshareAct
{
    [self.qiandaoPopView3 dismiss];
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
//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)btn{
    float  spacing = kRealValue(10);//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
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

-(void)backAct
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createtimeview2
{
    self.bgviewtime = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(70), kRealValue(530), kRealValue(60), kRealValue(60))];
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
-(void)createtimeview
{

    self.bgview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(120),  30 + kTopHeight - 64, kRealValue(100), kRealValue(26))];
    self.bgview.image = kGetImage(@"d_time_icon");
    self.bgview.hidden = YES;
    [self.view addSubview:self.bgview];
    
    self.showTimeLabel = [[UILabel alloc]init];
    self.showTimeLabel.backgroundColor = [UIColor clearColor];
    self.showTimeLabel.textColor = KColorFromRGB(0xffffff);
    self.showTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.showTimeLabel.text = @"";
    self.showTimeLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    [self.bgview addSubview:self.showTimeLabel];
    [self.showTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgview.mas_centerY);
        make.left.equalTo(self.bgview.mas_left).offset(kRealValue(30));
    }];
    
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
-(UILabel *)typelabel
{
    if (!_typelabel) {
        _typelabel = [[UILabel alloc]init];
        _typelabel.textAlignment = NSTextAlignmentCenter;
        _typelabel.textColor = KColorFromRGB(0xffffff);
        _typelabel.text = @"";
        _typelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        //        _typelabel.layer.cornerRadius = kRealValue(3);
        //        _typelabel.layer.borderColor = KColorFromRGB(0xe91111).CGColor;
        //        _typelabel.layer.borderWidth = 1/kScreenScale;
    }
    return  _typelabel;
}
-(UILabel *)authlabel
{
    if (!_authlabel) {
        _authlabel = [[UILabel alloc]init];
        _authlabel.textAlignment = NSTextAlignmentCenter;
        _authlabel.textColor = KColorFromRGB(0x999999);
        _authlabel.text = @"";
        _authlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        
    }
    return  _authlabel;
}
-(UILabel *)timelabel
{
    if (!_timelabel) {
        _timelabel = [[UILabel alloc]init];
        _timelabel.textAlignment = NSTextAlignmentCenter;
        _timelabel.textColor = KColorFromRGB(0xFFFFFF);
        _timelabel.text = @"15分钟前";
        _timelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        
    }
    return  _timelabel;
}
-(UIView *)lineview
{
    if (!_lineview) {
        _lineview = [[UIView alloc]init];
        _lineview.backgroundColor = KColorFromRGB(0xf3f3f3);
    }
    return _lineview;
}
- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.backgroundColor = [UIColor whiteColor];//该透明色设置不会影响子视图
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"left_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 25 + kTopHeight - 64, 33, 33);
        backButton.adjustsImageWhenHighlighted = NO;
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _titleLabel.textColor = KColorFromRGB(0x000000);
        _titleLabel.text = @"资讯详情";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
}

-(void)createview1
{
    [self.view addSubview:self.tableView];
    
    if (!self.webView) {
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
        self.webView.scrollView.scrollEnabled = NO;
        self.tableView.tableHeaderView = self.webView;
        
        //开了支持滑动返回
        self.webView.allowsBackForwardNavigationGestures = YES;
        
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
        self.progressView.trackTintColor = [UIColor colorWithHexString:@"#EBEBEB"];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#FD541B"];
        [self.webView addSubview:self.progressView];
        
        // 给webview添加监听
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //调用JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"callTelphone"];//移除导航栏
    [configuration.userContentController addScriptMessageHandler:self name:@"jumpToProductDetailWithID"];
    [configuration.userContentController addScriptMessageHandler:self name:@"JumpToShopList"];
    [configuration.userContentController addScriptMessageHandler:self name:@"jsToNativeCode"];//移除导航栏
    [configuration.userContentController addScriptMessageHandler:self name:@"jsToNative"];
     [configuration.userContentController addScriptMessageHandler:self name:@"updateNow"];
     [configuration.userContentController addScriptMessageHandler:self name:@"goToLogin"];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
   
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.dic valueForKey:@"content"]]];
    request.timeoutInterval = 20;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
   
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    MHLog(@"%@--%@",message.name,message.body);
    if ([message.name isEqualToString:@"callTelphone"]) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@",message.body]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if ([message.name isEqualToString:@"jumpToProductDetailWithID"]) {
     
    }
    if ([message.name isEqualToString:@"JumpToShopList"]) {
     
    }
    if ([message.name isEqualToString:@"updateNow"]) {
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.tabBarController setSelectedIndex:2];
        }
       
    }
    if ([message.name isEqualToString:@"goToLogin"]) {
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }else{
            KLToast(@"您已注册");
        }
    }
    
    if ([message.name isEqualToString:@"jsToNativeCode"]) {
        
        if (![GVUserDefaults standardUserDefaults].accessToken) {
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
            return;
        }
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"]) {
            [[MHBaseClass sharedInstance] presentAlertWithtitle:@"升级为会员后才可拥有推广二维码" message:@"" leftbutton:@"确认取消" rightbutton:@"去升级" leftAct:^{
                
            } rightAct:^{
                HSChargeController *vc = [[HSChargeController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }else{
            HSQRcodeVC *vc =[[HSQRcodeVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
    if ([message.name isEqualToString:@"jsToNative"]) {
        
        NSMutableDictionary *dic= message.body;
        self.h5funName =[dic valueForKey:@"successApp"];
        self.respondic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initwithHSWebAriticeinterfaceCode:[dic valueForKey:@"dd"] businessParam:[dic valueForKey:@"jsonId"] weburl:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.respondic = [response valueForKey:@"data"];
                NSString *str1 = (NSString *)[response valueForKey:@"data"] ;
                //                NSDictionary *dic = [self dictionaryWithJsonString:str1];
                //                NSString *finshstr = [self dictionaryToJson:dic];
                //
                NSString *str = [NSString stringWithFormat:@"%@(%@)",self.h5funName,str1];
                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    MHLog(@"%@",error);
                    
                }];
            }else{
                self.respondic = [response valueForKey:@"data"];
                NSString *str1 = [response valueForKey:@"data"] ;
                
                NSString *str = [NSString stringWithFormat:@"%@(\"%@\")",self.h5funName,str1];
                [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    MHLog(@"%@",error);
                    
                }];
            }
            
        }];
        
        //        MHShopViewController *vc = [[MHShopViewController alloc]init];
        //        vc.comeform = @"webview";
        //        //        vc.productId = [NSString stringWithFormat:@"%@",message.body];
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



-(void)createview11
{
    
    [self.view addSubview:self.tableView];
    
    if (!self.webView) {

        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
        self.webView.scrollView.scrollEnabled = NO;
        self.tableView.tableHeaderView = self.webView;
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
        self.progressView.trackTintColor = [UIColor colorWithHexString:@"#EBEBEB"];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"#FD541B"];
        [self.webView addSubview:self.progressView];
        
        // 给webview添加监听
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webView loadHTMLString:[headerString stringByAppendingString:[self.dic valueForKey:@"content"]] baseURL:nil];
    //    [self.webView loadHTMLString:htmlstr baseURL:nil];
    self.webView.navigationDelegate = self;

    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
   
}
-(void)createview2
{
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight,kScreenWidth, kScreenHeight-kBottomHeight-kTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       
  
        [_tableView registerClass:[HSAriiceShareCell class] forCellReuseIdentifier:NSStringFromClass([HSAriiceShareCell class])];
        [_tableView registerClass:[HSEmporCell class] forCellReuseIdentifier:NSStringFromClass([HSEmporCell class])];
        [_tableView registerClass:[HSNewsOneCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsOneCell class])];
        [_tableView registerClass:[HSNewTwoCell class] forCellReuseIdentifier:NSStringFromClass([HSNewTwoCell class])];
        [_tableView registerClass:[HSNewsThirdCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsThirdCell class])];
        [_tableView registerClass:[HSNewsFourCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsFourCell class])];
        [_tableView registerClass:[HSNewsSixCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsSixCell class])];
        
      
        
        
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
        
        if (indexPath.row == 0) {
             return   kRealValue(165);
        }
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row-1];
        if (klDicisEmpty(model.extra)) {
            if ([model.articleType isEqualToString:@"ARTICLE"]) {
                //文章
                if (model.cover.count == 0 ) {
                    
                    return kRealValue(55) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                }
                if (model.cover.count>1 ) {
                    
                    
                    return   kRealValue(133) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                }
                
                return kRealValue(270) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
            if ([model.articleType isEqualToString:@"VIDEO"]) {
                
                
                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)] > 50) {
                    return   kRealValue(270) + kRealValue(47);
                }
                return   kRealValue(270) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
            if ([model.articleType isEqualToString:@"ADV"]) {
                //广告
                return    kRealValue(270) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
        }
    }
    
    return   kRealValue(165);
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArr.count > 0 ) {
      return  self.listArr.count+1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.listArr.count > 0 ) {
       
        if (indexPath.row == 0) {
            HSAriiceShareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSAriiceShareCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.Share = ^{
                [self showShareAlert];
            };
            cell.mianze = ^{
                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/article/mianze.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
                       [self.navigationController pushViewController:vc animated:YES];
            };
           
            return cell;
        }
         HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row-1];
        if (klDicisEmpty(model.extra)) {
            
            
            
            if ([model.articleType isEqualToString:@"ARTICLE"]) {
                //文章
                if (model.cover.count == 0 ) {
                    HSNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:model];
                    return cell;
                }
                if (model.cover.count >1 ) {
                    HSNewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewTwoCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:model];
                    return cell;
                }
                if (model.cover.count == 1) {
                    
                    HSNewsThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsThirdCell class])];
                    [cell createviewWithModel:model];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    return cell;
                }
                
            }
            if ([model.articleType isEqualToString:@"VIDEO"]){
                HSNewsSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsSixCell class])];
                [cell createviewWithModel:model];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                return cell;
            }
          
        }
    }
    
    
    HSAriiceShareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSAriiceShareCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.Share = ^{
        [self showShareAlert];
    };
    cell.mianze = ^{
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/article/mianze.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        
        if (indexPath.row ==0) {
            
        }else{
           
            HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row-1];
            
            if (klDicisEmpty(model.extra)) {
                
                
                HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row-1];
                
                vc.ariticeID =model.id;
                if ([model.articleType isEqualToString:@"VIDEO"]) {
                    vc.IsshowTop = YES;
                    
                }else{
                    vc.IsshowTop = YES;
                }
                
                if ([model.tag isEqualToString:@"广告"]) {
                    vc.IsAd = @"ad";
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                MHTaskDetailModel *taskmodel = [MHTaskDetailModel baseModelWithDic:model.extra];
                if ([taskmodel.property isEqualToString:@"REVIEW"]) {
                    //审核任务
                    HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                    [self.navigationController pushViewController:vc animated:YES];
                }else if ([taskmodel.property isEqualToString:@"APPOINT"]){
                    //阅读指定任务
                    
                    
                }else if ([taskmodel.property isEqualToString:@"APPOINT_ADV"]) {
                    //阅读指定广告
                    //                [self getMHTaskDetailModel:taskmodel];
                    
                }else if ([taskmodel.property isEqualToString:@"SHARE"]) {
                    //分享任务
                    
                    HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                    if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                        vc.IsshowTop = YES;
                        
                    }else{
                        vc.IsshowTop = NO;
                    }
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([taskmodel.property isEqualToString:@"DOWNLOAD"]) {
                    //下载任务
                    HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                    if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                        vc.IsshowTop = YES;
                        
                    }else{
                        vc.IsshowTop = NO;
                    }
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([taskmodel.property isEqualToString:@"READ_ADV"]) {
                    //阅读广告任务
                    
                    
                }else if ([taskmodel.property isEqualToString:@"READ"]) {
                    //阅读广告任务
                    //下载任务
                    HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                    vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                    if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                        vc.IsshowTop = YES;
                        
                    }else{
                        vc.IsshowTop = NO;
                    }
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
                
            }
            
        }
        
        
    }
    
}





- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.player) {
         [self.player vc_viewDidAppear];
    }
   
}




- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

#pragma mark 屏幕触碰时间检测
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
   
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        if (self.stopLinetime > 0) {
            
        }else{
            MHLog(@"继续计算时间");
            self.stopLinetime =  5 ;;
            if (self.time > 0 ) {
                [self createtime];
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
            self.stopLinetime =  self.time3 ;;
            if (self.time > 0 ) {
                 [self createtime];
            }
           
            
        }
    }
   
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}
#pragma mark
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.title = @"加载中..";
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \} \
    }";
    
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [self.webView evaluateJavaScript:js completionHandler:nil];
    [self.webView evaluateJavaScript:@"imgAutoFit()" completionHandler:nil];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = @"文章详情";
   
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self.webView.frame=CGRectMake(0, 0, self.view.width, [result doubleValue]+ 10);//将WKWebView的高度设置为内容高度
        //刷新制定位置Cell
         self.tableView.tableHeaderView = webView;
    }];
    self.lauchbgView.hidden = YES;
    // 设置字体
//    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='PingFangSC-Light';";
//    [self.webView evaluateJavaScript:fontFamilyStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        
//    }];
 
    
   
   


}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
// 页面加载失败时调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.title = @"加载失败";
    [MBProgressHUD showActivityMessageInWindow:@"加载失败"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    self.title = webView.title;
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}




- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
