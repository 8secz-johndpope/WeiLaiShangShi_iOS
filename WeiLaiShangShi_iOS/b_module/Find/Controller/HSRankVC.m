
//
//  HSRankVC.m
//  HSKD
//
//  Created by AllenQin on 2019/4/24.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRankVC.h"
#import "HSRechargListCell.h"
#import "HSHotAllModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface HSRankVC ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property(strong,nonatomic)UITableView *contentTableView;

@property(nonatomic, strong)NSMutableArray *hotAllList;
@property(nonatomic, strong)NSMutableArray *hotDayList;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, assign) NSInteger  allIndex;
@property (nonatomic, strong) UISegmentedControl *segment;
@property(nonatomic, assign)NSInteger segmentIndex;

@end

@implementation HSRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index  = 1;
    self.allIndex = 1;
    _hotDayList = [NSMutableArray array];
    _hotAllList = [NSMutableArray array];
    [self createTableView];
    //总榜
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
    NSArray *array = [NSArray arrayWithObjects:@"佣金总榜",@"佣金日榜", nil];
    _segment = [[UISegmentedControl alloc]initWithItems:array];
    _segment.frame = CGRectMake(0, kRealValue(10), kRealValue(220), kRealValue(29));
    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;
    _segment.tintColor = [UIColor colorWithHexString:@"#FD7215"];
    [headerView addSubview:_segment];
    _segment.centerX  = headerView.centerX;
    [self.view addSubview:headerView];
    [[MHUserService sharedInstance]initwithWithHSFindHotAllListPageIndex:self.allIndex pageSize:50 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.allIndex == 1) {
                [self.hotAllList removeAllObjects];
            }
            [self.hotAllList  addObjectsFromArray:[HSHotAllModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.contentTableView reloadData];
        }
        
    }];
    
    [[MHUserService sharedInstance]initwithWithHSFindHotDayListPageIndex:self.index pageSize:50 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.hotDayList removeAllObjects];
            }
            [self.hotDayList  addObjectsFromArray:[HSHotAllModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.contentTableView reloadData];
        }
    }];
    
    
}




- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, kRealValue(40),kScreenWidth,kScreenHeight - kStatusBarHeight  - kTabBarHeight - kRealValue(100));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSRechargListCell class] forCellReuseIdentifier:NSStringFromClass([HSRechargListCell class])];
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(15))];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        label.text = @"最多显示前200名";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"999999"];
        [footerView addSubview:label];
        label.centerX  = footerView.centerX;
        [_contentTableView setTableFooterView:footerView];
        
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (self.segmentIndex == 0) {
                self.allIndex ++;
            }else{
                self.index ++;
            }
          
            [self getData];
        }];
        
        
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (self.segmentIndex == 0) {
                self.allIndex = 1;
            }else{
                self.index  = 1;
            }
            [self getData];
        }];

    }
    
    
}


-(void)getData{
    
    
    if (self.segmentIndex == 0) {
        [[MHUserService sharedInstance]initwithWithHSFindHotAllListPageIndex:self.allIndex pageSize:50 completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if (self.allIndex == 1) {
                    [self.hotAllList removeAllObjects];
                }
                [self.hotAllList  addObjectsFromArray:[HSHotAllModel baseModelWithArr:response[@"data"][@"list"]]];
                [self.contentTableView reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            if (error) {
                [self.contentTableView reloadData];
            }
            
        }];
    }else{
        
        [[MHUserService sharedInstance]initwithWithHSFindHotDayListPageIndex:self.index pageSize:50 completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.hotDayList removeAllObjects];
                }
                [self.hotDayList  addObjectsFromArray:[HSHotAllModel baseModelWithArr:response[@"data"][@"list"]]];
                [self.contentTableView reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            if (error) {
                [self.contentTableView reloadData];
            }
        }];
    }
    
    
    


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_segmentIndex == 0) {
        if ([self.hotAllList count]<=3) {
            return 0;
        }else{
            return [self.hotAllList count] - 3;
        }
        
        
    }else{
        if ([self.hotDayList count]<=3) {
            return 0;
        }else{
            return [self.hotDayList count] - 3;
        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSRechargListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSRechargListCell class])];
    HSHotAllModel *model;
    if (self.segmentIndex == 0) {
          model = self.hotAllList[indexPath.row+3];
    }else{
          model = self.hotDayList[indexPath.row+3];
    }
  
    cell.paimingLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+4];
    cell.paimingLabel.hidden = NO;
    cell.paimingView.hidden = YES;
    cell.nameLabel.text = model.nickname;
    if ([model.userRole isEqualToString:@"SVIP"]) {
        cell.levelLabel.text = @"金勺会员";
    }else if ([model.userRole isEqualToString:@"VIP"]){
        cell.levelLabel.text = @"银勺会员";
    }else if ([model.userRole isEqualToString:@"ORD"]){
        cell.levelLabel.text = @"普通用户";
    }
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    if (model.nickname.length >= 4) {
        NSString *first = [model.nickname substringToIndex:2];//字符串开始
        NSString *last = [model.nickname substringFromIndex:model.nickname.length-2];//字符串结尾
        cell.nameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
    }else{
        cell.nameLabel.text = model.nickname;
    }
    cell.jifenLabel.text = [NSString stringWithFormat:@"%@火币",model.integral];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(263);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(50);
    
}

