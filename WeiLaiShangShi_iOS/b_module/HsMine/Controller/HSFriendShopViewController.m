//
//  HSFriendShopViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFriendShopViewController.h"
#import "HSFriendShopCell.h"
#import "HSShopItemModel.h"
#import "HSUpPopView.h"
#import "MHWebviewViewController.h"
#import "HSPayResultController.h"
#import "UIAlertView+BlocksKit.h"
#import "HSChargeController.h"
#import "HSQRcodeVC.h"
#import "HSPayStateWebViewController.h"
#import "HSFriendCell.h"
#import "HSFriendHeadReusableView.h"
#import "HSFriendFootReusableView.h"
#import "HSCollectionView.h"
#import "HSChargeListVC.h"

@interface HSFriendShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *shopItemArr;
@property (strong, nonatomic)HSCollectionView *collectionView;
@property (nonatomic,strong)HSFriendHeadReusableView *headerView;
@property (nonatomic,strong)HSFriendFootReusableView *footView;
@property (nonatomic, copy)NSString *nameStr;
@end

@implementation HSFriendShopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"友力值";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"充值记录" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    [self initCollectionView];
    //规则
    [[MHUserService sharedInstance]initwithHSRuleType:@"POWER_RULE" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.nameStr = response[@"data"];
        }
    }];
    //广告
    [[MHUserService sharedInstance]initWithFirstPageComponent:@"5" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *bannerArr = response[@"data"];
            [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                if ([obj[@"type"] isEqualToString:@"FRIEND_INVITE"]) {
                    NSArray *picArr = obj[@"result"];
                    [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.headerView.yaoqing sd_setImageWithURL:[NSURL URLWithString:obj[@"sourceUrl"]]];
                    }];
                }
            }];
        }
    }];
    
    self.shopItemArr = [NSMutableArray array];

    //个人信息接口
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.headerView.stateLabel.text = [NSString stringWithFormat:@"账号余额：%@火币",response[@"data"][@"withdrawIntegral"]];
            self.headerView.ylzLabel.text = response[@"data"][@"availablePower"];
            self.headerView.allLabel.text = response[@"data"][@"consumePower"];
        }
    }];
    //兑换比例
    [[MHUserService sharedInstance]initWithHSbiliCharge:@"POWER" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            CGFloat power = [response[@"data"] floatValue];
            self.headerView.descLabel.text = [NSString stringWithFormat:@"(%.f火币兑换1友力值)",1/power];
        }
    }];

    //友利值列表
    [[MHUserService sharedInstance]initwithHSProdList:@"POWER" pageIndex:1 pageSize:50 categoryId:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.shopItemArr = [HSShopItemModel baseModelWithArr:response[@"data"]];
            [self.collectionView reloadData];
        }
        
    }];
}


