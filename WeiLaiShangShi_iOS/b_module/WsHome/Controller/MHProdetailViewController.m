//
//  MHProdetailViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHProdetailViewController.h"
#import "MHProductDetailHeadCell.h"
#import "MHProdesCell.h"
#import "MHProImagesCell.h"
#import "MHProductDetailModel.h"
#import "MHProductPicModel.h"
//#import "MHSumbitOrderVC.h"
#import "MHLoginViewController.h"
#import "MHProductDetailCellHead.h"
#import "MHShopCarSizeAlert.h"
#import "MHProductDetailBottomView.h"
#import "MHShopCarViewController.h"
@interface MHProdetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel            *_titleLabel;
    UIImageView         *_headImageView;
}
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)MHProductDetailHeadCell *cell;
@property (nonatomic, strong)NSString *skuId;
@property (nonatomic, strong)NSString *amount;
@property (nonatomic, strong)NSString *activityId;
@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableArray *Lunboarr;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) UIView        *naviView;//自定义导航栏
@property (nonatomic, strong)MHShopCarSizeAlert *aler;
@property (nonatomic, strong)MHProductDetailBottomView *viewbottom;


@end

@implementation MHProdetailViewController


-(void)getNetwork
{
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance] initwithProductId:self.productId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
           
            self.dic = (NSMutableDictionary *) [MHProductDetailModel baseModelWithDic:[response valueForKey:@"data"]];
            
            self.dict =[NSMutableDictionary dictionaryWithDictionary:[response valueForKey:@"data"]];
            [self createview];
            [self.view addSubview:self.naviView];
            self.Lunboarr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productImages"]];
            self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productBigImage"]];
            if ([[NSString stringWithFormat:@"%@",[self.dict valueForKey:@"collected"]]  isEqualToString:@"0"]) {
                self.viewbottom.Collectbtn.selected = NO;
            }else{
                self.viewbottom.Collectbtn.selected = YES;
            }
            [self.tableView reloadData];
            
        }
        [MBProgressHUD hideHUD];
       
    }];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.fd_prefersNavigationBarHidden = YES;
    
    
    [self getNetwork];
   
    // Do any additional setup after loading the view.
}
-(void)createview
{
    kWeakSelf(self);
     [self.view addSubview:self.tableView];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:43210] removeFromSuperview];
    self.aler = [[MHShopCarSizeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) height:kRealValue(400) data:self.dict];
    self.aler.tag = 43210;
    
    self.aler.changeName = ^(NSString *str) {
        if (!klStringisEmpty(str)) {
            NSString *str1 = [str substringFromIndex:1];
            NSDictionary *dataDic = [NSDictionary dictionaryWithObject:str1 forKey:@"info"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
        }
        
        
    };
    self.aler.makesureAct = ^(NSString *productId, NSString *skuId, NSString *amount) {
        MHLog(@"shopcar productId = %@ \n skuId = %@ \n amount = %@ \n",productId, skuId,amount);
        weakself.productId = productId;
        weakself.skuId = skuId;
        weakself.amount = amount;
        
        
    };
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.aler];
    
  
    
            self.viewbottom = [[MHProductDetailBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight- kRealValue(50) - kBottomHeight , kScreenWidth, kRealValue(50))];

        
        if ([[NSString stringWithFormat:@"%@",[self.dict valueForKey:@"collected"]]  isEqualToString:@"0"]) {
            self.viewbottom.Collectbtn.selected = NO;
        }else{
            self.viewbottom.Collectbtn.selected = YES;
        }
        //联系客服
        self.viewbottom.productDetailBottomViewContact = ^(NSString *productID) {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-051-8180"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        };
        //收藏
        self.viewbottom.productDetailBottomViewCollect = ^(BOOL select) {
            
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                [[MHUserService sharedInstance]initwithCommentProductId:[weakself.dict valueForKey:@"productId"] collected:[NSString stringWithFormat:@"%d",!select]  completionBlock:^(NSDictionary *response, NSError *error) {
                    weakself.viewbottom.Collectbtn.selected = !select;
                    if (select == NO) {
                        KLToast(@"收藏成功");
                    }else{
                        KLToast(@"取消收藏成功");
                    }
                }];
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [weakself presentViewController:userNav animated:YES completion:nil];
            }
            
        };
        // 去购物车界面
        self.viewbottom.productDetailBottomViewGoshopCar = ^(NSString *productID) {
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                MHShopCarViewController *vc = [[MHShopCarViewController alloc]init];
                vc.IsComeFromdetail = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [weakself presentViewController:userNav animated:YES completion:nil];
            }
            
        };
        
        
        //添加购物车
        self.viewbottom.productDetailBottomVieAddShopCar = ^(NSString *productID, NSString *brandID) {
            //
            
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                NSMutableArray *arr1 = [NSMutableArray arrayWithArray:[weakself.dict valueForKey:@"skuList"]];
                if (arr1.count >1) {
                    //当规格有多种的时候让选择
                    [weakself.aler showAlertwithShopCar:1];
                }else{
                    //只有一种直接加入购物车
                    if (arr1.count >0) {
                        [weakself.aler showAlertwithShopCar:1];
                        
                    }else{
                        KLToast(@"暂无商品规格")
                    }
                    
                }
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [weakself presentViewController:userNav animated:YES completion:nil];
            }
            
            
        };
        
        
        
        [self.view addSubview:self.viewbottom];
        //立即购买
        self.viewbottom.productDetailBottomVieBuynow = ^(NSString *productID, NSString *brandID) {
            
            
            if ( [weakself.viewbottom.Buybtn.titleLabel.text isEqualToString:@"立即分享"]) {
                [weakself showShareAlert];
                return ;
            }
            
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                NSMutableArray *arr1 = [NSMutableArray arrayWithArray:[weakself.dict valueForKey:@"skuList"]];
                if (arr1.count >1) {
                    //当规格有多种的时候让选择
                    [weakself.aler showAlertwithShopCar:2];
                }else{
                    //只有一种直接买
                    if (arr1.count >0) {
                        [weakself.aler showAlertwithShopCar:2];
                    }else{
                        KLToast(@"暂无商品规格")
                    };
                    
                }
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [weakself presentViewController:userNav animated:YES completion:nil];
            }
            
        };
    
}
-(void)showShareAlert
{
    
}

