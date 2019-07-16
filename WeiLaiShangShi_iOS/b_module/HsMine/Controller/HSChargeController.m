//
//  HSChargeController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSChargeController.h"
#import "HSRechargCell.h"
#import "HSRechargListCell.h"
#import "HSUpPopView.h"
#import "MHWebviewViewController.h"
#import "HSPayResultController.h"
#import "HSHotAllModel.h"
#import "HSChargeTableCell.h"
#import "HSPayStateWebViewController.h"
#import "HSOrderVC.h"
#import "UIAlertView+BlocksKit.h"

@interface HSChargeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property(nonatomic, strong)UIImageView *headimageview;
@property(nonatomic, strong)UIImageView *userleverImage ;
@property(nonatomic, strong)UIImageView *upgradeImage ;
@property(nonatomic, strong)NSDictionary *userDict;
@property(nonatomic, strong)NSArray *payListArr;
@property(nonatomic, strong)NSArray *shopListArr;
@property(nonatomic, strong)NSArray *hotAllList;
@property(nonatomic, strong)NSArray *hotDayList;
@property(nonatomic, strong)UILabel *LoveLabel;
@property(nonatomic, strong)UILabel *username;
@property(nonatomic, strong)UIButton *openRechargBtn;


@end

@implementation HSChargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"会员充值";
    [self.view addSubview:self.contentTableView];
    //总榜
//    [[MHUserService sharedInstance]initwithHSHotAllListCompletionBlock:^(NSDictionary *response, NSError *error) {
//        if (ValidResponseDict(response)) {
//            self.hotAllList = [HSHotAllModel baseModelWithArr:response[@"data"]];
//            //日榜
//            [[MHUserService sharedInstance]initwithHSHotDayListCompletionBlock:^(NSDictionary *response, NSError *error) {
//                if (ValidResponseDict(response)) {
//                    self.hotDayList = [HSHotAllModel baseModelWithArr:response[@"data"]];
//                    [self.contentTableView reloadData];
//                }
//            }];
//        }
//    }];
    
    [[MHUserService sharedInstance]initWithFirstPageComponent:@"8" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            // 银勺  金勺 介绍
  
        }
    }];
    
    
    // 购买
    [[MHUserService sharedInstance]initwithHSProdList:nil pageIndex:1 pageSize:10 categoryId:nil CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.shopListArr = response[@"data"];
            [self.upgradeImage sd_setImageWithURL:[NSURL URLWithString:response[@"data"][0][@"productSmallImage"]] placeholderImage:nil];
            [self.contentTableView reloadData];
        }
    }];
    

    
}


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSRechargCell class] forCellReuseIdentifier:NSStringFromClass([HSRechargCell class])];
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(349))];
        headerView.backgroundColor = [UIColor whiteColor];
        //线
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(339), kScreenWidth, kRealValue(10))];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [headerView addSubview:lineView];
        
        _headimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(20), kRealValue(24), kRealValue(44), kRealValue(44))];
//        _headimageview.backgroundColor = kRandomColor;
        ViewRadius(_headimageview, kRealValue(22));
        [headerView addSubview:_headimageview];
        
        _username = [[UILabel alloc]init];
        _username.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        _username.textColor = [UIColor colorWithHexString:@"#222222"];
        _username.textAlignment = NSTextAlignmentLeft;
//        _username.text =@"22333";
        [headerView addSubview:_username];
        [_username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(11));
            make.top.equalTo(self.headimageview.mas_top).offset(-kRealValue(2));
        }];
        
        _LoveLabel = [[UILabel alloc]init];
        _LoveLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _LoveLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _LoveLabel.textAlignment = NSTextAlignmentLeft;
//        _LoveLabel.text =@"友力值30";
        [headerView addSubview:_LoveLabel];
        [_LoveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(11));
            make.bottom.equalTo(self.headimageview.mas_bottom).offset(kRealValue(2));
        }];
        
        _userleverImage = [[UIImageView alloc]init];
//        _userleverImage.image = kGetImage(@"user_yvip");
        [headerView addSubview:_userleverImage];
        [_userleverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView.mas_right).offset(-kRealValue(20));
            make.centerY.equalTo(self.headimageview.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(77), kRealValue(19)));
        }];
        
        
        _upgradeImage = [[UIImageView alloc]init];
