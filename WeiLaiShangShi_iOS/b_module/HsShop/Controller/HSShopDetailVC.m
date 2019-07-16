//
//  HSShopDetailVC.m
//  HSKD
//
//  Created by AllenQin on 2019/2/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopDetailVC.h"
#import "MHWebviewViewController.h"
#import "SDCycleScrollView.h"
#import "HSDetailTypeTableViewCell.h"
#import "HSShopTableViewCell.h"
#import "HSShopDescCell.h"
#import "HSShopPicCell.h"
#import "HSShopDeatilModel.h"
#import "MHProductPicModel.h"
#import "HSSumbitOrderVC.h"
#import "MHLoginViewController.h"


@interface HSShopDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *contentTableView;
@property(copy,nonatomic)NSString *prodId;
@property(strong,nonatomic)NSMutableArray *picItemArr;
@property(strong,nonatomic)HSShopDeatilModel *detailModel;

@end

@implementation HSShopDetailVC



- (instancetype)initWithProdId:(NSString *)prodId
{
    self = [super init];
    if (self) {
        _prodId = prodId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor  = [UIColor colorWithHexString:@"#F2F2F2"];
    self.picItemArr = [NSMutableArray array];
    //tableview
//
    [[MHUserService sharedInstance]initwithHSShopDetail:self.prodId CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            self.detailModel = [HSShopDeatilModel baseModelWithDic:response[@"data"]];
            //轮播图
            NSArray *picArr = response[@"data"][@"productImages"];
            [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.picItemArr addObject:obj[@"filePath"]];
            }];
            [self createTableView];
            //轮播图
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) delegate:nil placeholderImage:kGetImage(@"emty_movie")];
            cycleScrollView.imageURLStringsGroup = self.picItemArr;
            [self.contentTableView setTableHeaderView:cycleScrollView];
            
            
        }
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 1;
    }
    
    if (section == 3) {
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kRealValue(118);
    }
    if (indexPath.section == 1) {
        return kRealValue(44);
    }
    if (indexPath.section == 2) {
        return [self.detailModel.parameter heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)] width:kRealValue(349)] +kRealValue(26);
    }
    if (indexPath.section == 3) {
        NSArray *picModelArr = [MHProductPicModel baseModelWithArr:self.detailModel.productBigImage];
        NSInteger btnoffset = 0;
        for (int i = 0; i < picModelArr.count; i++) {
            MHProductPicModel *model = [picModelArr objectAtIndex:i];
            btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
    }
        return btnoffset;
    }
     return kRealValue(44);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HSDetailTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSDetailTypeTableViewCell class])];
        [cell creatItemModel:self.detailModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        HSShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSShopTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"商品规格";
            cell.descLabel.text = self.detailModel.productStandard;
        }else if (indexPath.row == 1){
            cell.nameLabel.text = @"快递费用";
            cell.descLabel.text = @"0.00";
        }else {
            cell.nameLabel.text = @"服务保证";
            cell.descLabel.text = @"正品保障 ·快速发货 ·全网最低";
        }
        return cell;
      
    }else if(indexPath.section == 2){
        HSShopDescCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSShopDescCell class])];
        [cell creatItemModel:self.detailModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        static NSString *cellIdentifier = @"HSShopPicCell";
        HSShopPicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HSShopPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier picArr:self.detailModel.productBigImage];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
 
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 ||section == 3) {
        return kRealValue(44);
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2 ||section == 3) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(44))];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(13), 0, kScreenWidth/2, kRealValue(44))];
        descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        descLabel .textColor =[UIColor colorWithHexString:@"#444444"];
        descLabel .numberOfLines = 1;
        if (section == 2) {
          descLabel.text =  @"产品参数";
        }else{
         descLabel.text =  @"图文详情";
        }
        [bgView addSubview:descLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(11), kRealValue(44) - 1/kScreenScale, kScreenWidth - kRealValue(11), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [bgView addSubview:lineView];
        return bgView;
    }else{
        return nil;
    }
}
- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight -kRealValue(49));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSDetailTypeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HSDetailTypeTableViewCell class])];
        [_contentTableView registerClass:[HSShopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HSShopTableViewCell class])];
        [_contentTableView registerClass:[HSShopDescCell class] forCellReuseIdentifier:NSStringFromClass([HSShopDescCell class])];
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        UIView *bttomView = [[UIView alloc] initWithFrame:CGRectMake(0,  kScreenHeight - kTopHeight -kRealValue(49), kScreenWidth, kRealValue(49))];
        bttomView.userInteractionEnabled = YES;
        [self.view addSubview:bttomView];
        
        //客服
        UIButton *kfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRealValue(152), kRealValue(49))];
        [kfBtn setImage:kGetImage(@"shop_icon_service") forState:UIControlStateNormal];
        [kfBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [kfBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [kfBtn addTarget:self action:@selector(kefuSumbit) forControlEvents:UIControlEventTouchUpInside];
        kfBtn.backgroundColor = [UIColor whiteColor];
        kfBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        kfBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        kfBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bttomView addSubview:kfBtn];
        
        //购买
        UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(152), 0, kScreenWidth - kRealValue(152), kRealValue(49))];
        [buyBtn addTarget:self action:@selector(pushSumbit) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.backgroundColor = [UIColor colorWithHexString:@"FF273F"];
        [buyBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [buyBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        [bttomView addSubview:buyBtn];
        
    }
}



-(void)pushSumbit{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        HSSumbitOrderVC *vc = [[HSSumbitOrderVC alloc] init];
        vc.prodId = self.detailModel.productId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }

}

-(void)kefuSumbit{
    //客服
//    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://4000603660"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/waiter.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end