-(void)buynowAct{
    
    if ([GVUserDefaults standardUserDefaults].accessToken) {
//        MHSumbitOrderVC *vc = [[MHSumbitOrderVC alloc] init];
//        vc.arr = @[@{@"productId":self.productId,@"productNum":@"1"}];;
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
   
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[MHProductDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHProductDetailHeadCell class])];
        [_tableView registerClass:[MHProdesCell class] forCellReuseIdentifier:NSStringFromClass([MHProdesCell class])];
        [_tableView registerClass:[MHProImagesCell class] forCellReuseIdentifier:NSStringFromClass([MHProImagesCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(110) + kRealValue(76);
    }
    if (indexPath.row == 1) {
        if (!klStringisEmpty([self.dic valueForKey:@"productSubtitle"])) {
            CGRect rect = [[self.dic valueForKey:@"productSubtitle"] boundingRectWithSize:CGSizeMake(kRealValue(264), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
            if (rect.size.height < kRealValue(30)) {
                return kRealValue(60);
            }else{
                return rect.size.height+ kRealValue(20);
            }
        }
   
        return kRealValue(95);
    }
    if (indexPath.row == 2) {
      
        NSInteger btnoffset = 50;
        for (int i = 0; i < self.PicArr.count; i++) {
           
            MHProductPicModel *model = [self.PicArr objectAtIndex:i];
            
            btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
           
        }
        
        return kRealValue(btnoffset);
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductDetailHeadCell class])];
        self.cell.selectionStyle= UITableViewCellSelectionStyleNone;
        self.cell.dic  = self.dic;
        self.cell.bannerArr =self.Lunboarr;
        self.cell.choseePropertyView.RightitleLabel.text = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"productStandard"]];
        return self.cell;
    }
    if (indexPath.row == 1) {
        MHProdesCell *ProdesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProdesCell class])];
        ProdesCell.selectionStyle= UITableViewCellSelectionStyleNone;
        ProdesCell.labeldetail1.text = [self.dic valueForKey:@"productSubtitle"];
        return ProdesCell;
    }
    if (indexPath.row == 2) {
        MHProImagesCell *ImagesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProImagesCell class])];
        ImagesCell.selectionStyle= UITableViewCellSelectionStyleNone;
        ImagesCell.PictureArr = self.PicArr;
        return ImagesCell;
    }
    return nil;
   
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
        } else if(yOffset < (kTopHeight+50)){
            alpha = yOffset/(kTopHeight+50);
        }else if(yOffset >= (kTopHeight+50)){
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
        [_naviView addSubview:backButton];
        
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangMedium size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
        _titleLabel.text = @"商品详情";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
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
