//
//  MHCustomerServiceVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHCustomerServiceVC.h"
#import "MHOrderProCell.h"
#import "MHCoustFootView.h"
#import "MHSumbitModel.h"
#import "MHSumbitProView.h"

@interface MHCustomerServiceVC ()<UITableViewDataSource,UITableViewDelegate,YYTextViewDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) MHCoustFootView *footView;
@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic,strong)  NSMutableArray  *shopArr;

@end

@implementation MHCustomerServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请售后";
    self.view.backgroundColor = [UIColor whiteColor];


    [[MHUserService sharedInstance]initwithServiceInfo:self.model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.resultArr = response[@"data"];
 
            [[MHUserService sharedInstance]initwithorderDetail:self.model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.shopArr  =  [MHSumbitModel baseModelWithArr:response[@"data"][@"shops"]];
                    [self createTableView];
                }
                }];
        }
    }];
}


- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight- kRealValue(44)-kBottomHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kRealValue(80), 0);
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.showsVerticalScrollIndicator = NO;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(110))];
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(67))];
        headImageView.image = kGetImage(@"mine_customSerive");
        headerView.backgroundColor = kBackGroudColor;
        [headerView addSubview:headImageView];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(67), kScreenWidth, kRealValue(42))];
         headLabel.text = @"已购商品";
        headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        headLabel.textColor = [UIColor blackColor];
        [headerView addSubview: headLabel];
        
        
        
        _contentTableView.tableHeaderView = headerView;
       _footView = [[MHCoustFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(450)) withArr:_resultArr];

        //    _sumbitModel.,_sumbitModel.orderSendPrice,_sumbitModel.
        _contentTableView.tableFooterView = _footView;
//        [_contentTableView registerClass:[MHSumbitCouponCell class] forCellReuseIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        [_contentTableView registerClass:[MHOrderProCell class] forCellReuseIdentifier:NSStringFromClass([MHOrderProCell class])];
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        UIButton *commitBtn = [[UIButton alloc] init];
        [commitBtn addTarget:self action:@selector(summbitReult) forControlEvents:UIControlEventTouchUpInside];
        [commitBtn setBackgroundColor:[UIColor whiteColor]];
        ViewBorderRadius(commitBtn, 3, 1, [UIColor colorWithHexString:@"999999"]);
        commitBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [commitBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [self.view addSubview:commitBtn];
        [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(kRealValue(120), kRealValue(28)));
            make.top.equalTo(self.contentTableView.mas_bottom).with.offset(kRealValue(6));
            
        }];
    }
}

-(void)summbitReult{
    
    if ([_footView.dianpuLabel.text isEqualToString:@"请选择"]) {
        KLToast(@"请选择原因");
        return;
    }
    [[MHUserService sharedInstance]initwithCommitService:_model.orderId reason:_footView.dianpuLabel.text serviceType:_footView.select1.hidden?@"RETURN":@"EXCHANGE" description:_footView.textView.text images:@"" orderCode:_model.orderCode completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"申请成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MHSumbitProView *headView  = [[MHSumbitProView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
            MHSumbitModel *model = _shopArr[section];
            headView.titleLabel.text = model.sellerName;
            [headView.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.sellerIcon] placeholderImage:nil];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return kRealValue(110);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHSumbitModel *model = _shopArr[indexPath.section];
    NSDictionary *detailDict  = model.products[indexPath.row];
    MHOrderProCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHOrderProCell class])];
    cell.dataDict = detailDict;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



@end
