//
//  HSWalletTodayVC.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletAllView.h"
#import "HSWalletTodayOneCell.h"
#import "HSWalletNomalCell.h"
#import "HSWalletTwoCell.h"
#import "HSRewardController.h"
@interface HSWalletAllView ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UILabel *chargeLabel;
@property(strong,nonatomic)UITableView *contentTableView ;
@property(strong,nonatomic)NSDictionary *dict ;
@property(strong,nonatomic)UIImageView *headerImageView;
@property(strong,nonatomic) UIImageView  *naviView;//自定义导航栏

@end

@implementation HSWalletAllView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kRealValue(183))];
    self.headerImageView.userInteractionEnabled = YES;
    self.headerImageView.image = kGetImage(@"wallet_all_head");
    [self.view addSubview: self.headerImageView];
    [self.view addSubview:self.contentTableView];
        [self.view addSubview:self.naviView];

    
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(27),kRealValue(10), kRealValue(150), kRealValue(30))];
    hotLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    hotLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    hotLabel.textAlignment = NSTextAlignmentLeft;
    [self.headerImageView addSubview:hotLabel];
    
    NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"累计收入（火币）"];
    [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)] range:NSMakeRange(4,4)];
    hotLabel.attributedText = hotStr;
    
    self.chargeLabel = [[UILabel alloc]init];
    self.chargeLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(32)];
    self.chargeLabel.textColor =[UIColor colorWithHexString:@"#FFFFFF"];
    self.chargeLabel.textAlignment = NSTextAlignmentLeft;
    self.chargeLabel.text = @"  ";
    self.chargeLabel.text  = self.allStr;
    [self.headerImageView addSubview: self.chargeLabel];
    [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotLabel.mas_bottom).offset(kRealValue(4));
        make.left.equalTo(self.headerImageView.mas_left).offset(kRealValue(27));
    }];
    
    UILabel *todayDescLabel = [[UILabel alloc] init];
    todayDescLabel.text = @"银勺及以上会员可全额兑换";
    todayDescLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
    todayDescLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.headerImageView addSubview:todayDescLabel];
    [todayDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotLabel.mas_bottom).offset(kRealValue(56));
        make.left.equalTo(self.headerImageView.mas_left).offset(kRealValue(27));
    }];
    
    
    UIButton *mxBtn = [[UIButton alloc] init];
    mxBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [mxBtn setTitle:@"明细" forState:0];
    [mxBtn addTarget:self action:@selector(jihuo) forControlEvents:UIControlEventTouchUpInside];
    [mxBtn setTitleColor:[UIColor colorWithHexString:@"#FF9873"] forState:0];
    mxBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    ViewBorderRadius(mxBtn, kRealValue(15), 1, [UIColor colorWithHexString:@"#ffffff"]);
     [self.view addSubview:mxBtn];
    [mxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo( self.headerImageView.mas_right).offset(-kRealValue(15));
        make.centerY.equalTo(self.chargeLabel.mas_centerY).offset(0);
        make.height.mas_equalTo(kRealValue(30));
        make.width.mas_equalTo(kRealValue(58));
    }];
    
    [[MHUserService sharedInstance]initwithHSALLShouruCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dict = response[@"data"];
            [self.contentTableView reloadData];
        }
    }];

}


-(void)setAllStr:(NSString *)allStr{
    _allStr = allStr;
    self.chargeLabel.text  = allStr;
}

- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.userInteractionEnabled = YES;
        _naviView.image = kGetImage(@"wallet_all_nav");
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"wallet_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(13, 25 + kTopHeight - 64, 30, 30);
        backButton.adjustsImageWhenHighlighted = NO;
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
    }
    return _naviView;
}


-(void)jihuo{
    
    HSRewardController *vc = [[HSRewardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0  || indexPath.row == 1) {
        return kRealValue(175);
    }
    return kRealValue(95);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        HSWalletTodayOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWalletTodayOneCell class])];
        
        NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"任务奖励（火币）"];
        [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
        cell.headLabel.attributedText = hotStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chargeLabel.textColor = [UIColor colorWithHexString:@"#FF6128"];
        if (self.dict) {
            cell.chargeLabel.text = self.dict[@"taskAward"];
            cell.leftLabel.text = self.dict[@"ordTaskAward"];
            cell.midLabel.text = self.dict[@"vipTaskAward"];
            cell.rightLabel.text = self.dict[@"svipTaskAward"];
        }
        return cell;
    }else if (indexPath.row == 1){
        HSWalletTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWalletTwoCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"邀请奖励（火币）"];
        [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
        cell.headLabel.attributedText = hotStr;
        cell.chargeLabel.textColor = [UIColor colorWithHexString:@"#FF6128"];
        if (self.dict) {
            cell.chargeLabel.text = self.dict[@"inviteAward"];
            cell.leftLabel.text = self.dict[@"inviteVipAward"];
            cell.midLabel.text = self.dict[@"inviteSvipAward"];
            
        }
        return cell;
    }
    else{
        HSWalletNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSWalletNomalCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chargeLabel.textColor = [UIColor colorWithHexString:@"#FF6128"];
        if (indexPath.row == 2) {
            NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"返佣奖励（火币）"];
            [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
            cell.headLabel.attributedText = hotStr;
            if (self.dict) {
                cell.chargeLabel.text = self.dict[@"taskRebate"];
                
            }
        }
        if (indexPath.row == 3) {
            NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"团队奖励（火币）"];
            [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
            cell.headLabel.attributedText = hotStr;
            if (self.dict) {
                cell.chargeLabel.text = self.dict[@"teamAward"];
                
            }
        }
        
        if (indexPath.row == 4) {
            
            
            NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"广告收益（火币）"];
            [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
            cell.headLabel.attributedText = hotStr;
            if (self.dict) {
                cell.chargeLabel.text = self.dict[@"advertAward"];
                
            }
        }
        
        if (indexPath.row == 5) {
            NSMutableAttributedString *hotStr = [[NSMutableAttributedString alloc]      initWithString:@"其他奖励（火币）"];
            [hotStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(13)] range:NSMakeRange(4,4)];
            cell.headLabel.attributedText = hotStr;
            if (self.dict) {
                cell.chargeLabel.text = self.dict[@"otherAward"];
                
            }
        }
        return cell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSWalletTodayOneCell class] forCellReuseIdentifier:NSStringFromClass([HSWalletTodayOneCell class])];
        [_contentTableView registerClass:[HSWalletNomalCell class] forCellReuseIdentifier:NSStringFromClass([HSWalletNomalCell class])];
        [_contentTableView registerClass:[HSWalletTwoCell class] forCellReuseIdentifier:NSStringFromClass([HSWalletTwoCell class])];
        //
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _contentTableView;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当前偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset >= 0) {
        self.headerImageView.frame = CGRectMake(0, kTopHeight - yOffset, kScreenWidth, kRealValue(183));
    }else{
        self.headerImageView.frame = CGRectMake(0, kTopHeight, kScreenWidth, kRealValue(183));
    }
    
}



-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(134) + kTopHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(134) + kTopHeight)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

@end
