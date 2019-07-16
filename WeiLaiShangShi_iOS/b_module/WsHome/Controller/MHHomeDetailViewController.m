//
//  MHHomeDetailViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeDetailViewController.h"
#import "HomeproductCell.h"
#import "NSString+Attribute.h"
#import "MHHomeDescTableViewCell.h"
#import "MHProductModel.h"
#import "MHHomeDetailCell.h"
//#import "MHProDetailViewController.h"

@interface MHHomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
     UILabel            *_titleLabel;
    UIImageView         *_headImageView;
}

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *naviView;//自定义导航栏
@property (nonatomic, strong) NSMutableArray       *listArr;
@property (nonatomic, strong) NSDictionary       *headDict;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, copy) NSString *activityId;
@end

@implementation MHHomeDetailViewController

- (instancetype)initWithId:(NSString *)activityId{
    self = [super init];
    if (self) {
        _activityId = activityId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:self.colorStr];
    _index = 1;
    _listArr = [NSMutableArray array];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.naviView];
    [self getData];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    

    
    [[MHUserService sharedInstance]initwithNewbeeDesc:[_activityId integerValue] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            self.headDict = response[@"data"][0][@"result"][0];
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.headDict[@"sourceUrl"]] placeholderImage:nil];
            [UIView performWithoutAnimation:^{
                [self.contentTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }];
}


- (void)getData{
    
    [[MHUserService sharedInstance]initwithHomeNewbee:_activityId  pageIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]]];
            [UIView performWithoutAnimation:^{
                [self.contentTableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            }];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
    }];
}


-(void)endRefresh{
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
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
        [_contentTableView registerClass:[MHHomeDetailCell class] forCellReuseIdentifier:NSStringFromClass([MHHomeDetailCell class])];
        [_contentTableView registerClass:[MHHomeDescTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MHHomeDescTableViewCell class])];
        _contentTableView.showsVerticalScrollIndicator = NO;
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211))];
        _contentTableView.tableHeaderView = _headImageView;
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.listArr.count;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
         return kRealValue(155);
    }else{
        NSString *str = self.headDict[@"desc"];
        return  [str heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)] width:kRealValue(343)] + kRealValue(30);
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MHHomeDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHomeDescTableViewCell class])];
        cell.backgroundColor = [UIColor clearColor];
        cell.descLabel.text = self.headDict[@"desc"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        MHHomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHomeDetailCell class])];
        cell.backgroundColor = [UIColor clearColor];
//        cell.isCollect = YES;
        cell.ProductModel = self.listArr[indexPath.row];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
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
        _titleLabel.text = self.nameTitle;
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _contentTableView) {
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MHProductModel *model = _listArr[indexPath.row];
//    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
//    vc.productId = model.productId;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
