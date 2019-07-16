//
//  HSRewardController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRewardController.h"
#import "HSRewardTableViewCell.h"
#import "MHRecordPresentStatuController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "HSRewardModel.h"
#import "BRPickerView.h"
@interface HSRewardController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) UISegmentedControl *segment;
@property(nonatomic, assign)NSInteger segmentIndex;
@property (nonatomic, strong) NSString *Readchoosetime;
@property (nonatomic, strong) NSString *Taskchoosetime;
@property (nonatomic, strong) NSString *choosetime;
@property (nonatomic, strong) NSString *Fristchoosetime;
@property (nonatomic, strong)UIButton *btn;
@end

@implementation HSRewardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖励记录";
    //获取当前年月
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    self.choosetime = dateStr;
    self.Taskchoosetime =dateStr;
    self.Readchoosetime = dateStr;
    self.Fristchoosetime = dateStr;
    MHLog(@"%@",self.choosetime);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    self.segmentIndex = 0;
    NSArray *array = [NSArray arrayWithObjects:@"佣金奖励",@"阅读奖励", nil];
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:array];
        _segment.frame = CGRectMake(0, kRealValue(10), kRealValue(220), kRealValue(29));
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = [UIColor colorWithHexString:@"#FD7215"];
    }
    [headerView addSubview:_segment];
    _segment.centerX  = headerView.centerX;
    [self.view addSubview:headerView];
    
    _index = 1;
    _listArr = [NSMutableArray array];
    [self createview];
    [self getData];
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    
    
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self.btn setTitle:self.Fristchoosetime forState:UIControlStateNormal];
       
        if (self.segmentIndex == 1) {
            self.Readchoosetime = self.Fristchoosetime;
            self.choosetime = self.Readchoosetime;
        }else{
            self.Taskchoosetime = self.Fristchoosetime;
            self.choosetime = self.Taskchoosetime;
        }
        
        [self getData];
    }];
}


-(void)createview{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kRealValue(44))];
    view.backgroundColor = KColorFromRGB(0XF2F2F2);
    [self.view addSubview:view];
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:kGetImage(@"jt_icon") forState:UIControlStateNormal];
    [self.btn setTitle:self.choosetime forState:UIControlStateNormal];
    [self.btn setTitleColor:KColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.btn.backgroundColor = KColorFromRGB(0xffffff);
    [view addSubview:self.btn];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.left.equalTo(view.mas_left).offset(kRealValue(13));
        make.width.mas_equalTo(kRealValue(90));
        make.height.mas_equalTo(kRealValue(24));
    }];
   
    self.btn.layer.masksToBounds = YES;
     self.btn.layer.cornerRadius = kRealValue(12);
    [self.btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btn.imageView.bounds.size.width-10, 0, self.self.btn.imageView.bounds.size.width)];
    [self.btn setImageEdgeInsets:UIEdgeInsetsMake(2, self.btn.titleLabel.bounds.size.width, 0, -self.btn.titleLabel.bounds.size.width-10)];
    [self.btn addTarget:self action:@selector(Chosetime) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.contentTableView];
}

-(void)Chosetime
{
    NSDate *minDate = [NSDate br_setYear:2019 month:3 day:1];
    NSDate *maxDate = [NSDate date];
    if (self.segmentIndex == 1) {
        
        self.choosetime = self.Readchoosetime;
    }else{
       
        self.choosetime = self.Taskchoosetime;
    }
    [BRDatePickerView showDatePickerWithTitle:@"选择时间" dateType:BRDatePickerModeYM defaultSelValue:self.choosetime minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        
        MHLog(@"%@", selectValue);
        if (self.segmentIndex == 1) {
            self.Readchoosetime = selectValue;
            self.choosetime = self.Readchoosetime;
        }else{
             self.Taskchoosetime = selectValue;
            self.choosetime = self.Taskchoosetime;
        }
      
        [self.btn setTitle:selectValue forState:UIControlStateNormal];
        [self getData];
        
    } cancelBlock:^{
        
        
    }];
}
-(void)segmentValueChanged:(UISegmentedControl *)seg{
        self.segmentIndex = seg.selectedSegmentIndex;
    if (self.segmentIndex == 1) {
        self.choosetime = self.Readchoosetime;
        
    }else{
        self.choosetime = self.Taskchoosetime;
    }
     [self.btn setTitle:self.choosetime forState:UIControlStateNormal];
        self.index = 1;
        [self getData];
}


-(void)getData{
    NSString *flowType = @"";
    if (self.segmentIndex == 1) {
        flowType = @"READ";
    }else{
        flowType = @"";
    }
    
    [[MHUserService sharedInstance]initwithWithRewardPageIndex:_index pageSize:20 flowType:flowType queryTime:self.choosetime completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSRewardModel baseModelWithArr:response[@"data"]]];
            [self.contentTableView cyl_reloadData];
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
    }];
}

-(void)endRefresh{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.contentTableView.mj_header endRefreshing];
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}




-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, kRealValue(94),kScreenWidth, kScreenHeight-kTopHeight - kRealValue(94));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[HSRewardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HSRewardTableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(69);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSRewardTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    HSRewardModel *model =_listArr[indexPath.row];
    cell.textsLabel.text = model.detail;
    if ([model.recordType isEqualToString:@"INCOME"]) {
         cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#FBBB56"];
        cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"+%@",model.recordMoney];
        cell.RecordPresentcardnum.textColor = [UIColor colorWithHexString:@"#F32B2B"];
    }else{
      
        cell.RecordPresentcardnum.text = [NSString stringWithFormat:@"-%@",model.recordMoney];
         cell.RecordPresentcardnum.textColor = [UIColor colorWithHexString:@"#222222"];
        if ([model.flowType isEqualToString:@"RREEZE_INTEGRAL_INVALID"]) {
            cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#D1D1D1"];
        }else{
            cell.textsLabel.backgroundColor = [UIColor colorWithHexString:@"#3BBEF4"];
        }
    }
    
    if (model.deductPower == 0) {
      cell.RecordPresentstate.text = @"";
    }else{
      cell.RecordPresentstate.text = [NSString stringWithFormat:@"消耗%.2f友利值",model.deductPower];
    }
    
    
    cell.RecordPresentname.text = [NSString stringWithFormat:@"%@",model.content];
    
    cell.RecordPresenttime.text = model.createTime;

    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