-(void)endRefresh{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.segmentIndex == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(263))];
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.userInteractionEnabled = YES;
        
        
        UIImageView *goldView = [[UIImageView alloc]initWithImage:kGetImage(@"no1_icon")];
        goldView.frame = CGRectMake(0, kRealValue(30), kRealValue(83), kRealValue(112));
        [headerView addSubview:goldView];
        goldView.centerX  = kScreenWidth/2;
        
        UIImageView *goldheadView = [[UIImageView alloc]init];
        goldheadView.frame = CGRectMake(0, kRealValue(63), kRealValue(75), kRealValue(75));
        [headerView addSubview:goldheadView];
        ViewRadius(goldheadView, kRealValue(37.5));
        goldheadView.centerX  = kScreenWidth/2;
        
        UILabel *goldNameLabel = [[UILabel alloc] init];
        goldNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        goldNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        goldNameLabel.text = @"  ";
        [headerView addSubview:goldNameLabel];
        [goldNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(goldView.mas_centerX).offset(0);
            make.top.equalTo(goldView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *goldlevelView = [[UIImageView alloc]init];
        goldlevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:goldlevelView];
        goldlevelView.image = kGetImage(@"yin_icon");
        goldlevelView.centerX  = kScreenWidth/2;
        
        UILabel *goldhbLabel = [[UILabel alloc] init];
        goldhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        goldhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        goldhbLabel.text = @"234423";
        [headerView addSubview:goldhbLabel];
        [goldhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(goldView.mas_centerX).offset(0);
            make.top.equalTo(goldlevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        
        
        
        UIImageView *selidView = [[UIImageView alloc]initWithImage:kGetImage(@"no2_icon")];
        selidView.frame = CGRectMake(kRealValue(25), kRealValue(40), kRealValue(76), kRealValue(102));
        
        [headerView addSubview:selidView];
        
        UIImageView *selidheadView = [[UIImageView alloc]init];
        selidheadView.frame = CGRectMake(kRealValue(28.5), kRealValue(69.5), kRealValue(69), kRealValue(69));
        [headerView addSubview:selidheadView];
        ViewRadius(selidheadView, kRealValue(34.5));
        
        UILabel *selidNameLabel = [[UILabel alloc] init];
        selidNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        selidNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        selidNameLabel.text = @"234423";
        [headerView addSubview:selidNameLabel];
        [selidNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(selidView.mas_centerX).offset(0);
            make.top.equalTo(selidView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *selidlevelView = [[UIImageView alloc]init];
        selidlevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:selidlevelView];
        selidlevelView.image = kGetImage(@"yin_icon");
        selidlevelView.centerX  = selidView.centerX;
        
        UILabel *selidhbLabel = [[UILabel alloc] init];
        selidhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        selidhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        selidhbLabel.text = @"234423";
        [headerView addSubview:selidhbLabel];
        [selidhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(selidView.mas_centerX).offset(0);
            make.top.equalTo(selidlevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        UIImageView *cuView = [[UIImageView alloc]initWithImage:kGetImage(@"no3_icon")];
        cuView.frame = CGRectMake(kScreenWidth - kRealValue(101), kRealValue(40), kRealValue(76), kRealValue(102));
        [headerView addSubview:cuView];
        
        UIImageView *cuheadView = [[UIImageView alloc]init];
        cuheadView.frame = CGRectMake(kScreenWidth - kRealValue(97.5), kRealValue(69.5), kRealValue(69), kRealValue(69));
        [headerView addSubview:cuheadView];
        
        ViewRadius(cuheadView, kRealValue(34.5));
        
        
        UILabel *cuNameLabel = [[UILabel alloc] init];
        cuNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        cuNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        cuNameLabel.text = @"234423";
        [headerView addSubview:cuNameLabel];
        [cuNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cuView.mas_centerX).offset(0);
            make.top.equalTo(cuView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *culevelView = [[UIImageView alloc]init];
        culevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:culevelView];
        culevelView.image = kGetImage(@"yin_icon");
        culevelView.centerX  = cuView.centerX;
        
        UILabel *cuhbLabel = [[UILabel alloc] init];
        cuhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        cuhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        cuhbLabel.text = @"234423";
        [headerView addSubview:cuhbLabel];
        [cuhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cuView.mas_centerX).offset(0);
            make.top.equalTo(culevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        if ([self.hotAllList count] == 0) {
            goldheadView.hidden = YES;
            goldView.hidden = YES;
            goldNameLabel.hidden = YES;
            goldlevelView.hidden = YES;
            goldhbLabel.hidden = YES;
            
            selidheadView.hidden = YES;
            selidView.hidden = YES;
            selidNameLabel.hidden = YES;
            selidlevelView.hidden = YES;
            selidhbLabel.hidden = YES;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
        }
        
        
        if ([self.hotAllList count] >=1) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = YES;
            selidView.hidden = YES;
            selidNameLabel.hidden = YES;
            selidlevelView.hidden = YES;
            selidhbLabel.hidden = YES;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
            
            HSHotAllModel *model1 = self.hotAllList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
            
        }
        
        
        if ([self.hotAllList count] >= 2) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = NO;
            selidView.hidden = NO;
            selidNameLabel.hidden = NO;
            selidlevelView.hidden = NO;
            selidhbLabel.hidden = NO;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
            
            
            HSHotAllModel *model2 = self.hotAllList[1];
            [selidheadView sd_setImageWithURL:[NSURL URLWithString:model2.avatar]];
            selidNameLabel.text  = model2.nickname;
            if ([model2.userRole isEqualToString:@"SVIP"]) {
                selidlevelView.image = kGetImage(@"jin_icon");
            }else if ([model2.userRole isEqualToString:@"VIP"]){
                selidlevelView.image = kGetImage(@"yin_icon");
            }else if ([model2.userRole isEqualToString:@"ORD"]){
                selidlevelView.image = kGetImage(@"nom_vip");
            }
            if (model2.nickname.length >= 4) {
                NSString *first = [model2.nickname substringToIndex:2];//字符串开始
                NSString *last = [model2.nickname substringFromIndex:model2.nickname.length-2];//字符串结尾
                selidNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                selidNameLabel.text = model2.nickname;
            }
            selidhbLabel.text = [NSString stringWithFormat:@"%@火币",model2.integral];
            
            
            
            HSHotAllModel *model1 = self.hotAllList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
            
            
            
        }
        
        
        if ([self.hotAllList count] >= 3) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = NO;
            selidView.hidden = NO;
            selidNameLabel.hidden = NO;
            selidlevelView.hidden = NO;
            selidhbLabel.hidden = NO;
            
            cuheadView.hidden = NO;
            cuView.hidden = NO;
            cuNameLabel.hidden = NO;
            culevelView.hidden = NO;
            cuhbLabel.hidden = NO;
            
            
            HSHotAllModel *model3 = self.hotAllList[2];
            [cuheadView sd_setImageWithURL:[NSURL URLWithString:model3.avatar]];
            cuNameLabel.text  = model3.nickname;
            if ([model3.userRole isEqualToString:@"SVIP"]) {
                culevelView.image = kGetImage(@"jin_icon");
            }else if ([model3.userRole isEqualToString:@"VIP"]){
                culevelView.image = kGetImage(@"yin_icon");
            }else if ([model3.userRole isEqualToString:@"ORD"]){
                culevelView.image = kGetImage(@"nom_vip");
            }
            if (model3.nickname.length >= 4) {
                NSString *first = [model3.nickname substringToIndex:2];//字符串开始
                NSString *last = [model3.nickname substringFromIndex:model3.nickname.length-2];//字符串结尾
                cuNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                cuNameLabel.text = model3.nickname;
            }
            cuhbLabel.text = [NSString stringWithFormat:@"%@火币",model3.integral];
            
            
            
            
            HSHotAllModel *model2 = self.hotAllList[1];
            [selidheadView sd_setImageWithURL:[NSURL URLWithString:model2.avatar]];
            selidNameLabel.text  = model2.nickname;
            if ([model2.userRole isEqualToString:@"SVIP"]) {
                selidlevelView.image = kGetImage(@"jin_icon");
            }else if ([model2.userRole isEqualToString:@"VIP"]){
                selidlevelView.image = kGetImage(@"yin_icon");
            }else if ([model2.userRole isEqualToString:@"ORD"]){
                selidlevelView.image = kGetImage(@"nom_vip");
            }
            if (model2.nickname.length >= 4) {
                NSString *first = [model2.nickname substringToIndex:2];//字符串开始
                NSString *last = [model2.nickname substringFromIndex:model2.nickname.length-2];//字符串结尾
                selidNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                selidNameLabel.text = model2.nickname;
            }
            selidhbLabel.text = [NSString stringWithFormat:@"%@火币",model2.integral];
            
            
            
            HSHotAllModel *model1 = self.hotAllList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
        }
        return headerView;
        
        
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(263))];
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.userInteractionEnabled = YES;
        
        
        UIImageView *goldView = [[UIImageView alloc]initWithImage:kGetImage(@"no1_icon")];
        goldView.frame = CGRectMake(0, kRealValue(30), kRealValue(83), kRealValue(112));
        [headerView addSubview:goldView];
        goldView.centerX  = kScreenWidth/2;
        
        UIImageView *goldheadView = [[UIImageView alloc]init];
        goldheadView.frame = CGRectMake(0, kRealValue(63), kRealValue(75), kRealValue(75));
        [headerView addSubview:goldheadView];
        ViewRadius(goldheadView, kRealValue(37.5));
        goldheadView.centerX  = kScreenWidth/2;
        
        UILabel *goldNameLabel = [[UILabel alloc] init];
        goldNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        goldNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        goldNameLabel.text = @"  ";
        [headerView addSubview:goldNameLabel];
        [goldNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(goldView.mas_centerX).offset(0);
            make.top.equalTo(goldView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *goldlevelView = [[UIImageView alloc]init];
        goldlevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:goldlevelView];
        goldlevelView.image = kGetImage(@"yin_icon");
        goldlevelView.centerX  = kScreenWidth/2;
        
        UILabel *goldhbLabel = [[UILabel alloc] init];
        goldhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        goldhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        goldhbLabel.text = @"234423";
        [headerView addSubview:goldhbLabel];
        [goldhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(goldView.mas_centerX).offset(0);
            make.top.equalTo(goldlevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        
        
        
        UIImageView *selidView = [[UIImageView alloc]initWithImage:kGetImage(@"no2_icon")];
        selidView.frame = CGRectMake(kRealValue(25), kRealValue(40), kRealValue(76), kRealValue(102));
        
        [headerView addSubview:selidView];
        
        UIImageView *selidheadView = [[UIImageView alloc]init];
        selidheadView.frame = CGRectMake(kRealValue(28.5), kRealValue(69.5), kRealValue(69), kRealValue(69));
        [headerView addSubview:selidheadView];
        ViewRadius(selidheadView, kRealValue(34.5));
        
        UILabel *selidNameLabel = [[UILabel alloc] init];
        selidNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        selidNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        selidNameLabel.text = @"234423";
        [headerView addSubview:selidNameLabel];
        [selidNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(selidView.mas_centerX).offset(0);
            make.top.equalTo(selidView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *selidlevelView = [[UIImageView alloc]init];
        selidlevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:selidlevelView];
        selidlevelView.image = kGetImage(@"yin_icon");
        selidlevelView.centerX  = selidView.centerX;
        
        UILabel *selidhbLabel = [[UILabel alloc] init];
        selidhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        selidhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        selidhbLabel.text = @"234423";
        [headerView addSubview:selidhbLabel];
        [selidhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(selidView.mas_centerX).offset(0);
            make.top.equalTo(selidlevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        UIImageView *cuView = [[UIImageView alloc]initWithImage:kGetImage(@"no3_icon")];
        cuView.frame = CGRectMake(kScreenWidth - kRealValue(101), kRealValue(40), kRealValue(76), kRealValue(102));
        [headerView addSubview:cuView];
        
        UIImageView *cuheadView = [[UIImageView alloc]init];
        cuheadView.frame = CGRectMake(kScreenWidth - kRealValue(97.5), kRealValue(69.5), kRealValue(69), kRealValue(69));
        [headerView addSubview:cuheadView];
        
        ViewRadius(cuheadView, kRealValue(34.5));
        
        
        UILabel *cuNameLabel = [[UILabel alloc] init];
        cuNameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        cuNameLabel.textColor = [UIColor colorWithHexString:@"222222"];
        cuNameLabel.text = @"234423";
        [headerView addSubview:cuNameLabel];
        [cuNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cuView.mas_centerX).offset(0);
            make.top.equalTo(cuView.mas_bottom).offset(kRealValue(10));
        }];
        
        UIImageView *culevelView = [[UIImageView alloc]init];
        culevelView.frame = CGRectMake(0, kRealValue(177), kRealValue(66), kRealValue(24));
        [headerView addSubview:culevelView];
        culevelView.image = kGetImage(@"yin_icon");
        culevelView.centerX  = cuView.centerX;
        
        UILabel *cuhbLabel = [[UILabel alloc] init];
        cuhbLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        cuhbLabel.textColor = [UIColor colorWithHexString:@"#FD7215"];
        cuhbLabel.text = @"234423";
        [headerView addSubview:cuhbLabel];
        [cuhbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cuView.mas_centerX).offset(0);
            make.top.equalTo(culevelView.mas_bottom).offset(kRealValue(8));
        }];
        
        
        
        if ([self.hotDayList count] == 0) {
            goldheadView.hidden = YES;
            goldView.hidden = YES;
            goldNameLabel.hidden = YES;
            goldlevelView.hidden = YES;
            goldhbLabel.hidden = YES;
            
            selidheadView.hidden = YES;
            selidView.hidden = YES;
            selidNameLabel.hidden = YES;
            selidlevelView.hidden = YES;
            selidhbLabel.hidden = YES;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
        }
        
        
        if ([self.hotDayList count] >=1) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = YES;
            selidView.hidden = YES;
            selidNameLabel.hidden = YES;
            selidlevelView.hidden = YES;
            selidhbLabel.hidden = YES;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
            
            HSHotAllModel *model1 = self.hotDayList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
            
        }
        
        
        if ([self.hotDayList count] >= 2) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = NO;
            selidView.hidden = NO;
            selidNameLabel.hidden = NO;
            selidlevelView.hidden = NO;
            selidhbLabel.hidden = NO;
            
            cuheadView.hidden = YES;
            cuView.hidden = YES;
            cuNameLabel.hidden = YES;
            culevelView.hidden = YES;
            cuhbLabel.hidden = YES;
            
            
            HSHotAllModel *model2 = self.hotDayList[1];
            [selidheadView sd_setImageWithURL:[NSURL URLWithString:model2.avatar]];
            selidNameLabel.text  = model2.nickname;
            if ([model2.userRole isEqualToString:@"SVIP"]) {
                selidlevelView.image = kGetImage(@"jin_icon");
            }else if ([model2.userRole isEqualToString:@"VIP"]){
                selidlevelView.image = kGetImage(@"yin_icon");
            }else if ([model2.userRole isEqualToString:@"ORD"]){
                selidlevelView.image = kGetImage(@"nom_vip");
            }
            if (model2.nickname.length >= 4) {
                NSString *first = [model2.nickname substringToIndex:2];//字符串开始
                NSString *last = [model2.nickname substringFromIndex:model2.nickname.length-2];//字符串结尾
                selidNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                selidNameLabel.text = model2.nickname;
            }
            selidhbLabel.text = [NSString stringWithFormat:@"%@火币",model2.integral];
            
            
            
            HSHotAllModel *model1 = self.hotDayList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
            
            
            
        }
        
        
        if ([self.hotDayList count] >= 3) {
            goldheadView.hidden = NO;
            goldView.hidden = NO;
            goldNameLabel.hidden = NO;
            goldlevelView.hidden = NO;
            goldhbLabel.hidden = NO;
            
            selidheadView.hidden = NO;
            selidView.hidden = NO;
            selidNameLabel.hidden = NO;
            selidlevelView.hidden = NO;
            selidhbLabel.hidden = NO;
            
            cuheadView.hidden = NO;
            cuView.hidden = NO;
            cuNameLabel.hidden = NO;
            culevelView.hidden = NO;
            cuhbLabel.hidden = NO;
            
            
            HSHotAllModel *model3 = self.hotDayList[2];
            [cuheadView sd_setImageWithURL:[NSURL URLWithString:model3.avatar]];
            cuNameLabel.text  = model3.nickname;
            if ([model3.userRole isEqualToString:@"SVIP"]) {
                culevelView.image = kGetImage(@"jin_icon");
            }else if ([model3.userRole isEqualToString:@"VIP"]){
                culevelView.image = kGetImage(@"yin_icon");
            }else if ([model3.userRole isEqualToString:@"ORD"]){
                culevelView.image = kGetImage(@"nom_vip");
            }
            if (model3.nickname.length >= 4) {
                NSString *first = [model3.nickname substringToIndex:2];//字符串开始
                NSString *last = [model3.nickname substringFromIndex:model3.nickname.length-2];//字符串结尾
                cuNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                cuNameLabel.text = model3.nickname;
            }
            cuhbLabel.text = [NSString stringWithFormat:@"%@火币",model3.integral];
            
            
            
            
            HSHotAllModel *model2 = self.hotDayList[1];
            [selidheadView sd_setImageWithURL:[NSURL URLWithString:model2.avatar]];
            selidNameLabel.text  = model2.nickname;
            if ([model2.userRole isEqualToString:@"SVIP"]) {
                selidlevelView.image = kGetImage(@"jin_icon");
            }else if ([model2.userRole isEqualToString:@"VIP"]){
                selidlevelView.image = kGetImage(@"yin_icon");
            }else if ([model2.userRole isEqualToString:@"ORD"]){
                selidlevelView.image = kGetImage(@"nom_vip");
            }
            if (model2.nickname.length >= 4) {
                NSString *first = [model2.nickname substringToIndex:2];//字符串开始
                NSString *last = [model2.nickname substringFromIndex:model2.nickname.length-2];//字符串结尾
                selidNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                selidNameLabel.text = model2.nickname;
            }
            selidhbLabel.text = [NSString stringWithFormat:@"%@火币",model2.integral];
            
            
            
            HSHotAllModel *model1 = self.hotDayList[0];
            [goldheadView sd_setImageWithURL:[NSURL URLWithString:model1.avatar]];
            goldNameLabel.text  = model1.nickname;
            if ([model1.userRole isEqualToString:@"SVIP"]) {
                goldlevelView.image = kGetImage(@"jin_icon");
            }else if ([model1.userRole isEqualToString:@"VIP"]){
                goldlevelView.image = kGetImage(@"yin_icon");
            }else if ([model1.userRole isEqualToString:@"ORD"]){
                goldlevelView.image = kGetImage(@"nom_vip");
            }
            if (model1.nickname.length >= 4) {
                NSString *first = [model1.nickname substringToIndex:2];//字符串开始
                NSString *last = [model1.nickname substringFromIndex:model1.nickname.length-2];//字符串结尾
                goldNameLabel.text = [NSString stringWithFormat:@"%@*%@",first,last];
            }else{
                goldNameLabel.text = model1.nickname;
            }
            goldhbLabel.text = [NSString stringWithFormat:@"%@火币",model1.integral];
        }
        return headerView;
    }
    
    
    
    
    
    
    
}


-(void)segmentValueChanged:(UISegmentedControl *)seg{
    self.segmentIndex = seg.selectedSegmentIndex;
    [self.contentTableView reloadData];
//    self.index = 1;
//    [self getData];
}

- (UIView *)makePlaceHolderView {
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
}


- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    return networkErrorPlaceHolder;
}

@end