-(void)withDrawListClick{
    //充值记录
    HSChargeListVC  *vc = [[HSChargeListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark initCollection
- (void) initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kRealValue(172),kRealValue(173));
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, kRealValue(388));
    //设置headerView大小
    layout.footerReferenceSize = CGSizeMake(kScreenWidth, kRealValue(440));
    self.collectionView = [[HSCollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,kScreenHeight - kTopHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.collectionView registerClass:[HSFriendCell class] forCellWithReuseIdentifier:@"HSFriendCell"];
    [self.collectionView registerClass:[HSFriendHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [self.collectionView registerClass:[HSFriendFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
}

#pragma collectionview delegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.shopItemArr count];;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HSFriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HSFriendCell" forIndexPath:indexPath];
    if (self.shopItemArr.count >0 ) {
        [cell createModel:self.shopItemArr[indexPath.item]];
    }
    return cell;
    
}
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
     return[scan scanInt:&val] && [scan isAtEnd];
    
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    kWeakSelf(self);
    if (kind == UICollectionElementKindSectionHeader){
      self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        self.headerView.exchargeClick = ^(NSString * _Nonnull money) {
            if (!ValidStr(money)) {
                KLToast(@"请输入兑换数额");
            }else{
                if (![weakself isPureInt:money]) {
                     KLToast(@"请输入整数");
                     return ;
                }
                
                
                [[MHUserService sharedInstance]initWithHSReChargeYLZ:money CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        if ([response[@"data"][@"status"] integerValue] == 1) {
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:[NSString stringWithFormat:@"兑换%@友利值需要消耗%@火币，确认兑换？",response[@"data"][@"power"],response[@"data"][@"integral"]]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"确认兑换"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  [[MHUserService sharedInstance]initWithHSChargeYLZ:response[@"data"][@"power"] CompletionBlock:^(NSDictionary *response, NSError *error) {
                                                                                      if (ValidResponseDict(response)) {
                                                                                          KLToast(@"兑换成功");
                                                                                          [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
                                                                                              if (ValidResponseDict(response)) {
                                                                                                  self.headerView.stateLabel.text = [NSString stringWithFormat:@"账号余额：%@火币",response[@"data"][@"withdrawIntegral"]];
                                                                                                  self.headerView.ylzLabel.text = response[@"data"][@"availablePower"];
                                                                                                  self.headerView.allLabel.text = response[@"data"][@"consumePower"];
                                                                                              }
                                                                                          }];
                                                                                      }
                                                                                  }];

                                                                              }
                                                                          }];
                            
                            [alertView show];
                        } else {
                            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                    message:[NSString stringWithFormat:@"余额不足，当前可用火币为%@火币，可兑换%@友利值，确认兑换?",response[@"data"][@"integral"],response[@"data"][@"power"]]
                                                                          cancelButtonTitle:@"取消"
                                                                          otherButtonTitles:@[@"确认兑换"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                              if (buttonIndex == 1)
                                                                              {
                                                                                  [[MHUserService sharedInstance]initWithHSChargeYLZ:response[@"data"][@"power"] CompletionBlock:^(NSDictionary *response, NSError *error) {
                                                                                      if (ValidResponseDict(response)) {
                                                                                          KLToast(@"兑换成功");
                                                                                          [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
                                                                                              if (ValidResponseDict(response)) {
                                                                                                  self.headerView.stateLabel.text = [NSString stringWithFormat:@"账号余额：%@火币",response[@"data"][@"withdrawIntegral"]];
                                                                                                  self.headerView.ylzLabel.text = response[@"data"][@"availablePower"];
                                                                                                  self.headerView.allLabel.text = response[@"data"][@"consumePower"];
                                                                                              }
                                                                                          }];
                                                                                      }
                                                                                  }];

                                                                              }
                                                                          }];
                            
                            [alertView show];
                        }
                    }else{
                        KLToast(response[@"message"]);
                    }
                }];
            }
            
        };
       
         self.headerView.imageClick= ^{
            [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    if ([response[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                        
                        UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                                message:@"升级会员后即可邀请好友"
                                                                      cancelButtonTitle:@"取消"
                                                                      otherButtonTitles:@[@"去升级"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                          if (buttonIndex == 1)
                                                                          {
                                                                              HSChargeController *vc = [[HSChargeController alloc] init];
                                                                              [self.navigationController pushViewController:vc animated:YES];
                                                                          }
                                                                      }];
                        
                        [alertView show];
                    }else{
                        
                        HSQRcodeVC *vc = [[HSQRcodeVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
            }];
            
        };
        reusableView = self.headerView;

    }else{
        
       self.footView  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        reusableView = self.footView;
    }
    return reusableView;

}



-(void)setFootView:(HSFriendFootReusableView *)footView{
    _footView  = footView;
    _footView.subtitleLabel.text = self.nameStr;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if ([response[@"data"][@"userRole"] isEqualToString:@"ORD"]) {
                
                UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                                                        message:@"升级会员才可购买友力值"
                                                              cancelButtonTitle:@"取消"
                                                              otherButtonTitles:@[@"去升级"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                  if (buttonIndex == 1)
                                                                  {
                                                                      HSChargeController *vc = [[HSChargeController alloc] init];
                                                                      [self.navigationController pushViewController:vc animated:YES];
                                                                  }
                                                              }];
                
                [alertView show];
            }else{
                
                [[MHUserService sharedInstance]initwithHSPayListCompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        NSMutableArray *shopArr = [NSMutableArray array];
                        [shopArr addObject:self.shopItemArr[indexPath.item]];
                        //弹窗
                        HSUpPopView *popView = [[HSUpPopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) shopList:shopArr payList:response[@"data"]];
                        [popView pop];
                        popView.payClick = ^(NSString * _Nonnull payType, NSDictionary * _Nonnull shopDict) {
                            
                            NSMutableArray *listArr = [NSMutableArray array];
                            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                            [dict setObject:@"1" forKey:@"productNum"];
                            
                            [dict setObject:[shopDict valueForKey:@"productId"]  forKey:@"productId"];
                            [listArr addObject:dict];
                            [MBProgressHUD showActivityMessageInWindow:@""];
                            if ([payType isEqualToString:@"YOP"]) {
                                
                                [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"YOP" orderType:[shopDict valueForKey:@"productType"] orderTruePrice:[shopDict valueForKey:@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
                                    [popView dismiss];
                                    [MBProgressHUD hideHUD];
                                    if (ValidResponseDict(response)) {
                                        NSData *data = [[NSData alloc]initWithBase64EncodedString:response[@"data"][@"orderPayParam"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                                        NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSString *urlParam =  [datastr stringByURLDecode];
                                        //                                NSLog(@"%@",urlParam);
                                        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:urlParam comefrom:@"payyop"];
                                        vc.payType = payType;
                                        vc.orderCode=response[@"data"][@"orderCode"];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }else{
                                        KLToast(response[@"message"]);
                                    }
                                }];
                            }else if ([payType isEqualToString:@"ALIPAY"]){
                                
                                [[MHUserService sharedInstance]initwithConfirmProduct:listArr addressId:nil payType:@"ALIPAY" orderType:[shopDict valueForKey:@"productType"] orderTruePrice:[shopDict valueForKey:@"retailPrice"] payPassword:nil completionBlock:^(NSDictionary *response, NSError *error) {
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
                                        
                                    }else{
                                        KLToast(response[@"message"]);
                                    }
                                }];
                            }
                        };
                    }
                }];
                
            }
        }
    }];
    
}




//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    
    return UIEdgeInsetsMake(0, kRealValue(15.5), 0, kRealValue(15.5));;
}

@end
