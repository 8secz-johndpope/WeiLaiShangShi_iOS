//
//  MHPayResultVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/15.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHPayResultVC.h"
#import "MHProductCell.h"
#import "MHOrderDetailViewController.h"
#import "MHProdetailViewController.h"
#import "MHMyOrderViewController.h"
#import "UIImage+Common.h"
#import "MHContinuePayVC.h"

@interface MHPayResultVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView   *contentTableView;
@property (nonatomic, strong)UIImageView        *headView;
@property (nonatomic, strong)NSMutableArray *listArr;

@end

@implementation MHPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    self.fd_interactivePopDisabled = YES;
    [self.view addSubview:self.contentTableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
        }
    }];});

    if ([self.stateStr isEqualToString:@"success"]) {
        if ([self.typeStr isEqualToString:@"zhifubao"]) {
            [[MHUserService sharedInstance]initwithCallBackHostPayResult:self.orderCode CompletionBlock:^(NSDictionary *response, NSError *error) {

            }];
        }
    }

//    [[MHUserService sharedInstance]initwithTypeIdList:@"1" pageSize:@"50" pageIndex:@"1" completionBlock:^(NSDictionary *response, NSError *error) {
//        if (ValidResponseDict(response)) {
//            self.listArr = [MHProductModel baseModelWithArr:response[@"data"][@"list"]];
//            [self.contentTableView reloadData];
//        }
//    }];
    
}


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHProductCell class] forCellReuseIdentifier:NSStringFromClass([MHProductCell class])];
        _contentTableView.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArr count];
}


-(UIView *)headView{
    if (!_headView) {
        
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(261))];
        _headView.image= kGetImage(@"payresult_bg");
        _headView.userInteractionEnabled = YES;
        
        
        UIImageView *bgimageSmallview = [[UIImageView alloc]init];
        bgimageSmallview.userInteractionEnabled = YES;
        bgimageSmallview.frame = CGRectMake(0, kRealValue(50), kRealValue(50), kRealValue(50));
        //        bgimageSmallview.image= kGetImage(@"poster_play_success");
        [_headView addSubview:bgimageSmallview];
        bgimageSmallview.centerX = _headView.centerX;
        
        
        
        
        UILabel *resutrName = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(105), kRealValue(100), kRealValue(20))];
        resutrName.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        resutrName.textColor = [UIColor blackColor];
        
        resutrName.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:resutrName];
        resutrName.centerX = _headView.centerX;
        
        
        
        UILabel *dingdanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(78), kRealValue(135), kScreenWidth, kRealValue(20))];
        dingdanLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        dingdanLabel.textColor = [UIColor colorWithHexString:@"333333"];
        //        dingdanLabel.text = @"陌币奖励：99.99陌币";
        dingdanLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:dingdanLabel];
        dingdanLabel.centerX = _headView.centerX;
        
        if ([self.stateStr isEqualToString:@"success"]) {
            
            bgimageSmallview.image= kGetImage(@"poster_play_success");
            resutrName.text = @"支付成功";
            dingdanLabel.text = @"";
//            if ([[GVUserDefaults standardUserDefaults].userRole integerValue]  == 1) {
//                dingdanLabel.text = [NSString stringWithFormat:@"订单号：%@",_orderCode];
//            }else{
//
//                dingdanLabel.text = @"";
//            }
            
        }else{
            bgimageSmallview.image= kGetImage(@"poster_play_fail");
            resutrName.text = @"支付失败";
            dingdanLabel.text = @"";
//            dingdanLabel.text = [NSString stringWithFormat:@"订单号：%@",_orderCode];
        }
        
        
        UIButton  *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(46), kRealValue(182), kRealValue(130), kRealValue(34))];
        leftBtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [leftBtn setTitleColor:[UIColor colorWithHexString:@"#434343"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"ic _ play _ ic_success_home"] forState:UIControlStateNormal];
        if ([self.stateStr isEqualToString:@"success"]) {
            [leftBtn setTitle:@"继续购物" forState:UIControlStateNormal];
        }else{
            [leftBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        }
        
        [leftBtn addTarget: self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, leftBtn.titleLabel.bounds.size.width-kRealValue(10), 0, -leftBtn.titleLabel.bounds.size.width)];
        [leftBtn setImageEdgeInsets:   UIEdgeInsetsMake(0, - leftBtn.imageView.image.size.width +kRealValue(10), 0, leftBtn.imageView.image.size.width)];
        ViewBorderRadius(leftBtn, 4, 1/kScreenScale, [UIColor colorWithHexString:@"#666666"]);
        [_headView addSubview:leftBtn];
        
        
        
        UIButton  *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(199), kRealValue(182), kRealValue(130), kRealValue(34))];
        rightBtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [rightBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"ic _ play _ ic_success_order"] forState:UIControlStateNormal];
        rightBtn.backgroundColor = [UIColor colorWithHexString:@"#FF5100"];
        if ([self.stateStr isEqualToString:@"success"]) {
            [rightBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        }else{
            [rightBtn setTitle:@"继续支付" forState:UIControlStateNormal];
        }
        
        [rightBtn addTarget: self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, rightBtn.titleLabel.bounds.size.width-kRealValue(10), 0, -rightBtn.titleLabel.bounds.size.width)];
        [rightBtn setImageEdgeInsets:   UIEdgeInsetsMake(0, - rightBtn.imageView.image.size.width +kRealValue(10), 0, rightBtn.imageView.image.size.width)];
        ViewBorderRadius(rightBtn, 4, 1/kScreenScale, [UIColor colorWithHexString:@"#FF5100"]);
        [_headView addSubview:rightBtn];
        
    }
    return _headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(280);
    
}


-(void)leftBtnClick{
    if ([self.stateStr isEqualToString:@"success"]) {
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
        vc.orderId  = _orderId;
        vc.type =  @"desc";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


-(void)rightBtnClick{
    if ([self.stateStr isEqualToString:@"success"]) {
        MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
        vc.orderId  = _orderId;
        vc.type =  @"desc";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHContinuePayVC *vc = [[MHContinuePayVC alloc]init];
        MHMyOrderListModel *model = [[MHMyOrderListModel alloc] init];
        model.commissionProfit = self.commissionProfit;
        model.orderCode = self.orderCode;
        model.orderType = self.orderType;
        model.orderId = self.orderId;
        model.orderTruePrice = self.orderTruePrice;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductCell class])];
    [cell creatModel:self.listArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MHProductModel *model = self.listArr[indexPath.row];
//    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
//    vc.productId = model.productId;
//    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)backBtnClicked{

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MHProdetailViewController class]]) {
            MHProdetailViewController *revise =(MHProdetailViewController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
            return;
        }
        if ([controller isKindOfClass:[MHMyOrderViewController class]]) {
            MHMyOrderViewController *revise =(MHMyOrderViewController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
            return;
        }

    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
