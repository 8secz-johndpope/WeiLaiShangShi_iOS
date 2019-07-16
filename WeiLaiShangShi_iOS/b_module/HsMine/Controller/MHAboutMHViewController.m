//
//  MHAboutMHViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAboutMHViewController.h"
#import "MHMineuserInfoCommonViewSecond.h"
#import "MHMineUserInfoCommonView.h"
#import "UIImage+Common.h"
#import "MHWebviewViewController.h"
#import <Photos/PHPhotoLibrary.h>
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"



@interface MHAboutMHViewController ()
@property (nonatomic, strong)UIImageView *savepic ;
@property (nonatomic, strong) ZJAnimationPopView *popView;
@end

@implementation MHAboutMHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于火勺";
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(143), kRealValue(76), kRealValue(90), kRealValue(90))];
    iconView.image = kGetImage(@"logo1");
    iconView.layer.masksToBounds =YES;
    iconView.layer.cornerRadius=10;
    [self.view addSubview:iconView];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(170), kScreenWidth, 30)];
    version.textAlignment = NSTextAlignmentCenter;
    version.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    version.textColor = KColorFromRGB(0x000000);
    NSString *str =APPVERSION;
    version.text = [NSString stringWithFormat:@"未来商市 v%@",str];
    [self.view addSubview:version];
    
    
//    MHMineuserInfoCommonViewSecond *contact = [[MHMineuserInfoCommonViewSecond alloc]initWithFrame:CGRectMake(0, kRealValue(250), kScreenWidth, kRealValue(50)) lefttitle:@"联系火勺" righttitle:@"" rightSubtitle:@"4000603660" istopLine:YES isBottonLine:YES];
//    contact.righttitle.textColor = KColorFromRGB(0xF29F52);
//    [self.view addSubview:contact];
//
//    UITapGestureRecognizer *tapActfuzhi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fuzhiAct)];
//    [contact.righttitle addGestureRecognizer:tapActfuzhi];
//
    
  
    
    MHMineUserInfoCommonView *MHliscen = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(250), kScreenWidth, kRealValue(50)) righttitle:@"《未来商市注册协议》" lefttitle:@"未来商市协议" istopLine:YES isBottonLine:YES];
    [self.view addSubview:MHliscen];
    
    UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MhlisenAct)];
    [MHliscen addGestureRecognizer:tapAct];
    
    
    
    MHMineUserInfoCommonView *gengxinView = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(310), kScreenWidth, kRealValue(50))  righttitle:@"  " lefttitle:@"检查新版本" istopLine:YES isBottonLine:YES];
    [self.view addSubview:gengxinView];
    
    UITapGestureRecognizer *tapAct2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gengxinAct)];
    [gengxinView addGestureRecognizer:tapAct2];
    
    
//    UILabel *company = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(437), kScreenWidth, 20)];
//    company.textAlignment = NSTextAlignmentCenter;
//    company.text = @"陌 狐 官 方 公 众 号";
//    company.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
//    company.textColor = KColorFromRGB(0x666666);
//    [self.view addSubview:company];
//    
//    UILabel *save = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(452), kScreenWidth, 20)];
//    save.textAlignment = NSTextAlignmentCenter;
//    save.text = @"长 按 保 存";
//    save.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
//    save.textColor = KColorFromRGB(0x666666);
//    [self.view addSubview:save];
//    
//    self.savepic = [[UIImageView alloc]init];
////    self.savepic.backgroundColor= kRandomColor;
//    self.savepic.image = kGetImage(@"qrcode");
//    self.savepic.userInteractionEnabled = YES;
//    self.savepic.frame = CGRectMake(kRealValue(143), kRealValue(471), kRealValue(90), kRealValue(90));
//    [self.view addSubview:self.savepic];
//    
//    UILongPressGestureRecognizer *longpan = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPanAct)];
//    [self.savepic addGestureRecognizer:longpan];
    
    UILabel *own = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(571), kScreenWidth, 20)];
    own.textAlignment = NSTextAlignmentCenter;
    own.text = @"版权所有@安徽火勺网络科技有限公司";
    own.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    own.textColor = KColorFromRGB(0x666666);
    [self.view addSubview:own];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)fuzhiAct
{
//    UIPasteboard *copy = [UIPasteboard generalPasteboard];
//    [copy setString:@"400-051-8180"];
//    if (copy == nil )
//    {
//        
//        KLToast(@"复制失败")
//        
//        
//    }else{
//        KLToast(@"复制成功")
//        
//        
//    }
    
}

-(void)gengxinAct{
    
    [self showUpdateView];
    
    
    
}


-(void)showUpdateView{
    
    
    
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
                
                self.popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                // 3.2 显示时背景的透明度
                self.popView.popBGAlpha = 0.5f;
                // 3.3 显示时是否监听屏幕旋转
                self.popView.isObserverOrientationChange = YES;
                // 3.4 显示时动画时长
                self.popView.popAnimationDuration = 0.5f;
                // 3.5 移除时动画时长
                self.popView.dismissAnimationDuration = 0.3f;
                
                // 3.6 显示完成回调
                self.popView.popComplete = ^{
                    MHLog(@"显示完成");
                };
                // 3.7 移除完成回调
                self.popView.dismissComplete = ^{
                    MHLog(@"移除完成");
                };
                [self.popView pop];
                
                
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
                        [self.popView dismiss];
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
                    
                    self.popView = [[ZJAnimationPopView alloc] initWithCustomView:contentViews popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
                    // 3.2 显示时背景的透明度
                    self.popView.popBGAlpha = 0.5f;
                    // 3.3 显示时是否监听屏幕旋转
                    self.popView.isObserverOrientationChange = YES;
                    // 3.4 显示时动画时长
                    self.popView.popAnimationDuration = 0.5f;
                    // 3.5 移除时动画时长
                    self.popView.dismissAnimationDuration = 0.3f;
                    
                    // 3.6 显示完成回调
                    self.popView.popComplete = ^{
                        MHLog(@"显示完成");
                    };
                    // 3.7 移除完成回调
                    self.popView.dismissComplete = ^{
                        MHLog(@"移除完成");
                    };
                    [self.popView pop];
                    
                    
                    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [closeBtn setBackgroundImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
                    [closeBtn bk_addEventHandler:^(id sender) {
                        [self.popView dismiss];
                        
                        
                    } forControlEvents:UIControlEventTouchUpInside];
                    [contentViews addSubview:closeBtn];
                    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(forceUpdateImg.mas_top).with.offset(1);
                        make.right.mas_equalTo(forceUpdateImg.mas_right);
                        make.size.mas_equalTo(CGSizeMake(25, 25));
                    }];
                }else{
                    KLToast(@"当前已是最新版本");
                }
                
            }
            
        }
        
    }];
    
}

-(void)MhlisenAct
{
   MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/zhuce.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)longPanAct
{
    //保存图片
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        // 无权限
        // do something...
        KLToast(@"请先打开相册权限设置");
        return;
    }
    UIImage *image =  [UIImage imageFromView:self.savepic];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    KLToast(@"保存成功");
    MHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
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
