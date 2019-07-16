//
//  HSChargeTableCell.m
//  HSKD
//
//  Created by AllenQin on 2019/3/14.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSChargeTableCell.h"
#import "HSRechargListCell.h"

@interface HSChargeTableCell ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *contentTableView;

@end

@implementation HSChargeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotAllList:(NSArray *)hotAllList hotDayList:(NSArray *)hotDayList
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.segmentIndex = 0;
    self.hotDayList = hotDayList;
    self.hotAllList = hotAllList;
    [self createTableView];
        
    }
    return self;
}




- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kRealValue(290));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSRechargListCell class] forCellReuseIdentifier:NSStringFromClass([HSRechargListCell class])];
        [self.contentView addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(15))];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        label.text = @"最多显示前50名";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"999999"];
        [footerView addSubview:label];
        label.centerX  = footerView.centerX;
        [_contentTableView setTableFooterView:footerView];
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.segmentIndex == 0) {
        return [self.hotAllList count];
    }else{
        return [self.hotDayList count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSRechargListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSRechargListCell class])];
    HSHotAllModel *model;
    if (self.segmentIndex == 0) {
        model = self.hotAllList[indexPath.row];
    }else{
        model = self.hotDayList[indexPath.row];
    }
    if (indexPath.row == 0) {
        cell.paimingView.image = kGetImage(@"one_icon");
        cell.paimingLabel.hidden = YES;
        cell.paimingView.hidden = NO;
    }else if (indexPath.row == 1){
        cell.paimingView.image = kGetImage(@"two_icon");
        cell.paimingLabel.hidden = YES;
        cell.paimingView.hidden = NO;
    }else if (indexPath.row == 2){
        cell.paimingView.image = kGetImage(@"three_icon");
        cell.paimingLabel.hidden = YES;
        cell.paimingView.hidden = NO;
    }else{
        cell.paimingLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.paimingLabel.hidden = NO;
        cell.paimingView.hidden = YES;
    }
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
    return kRealValue(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(50);
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    headerView.userInteractionEnabled = YES;
    NSArray *array = [NSArray arrayWithObjects:@"佣金总榜",@"佣金日榜", nil];
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:array];
        _segment.frame = CGRectMake(0, 0, kRealValue(220), kRealValue(29));
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = [UIColor colorWithHexString:@"#FD7215"];
    }
    [headerView addSubview:_segment];
    _segment.centerX  = headerView.centerX;
    return headerView;
}


-(void)segmentValueChanged:(UISegmentedControl *)seg{
    self.segmentIndex = seg.selectedSegmentIndex;
    [self.contentTableView reloadData];
}



@end
