//
//  MHWGShopViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/19.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHWGShopViewController.h"
#import "MHProductCell.h"
#import "MHbannerCell.h"
#import "MHShopModel.h"
#import "MHProdetailViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "MHBannerItem.h"
#import "MHPageSectionModel.h"
#import "MHPageItemModel.h"
#import "MHWGShopViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHWebviewViewController.h"

@interface MHWGShopViewController ()<UITableViewDelegate,UITableViewDataSource,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *footerView;
@property(nonatomic, strong)UIImageView *headerImageView;
@property(nonatomic, strong)NSMutableArray *shopArr;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property(nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHWGShopViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    _index = 1;
    self.sectionArr = [NSMutableArray array];
    self.shopArr = [NSMutableArray array];
    [self getbannerData];
    [self getproductData];
    // Do any additional setup after loading the view.
}

-(void)getproductData
{
    NSString *typeList = @"NORMAL";
    [[MHUserService sharedInstance]initwithTypeIdList:typeList pageSize:20 pageIndex:self.index completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.shopArr  removeAllObjects];
                
            }
             [self.shopArr addObjectsFromArray:[MHShopModel baseModelWithArr:response[@"data"]]];
            
            if ([[response valueForKey:@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView reloadData];
            
          
        }
        if (error) {
             [self endRefresh];
            [self.tableView cyl_reloadData];
        }
    }];
}
-(void)getbannerData
{
    [[MHUserService sharedInstance]initWithPageComponent:@"1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {

            NSMutableArray *Arr = [NSMutableArray arrayWithArray:[response objectForKey:@"data"]];
            for (int i = 0; i <Arr.count ; i++) {
                MHPageSectionModel *model1 = [[MHPageSectionModel alloc]init];
                model1.type = [[Arr objectAtIndex:i] valueForKey:@"type"];
                model1.visible = [[Arr objectAtIndex:i] valueForKey:@"visible"];
               self.bannerArr =[NSMutableArray arrayWithArray:[MHPageItemModel baseModelWithArr:[[[response objectForKey:@"data"] objectAtIndex:i] valueForKey:@"result"]]]  ;
                [self.sectionArr addObject:model1];
               
            }
            self.pageControl.numberOfPages = self.bannerArr.count;
            [self.pagerView reloadData];
            
        }
        
    }];
}

- (UIView *)makePlaceHolderView {
    //    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
}

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getbannerData];
    [self getproductData];
    
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_tableView.frame];
    return networkErrorPlaceHolder;
}


-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [self.tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)createview{
    self.title = @"微广商城";
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getproductData];
        [self getbannerData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getproductData];
       
    }];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //headerView
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(280))];
        headerView.backgroundColor = [UIColor whiteColor];
      
        [headerView addSubview:self.pagerView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.frame = CGRectMake(0, kRealValue(188), kScreenWidth, kRealValue(44));
        titleLabel.text = @"微广推手 用心选好货";
        titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLabel];
        [_tableView setTableHeaderView:headerView];
        
        UILabel *subtitleLabel = [[UILabel alloc] init];
        subtitleLabel.backgroundColor = [UIColor whiteColor];
        subtitleLabel.frame = CGRectMake(kRealValue(16), kRealValue(232), kScreenWidth-kRealValue(32), kRealValue(40));
        subtitleLabel.text = @"微广团队，寻访日韩欧美等十几个国家，从打样到成型，把关数十道工序，只为给您带来海外直供的超值好物。";
        subtitleLabel.numberOfLines = 2;
        subtitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        subtitleLabel.textColor = [UIColor blackColor];
        subtitleLabel.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:subtitleLabel];
        [_tableView setTableHeaderView:headerView];
        
        
        
        [_tableView registerClass:[MHProductCell class] forCellReuseIdentifier:NSStringFromClass([MHProductCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
    }
    return _tableView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(280);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_shopArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MHProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductCell class])];
    [cell creatModel:_shopArr[indexPath.row]];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //push
    MHShopModel *model = self.shopArr[indexPath.row ];
    MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
    vc.productId = [NSString stringWithFormat:@"%ld",model.productId];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(TYCyclePagerView *)pagerView
{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.frame =CGRectMake(0, 0, kScreenWidth,  kRealValue(188));
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 5;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        // registerClass or registerNib
        [_pagerView registerClass:[MHBannerItem class] forCellWithReuseIdentifier:@"cellId"];
        TYPageControl *pageControl = [[TYPageControl alloc]init];
        pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
        //pageControl.numberOfPages = _datas.count;
        pageControl.currentPageIndicatorSize = CGSizeMake(12, 3);
        pageControl.pageIndicatorSize = CGSizeMake(8, 3);
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"000000" andAlpha:.4];
        //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
        //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
        //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
        [_pagerView addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pagerView;
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    MHBannerItem *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    MHPageItemModel *model = self.bannerArr[index];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]  placeholderImage:kGetImage(@"")];
    
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake( kScreenWidth , kRealValue(188));
    layout.layoutType=TYCyclePagerTransformLayoutNormal;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    MHLog(@"%ld ->  %ld",fromIndex,toIndex);
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index
{
    
    
    if (self.bannerArr.count > 0) {
        MHPageItemModel *model = [self.bannerArr objectAtIndex:index];
        if ([[NSString stringWithFormat:@"%ld",model.actionUrlType] isEqualToString:@"0"] ) {
            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.actionUrl comefrom:@"firstpage"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[NSString stringWithFormat:@"%ld",model.actionUrlType] isEqualToString:@"1"] ) {
            NSData *jsonData = [model.actionUrl dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"json解析失败：%@",err);
            }else{
                if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"5"]) {
                    //产品详情
                    MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
                    vc.productId = [dic valueForKey:@"param"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }
            
            
        }
    }
    
    
}



@end