//        _upgradeImage.backgroundColor = kRandomColor;
        [headerView addSubview:_upgradeImage];
        [_upgradeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView.mas_centerX).offset(0);
            make.top.equalTo(self.headimageview.mas_bottom).offset(kRealValue(16));
            make.size.mas_equalTo(CGSizeMake(kRealValue(335), kRealValue(150)));
        }];

        self.openRechargBtn  = [[UIButton alloc] init];
        [self.openRechargBtn addTarget:self action:@selector(openList) forControlEvents:UIControlEventTouchUpInside];
        [self.openRechargBtn setBackgroundImage:kGetImage(@"open_recharg") forState:UIControlStateNormal];
        [headerView addSubview:self.openRechargBtn];
        [self.openRechargBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView.mas_centerX).offset(0);
            make.top.equalTo(self.upgradeImage.mas_bottom).offset(kRealValue(30));
            make.size.mas_equalTo(CGSizeMake(kRealValue(266), kRealValue(53)));
        }];
        
        
        [_contentTableView setTableHeaderView:headerView];
    }
    return _contentTableView;
}


-(void)openList{
    

    
    [[MHUserService sharedInstance]initwithHSPayListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.payListArr = response[@"data"];
            //弹窗
            HSUpPopView *popView = [[HSUpPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) shopList:self.shopListArr payList:self.payListArr];
            [popView pop];
            popView.payClick = ^(NSString * _Nonnull payType, NSDictionary * _Nonnull shopDict) {
                
                NSMutableArray *listArr = [NSMutableArray array];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:@"1" forKey:@"productNum"];
                [dict setObject:shopDict[@"productId"] forKey:@"productId"];
                [listArr addObject:dict];
                [MBProgressHUD showActivityMessageInWindow:@""];
                if ([payType isEqualToString:@"YOP"]) {
                    
                    [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"YOP" orderType:shopDict[@"productType"] orderTruePrice:shopDict[@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                        [popView dismiss];
                        [MBProgressHUD hideHUD];
                        if (ValidResponseDict(response)) {
                            NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                            NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            NSString *urlParam =  [datastr stringByURLDecode];
                            //                        NSLog(@"%@",urlParam);
                            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:urlParam comefrom:@"payyop"];
                            vc.payType = payType;
                            vc.orderCode=response[@"data"][@"orderCode"];
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if([response[@"code"] intValue]== 20616){
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:response[@"message"]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"去支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  HSOrderVC *vc = [[HSOrderVC alloc] init];
                                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                                              }
                                                                          }];
                            
                            [alertView show];
                        }else{
                            KLToast(response[@"message"]);
                        }
                    }];
                }else if ([payType isEqualToString:@"ALIPAY"]){
                    
                    [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"ALIPAY" orderType:shopDict[@"productType"] orderTruePrice:shopDict[@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                        [popView dismiss];
                        [MBProgressHUD hideHUD];
                        if (ValidResponseDict(response)) {
                            
                            NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                            NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            NSString *urlParam =  [datastr stringByURLDecode];
                            
                            [[MHPayClass sharedApi]aliPayWithPayParam:urlParam success:^(payresult code) {
                                if (alipaysuceess ==  code) {
                                    //回调支付宝
                                    HSPayResultController *vc = [[HSPayResultController alloc] init];
                                    vc.orderCode = response[@"data"][@"orderCode"];
                                    vc.payType = payType;
                                    [self.navigationController pushViewController:vc animated:YES];
                                }else{
                                    HSPayResultController *vc = [[HSPayResultController alloc] init];
                                    vc.orderCode = response[@"data"][@"orderCode"];
                                    vc.payType = payType;
                                    [self.navigationController pushViewController:vc animated:YES];
                                }
                            } failure:^(payresult code) {
                                HSPayResultController *vc = [[HSPayResultController alloc] init];
                                vc.orderCode = response[@"data"][@"orderCode"];
                                vc.payType = payType;
                                [self.navigationController pushViewController:vc animated:YES];
                            }];
                            
                        }else if([response[@"code"] intValue]== 20616){
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:response[@"message"]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"去支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  HSOrderVC *vc = [[HSOrderVC alloc] init];
                                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                                              }
                                                                          }];
                            
                            [alertView show];
                        }else{
                            KLToast(response[@"message"]);
                        }
                    }];
                    
                }else if ([payType isEqualToString:@"WECHAT"]){
                    [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"WECHAT" orderType:[shopDict valueForKey:@"productType"] orderTruePrice:[shopDict valueForKey:@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                        [popView dismiss];
                        [MBProgressHUD hideHUD];
                        if (ValidResponseDict(response)) {
                            
                            NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                            NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            NSString *urlParam =  [datastr stringByURLDecode];
                            NSData *jsonData = [urlParam dataUsingEncoding:NSUTF8StringEncoding];
                            NSMutableDictionary *wxDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                            [[MHPayClass sharedApi]wxPayWithPayParam:wxDict success:^(payresult ResultCode) {
                                if (wxsuceess ==  ResultCode) {
                                    HSPayResultController *vc = [[HSPayResultController alloc] init];
                                    vc.orderCode = response[@"data"][@"orderCode"];
                                    vc.payType = payType;
                                    [self.navigationController pushViewController:vc animated:YES];
                                    
                                }else{
                                    HSPayResultController *vc = [[HSPayResultController alloc] init];
                                    vc.orderCode = response[@"data"][@"orderCode"];
                                    vc.payType = payType;
                                    [self.navigationController pushViewController:vc animated:YES];
                                }
                                
                            } failure:^(payresult ResultCode) {
                                
                                HSPayResultController *vc = [[HSPayResultController alloc] init];
                                vc.orderCode = response[@"data"][@"orderCode"];
                                vc.payType = payType;
                                [self.navigationController pushViewController:vc animated:YES];
                            }];
                            
                        }else if([response[@"code"] intValue]== 20616){
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:response[@"message"]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"去支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  HSOrderVC *vc = [[HSOrderVC alloc] init];
                                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                                              }
                                                                          }];
                            
                            [alertView show];
                        }else{
                            KLToast(response[@"message"]);
                        }
                    }];
                    
                    
                }else if ([payType isEqualToString:@"ALIPAY_TRANSFER_FIXED_AMOUNT"]){
                    //支付宝个人转账
                    [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"ALIPAY_TRANSFER_FIXED_AMOUNT" orderType:[shopDict valueForKey:@"productType"] orderTruePrice:[shopDict valueForKey:@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                        [popView dismiss];
                        [MBProgressHUD hideHUD];
                        if (ValidResponseDict(response)) {
                            if ([response[@"data"][@"orderPayType"] isEqualToString:@"H5"]) {
                                NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                NSString *urlParam =  [datastr stringByURLDecode];
                                HSPayStateWebViewController *vc = [[HSPayStateWebViewController alloc]initWithurl:urlParam comefrom:@"ALIPAY_AMOUNT"];
                                vc.payType = payType;
                                vc.orderCode=response[@"data"][@"orderCode"];
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                            
                        }else if([response[@"code"] intValue]== 20616){
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:response[@"message"]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"去支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  HSOrderVC *vc = [[HSOrderVC alloc] init];
                                                                                  [self.navigationController pushViewController:vc animated:YES];
                                                                              }
                                                                          }];
                            
                            [alertView show];
                        }else{
                            KLToast(response[@"message"]);
                        }
                    }];
                }
            };
        }
    }];
    
   
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            //名字
            self.userDict = response[@"data"];
            self.username.text  = response[@"data"][@"nickname"];
            
            //等级
            if ([response[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                self.userleverImage.image = kGetImage(@"user_novip");
            }else if ([response[@"data"][@"userRole"] isEqualToString:@"VIP"]){
                self.userleverImage.image = kGetImage(@"user_yvip");
            }else if ([response[@"data"][@"userRole"] isEqualToString:@"SVIP"]){
                self.userleverImage.image = kGetImage(@"user_vip");
            }
            //头像
            [self.headimageview sd_setImageWithURL:[NSURL URLWithString: response[@"data"][@"avatar"]] placeholderImage:nil];
            self.LoveLabel.text = [NSString stringWithFormat:@"友力值 %@",response[@"data"][@"availablePower"]];
            if ([self.userDict[@"userRole"] isEqualToString:@"ORD"]) {
                self.LoveLabel.hidden = YES;
            }else{
                self.LoveLabel.hidden = NO;
            }
            [GVUserDefaults standardUserDefaults].phone = response[@"data"][@"phone"];
            [self.contentTableView reloadData];
            
        }
    }];
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    if ([self.hotDayList count]>0) {
//        return 2;
//    }else{
//        return 1;
//    }
       return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return  4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
        HSRechargCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSRechargCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"recharge_icon_%ld",indexPath.row]];
        //等级
        if ([self.userDict[@"userRole"] isEqualToString:@"ORD"]) {
            //银
            if (indexPath.row == 0) {
                cell.titlesLabel.text = @"获赠188000积分奖励";
                cell.dingdanLabel.text = @"积分可兑换商品，邀请满6人兑换现金";
            }else if (indexPath.row == 1){
                cell.titlesLabel.text = @"尊享银勺会员专属任务";
                cell.dingdanLabel.text = @"领取银勺会员任务，每日最高可赚188元";
            }else if (indexPath.row ==2){
                cell.titlesLabel.text = @"邀请好友立获15元奖励";
                cell.dingdanLabel.text = @"邀请银勺奖励15元/人，升掌勺再享6元/人返佣";
            }else if (indexPath.row ==3){
                cell.titlesLabel.text = @"好友完成任务得奖励返现";
                cell.dingdanLabel.text = @"可得一级好友20%，二级好友10%的任务奖励";
            }
            
        }else if ([self.userDict[@"userRole"] isEqualToString:@"VIP"]){
            //金
            if (indexPath.row  == 0) {
                cell.titlesLabel.text = @"获赠188000积分奖励";
                cell.dingdanLabel.text = @"积分可兑换商品，邀请满6人兑换现金";
            }else if (indexPath.row == 1){
                cell.titlesLabel.text = @"尊享金勺会员专属任务";
                cell.dingdanLabel.text = @"领取金勺会员任务，每日最高可赚1188元";
            }else if (indexPath.row ==2){
                cell.titlesLabel.text = @"邀请好友立获80元奖励";
                cell.dingdanLabel.text = @"邀请金勺奖励80元/人，升掌勺再享30元/人返佣";
            }else if (indexPath.row ==3){
                cell.titlesLabel.text = @"好友完成任务得奖励返现";
                cell.dingdanLabel.text = @"可得一级好友20%，二级好友10%的任务奖励";
            }
        }else if ([self.userDict[@"userRole"] isEqualToString:@"SVIP"]){
            //金
            if (indexPath.row  == 0) {
                cell.titlesLabel.text = @"获赠188000积分奖励";
                cell.dingdanLabel.text = @"积分可兑换商品，邀请满6人兑换现金";
            }else if (indexPath.row == 1){
                cell.titlesLabel.text = @"尊享金勺会员专属任务";
                cell.dingdanLabel.text = @"领取金勺会员任务，每日最高可赚1188元";
            }else if (indexPath.row ==2){
                cell.titlesLabel.text = @"邀请好友立获80元奖励";
                cell.dingdanLabel.text = @"邀请金勺奖励80元/人，升掌勺再享30元/人返佣";
            }else if (indexPath.row ==3){
                cell.titlesLabel.text = @"好友完成任务得奖励返现";
                cell.dingdanLabel.text = @"可得一级好友20%，二级好友10%的任务奖励";
            }
        }
        return cell;
//    }else{
//        static NSString *cellIdentifier = @"HSChargeTableCell";
//        HSChargeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
//            cell = [[HSChargeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier hotAllList:self.hotAllList hotDayList:self.hotDayList];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }

    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(60))];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
    bgView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:bgView];
    UILabel *titlesLabel = [[UILabel alloc]init];
    titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    titlesLabel.textColor =[UIColor colorWithHexString:@"#222222"];
    if (section == 0) {
      
        if ([self.userDict[@"userRole"] isEqualToString:@"ORD"]) {
            //银
            titlesLabel.text  = @"银勺会员福利";
            
        }else if ([self.userDict[@"userRole"] isEqualToString:@"VIP"]){
            //金
            titlesLabel.text  = @"金勺会员福利";
        }else if ([self.userDict[@"userRole"] isEqualToString:@"SVIP"]){
            //金
            titlesLabel.text  = @"金勺会员福利";
        }
        
    }else{
       titlesLabel.text  = @"会员榜单";
    }
   
    [bgView addSubview:titlesLabel];
    [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(kRealValue(20));
        make.centerX.equalTo(bgView.mas_centerX).with.offset(0);
    }];
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.image = kGetImage(@"pay_Heade_background_left__icon");
    [bgView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(26), kRealValue(22)));
        make.centerY.equalTo(titlesLabel.mas_centerY).with.offset(0);
        make.right.equalTo(titlesLabel.mas_left).with.offset(-kRealValue(8));
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = kGetImage(@"pay_Heade_background_right_icon");
    [bgView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(26), kRealValue(22)));
        make.centerY.equalTo(titlesLabel.mas_centerY).with.offset(0);
        make.left.equalTo(titlesLabel.mas_right).with.offset(kRealValue(8));
    }];
    


//    if (section == 1) {
//        bgView.userInteractionEnabled = YES;
//        headerView.userInteractionEnabled = YES;
//        NSArray *array = [NSArray arrayWithObjects:@"佣金总榜",@"佣金日榜", nil];
//        if (!_segment) {
//            _segment = [[UISegmentedControl alloc]initWithItems:array];
//            _segment.frame = CGRectMake(0, kRealValue(60), kRealValue(220), kRealValue(29));
//            [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
//            _segment.selectedSegmentIndex = 0;
//            _segment.tintColor = [UIColor colorWithHexString:@"#FD7215"];
//        }
//        [bgView addSubview:_segment];
//        _segment.centerX  = bgView.centerX;
//
//    }
    return headerView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(60);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kRealValue(81);
    }else{
        return kRealValue(290);
    }

}


@end
