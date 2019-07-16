//
//  MHHomeGoodsTypeListController.m
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeGoodsTypeListController.h"
//#import "MHProdCateroyViewController.h"
#import "MHHomeGoodsHeadSortTitleView.h"
#import "MHBaseTableView.h"
#import "HomeproductCell.h"
#import "MHHomeGoodsHeadSortView.h"
#import "MHProductModel.h"
#import "MHProDetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
@interface MHHomeGoodsTypeListController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong)MHHomeGoodsHeadSortTitleView *headview;
@property (nonatomic, strong) MHBaseTableView *tableView;
@property (nonatomic, strong) MHHomeGoodsHeadSortView *aler;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) NSMutableArray *brandArr;
@property (nonatomic, strong) NSMutableDictionary *dic;
//1 默认 2 销量 3 价格 4 筛选
@property (nonatomic, assign) NSInteger refreshtype;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, assign) NSInteger NumSort;
@property (nonatomic, assign) NSInteger priceSort;
@property (nonatomic, strong) NSString *keySorttypeID;
@property (nonatomic, strong) NSString *keySortbrandname;
@property (nonatomic, strong) NSString *keySortmaxprice;
@property (nonatomic, strong) NSString *keySortminprice;



@end

@implementation MHHomeGoodsTypeListController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.aler hideView];
    
}
- (instancetype)initWithTypeId:(NSString *)typeId parentID:(NSString *)parentID;
{
    self = [super init];
    if (self) {        
        self.typeId = typeId;
        self.keySorttypeID = typeId;
        self.parentID = parentID;
        self.keySortbrandname = @"";
        self.keySortminprice = @"";
        self.keySortmaxprice = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshtype = 1;
    self.index = 1;
    self.view.backgroundColor = [UIColor whiteColor];
     self.listArr = [NSMutableArray array];
//    [self setNav];
    [self createview];
    [self getdata];
    [self getBranddata];
    self.title = self.navtitle;
}
-(void)getBranddata
{

    self.dic = [NSMutableDictionary dictionary];
    kWeakSelf(self);
    [[MHUserService sharedInstance]initWithproductbrandList:self.parentID completionBlock:^(NSDictionary *response, NSError *error) {
       if (ValidResponseDict(response)) {
           
           weakself.dic= [response valueForKey:@"data"];
           
            [[[UIApplication sharedApplication].keyWindow viewWithTag:43219] removeFromSuperview];
               weakself.aler = [[MHHomeGoodsHeadSortView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight-kBottomHeight) width:kRealValue(300) dataArr:weakself.dic typeid:weakself.parentID];
               weakself.aler.alpha = 0;
               weakself.aler.tag =43219;
               [[UIApplication sharedApplication].keyWindow addSubview:weakself.aler];
           
          
           weakself.aler.sortwithkey = ^(NSString *typeID, NSString *brandname, NSString *maxprice, NSString *minprice, NSString *titlename) {
               weakself.title = titlename;
                [weakself sortdataWithtypeID:typeID brandname:brandname minprice:minprice maxPrice:maxprice];
           };
       }
        
    }];
    
}
-(void)getdata
{
    if (self.refreshtype != 1) {
        self.refreshtype = 1;
        self.index = 1 ;
        [self.listArr removeAllObjects];
    }
    [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:self.keySortmaxprice order:@"" sort:@"" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
        
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
           
            [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"]] ];
            [self.tableView cyl_reloadData];
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        
    }];
  
    

}
- (UIView *)makePlaceHolderView {
    //    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
   
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    
    
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_tableView.frame];
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

-(void)sortdataWithtypeID:(NSString *)typeId brandname:(NSString *)brandname minprice:(NSString *)minPrice maxPrice:(NSString *)maxPrice
{
    
    
    if (klStringisEmpty(typeId) &&klStringisEmpty(brandname) &&klStringisEmpty(minPrice) && klStringisEmpty(maxPrice) ) {
        [self.aler hideView];
        return;
    }
    if (klStringisEmpty(brandname)) {
        brandname = @"";
    }
    if (klStringisEmpty(typeId)) {
        typeId = @"";
    }
    if (klStringisEmpty(minPrice)) {
        minPrice = @"";
    }
    if (klStringisEmpty(maxPrice)) {
        maxPrice = @"";
    }
    if (self.refreshtype != 4) {
        self.refreshtype = 4;
        self.index = 1 ;
        self.keySorttypeID = typeId;
        self.keySortbrandname = brandname;
        self.keySortminprice = minPrice;
        self.keySortmaxprice = maxPrice;
        [self.listArr removeAllObjects];
    }else{
        if (![self.keySorttypeID isEqualToString:typeId]) {
            self.index = 1;
            self.keySorttypeID = typeId;
            [self.listArr removeAllObjects];
        }
        if (![self.keySortbrandname isEqualToString: brandname]) {
            self.index = 1;
            self.keySortbrandname = brandname;
            [self.listArr removeAllObjects];
        }
        if (![self.keySortminprice isEqualToString: minPrice]) {
            self.index = 1;
            self.keySortminprice = minPrice;
            [self.listArr removeAllObjects];
        }
        if (![self.keySortmaxprice isEqualToString: maxPrice]) {
            self.index = 1;
            self.keySortmaxprice = maxPrice;
            [self.listArr removeAllObjects];
        }
        
    }
    
    [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:maxPrice order:self.keySortmaxprice sort:@"" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index] completionBlock:^(NSDictionary *response, NSError *error) {
        
        
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]] ];
   
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
                     [self.tableView cyl_reloadData];
        }
        [self.aler hideView];
        
    }];
}
-(void)getdataWithsaleNumSort:(NSInteger)type
{
    if (self.refreshtype != 2) {
        self.refreshtype = 2;
        self.index = 1 ;
        self.NumSort = type;
        [self.listArr removeAllObjects];
    }else{
        if (self.NumSort != type) {
            self.index = 1;
            self.NumSort = type;
            [self.listArr removeAllObjects];
        }
    }
    if (type == 1) {
        [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:self.keySortmaxprice order:@"SELL" sort:@"ASC" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr removeAllObjects];
                }
                [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]] ];
                [self.tableView cyl_reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            
        }];
    }else{
        [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:self.keySortmaxprice order:@"SELL" sort:@"DESC" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr removeAllObjects];
                }
                [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]] ];
                [self.tableView cyl_reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            
        }];
    }
   
    
}
-(void)getdataWithpriceNumSort:(NSInteger)type
{
    if (self.refreshtype != 3) {
        self.refreshtype = 3;
        self.index = 1 ;
        self.priceSort = type;
        [self.listArr removeAllObjects];
    }else{
        if (self.priceSort != type) {
            self.index = 1;
            self.priceSort = type;
            [self.listArr removeAllObjects];
        }
    }
    if (type == 1) {
        [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID  name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:self.keySortmaxprice order:@"PRICE" sort:@"ASC" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr removeAllObjects];
                }
                [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]] ];
                [self.tableView cyl_reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            
        }];
    }else{
        [[MHUserService sharedInstance]initwithTypeIdList:self.keySorttypeID name:@"" brandId:self.keySortbrandname minPrice:self.keySortminprice maxPrice:self.keySortmaxprice order:@"PRICE" sort:@"DESC" pageSize:@"20" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr removeAllObjects];
                }
                [self.listArr addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]] ];
                [self.tableView cyl_reloadData];
                if ([ response[@"data"][@"list"] count] > 0) {
                    [self endRefresh];
                }else{
                    [self endRefreshNoMoreData];
                }
            }
            
        }];
    }
    
}
//-(void)setNav
//{
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_lefticon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(SearchAct)];
//    self.navigationItem.rightBarButtonItem = rightItem;
//}
-(void)createview
{
    [self.view addSubview:self.headview];
     [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.refreshtype == 1) {
            self.index = 1;
            [self getdata];
        }
        if (self.refreshtype == 2) {
            self.index = 1;
            [self getdataWithsaleNumSort:self.NumSort];
        }
        if (self.refreshtype == 3) {
            self.index = 1;
            [self getdataWithpriceNumSort:self.priceSort];
        }
        if (self.refreshtype == 4) {
            self.index = 1;
            [self sortdataWithtypeID:self.keySorttypeID brandname:self.keySortbrandname minprice:self.keySortminprice maxPrice:self.keySortmaxprice];
        }
       
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        if (self.refreshtype == 1) {
            [self getdata];
        }
        if (self.refreshtype == 2) {
            [self getdataWithsaleNumSort:self.NumSort];
        }
        if (self.refreshtype == 3) {
          
            [self getdataWithpriceNumSort:self.priceSort];
        }
        if (self.refreshtype == 4) {
            [self sortdataWithtypeID:self.keySorttypeID brandname:self.keySortbrandname minprice:self.keySortminprice maxPrice:self.keySortmaxprice];
        }
        
    }];
}
//-(void)SearchAct
//{
//    MHProdCateroyViewController *vc = [[MHProdCateroyViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
#pragma mark lazy
-(MHHomeGoodsHeadSortTitleView *)headview
{
    if (!_headview) {
         __weak __typeof(self) weakSelf = self;
        _headview = [[MHHomeGoodsHeadSortTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _headview.sort = ^(NSInteger type) {
            
           
             [weakSelf.aler showAlert];
           
        };
        //默认排序
        _headview.defaultsort = ^{
            [weakSelf getdata];
            
        };
        //销量排序
        _headview.saleNumSort = ^(NSInteger type) {
            MHLog(@"%ld",type);
            [weakSelf getdataWithsaleNumSort:type];
        };
        //价格排序
        _headview.priceNumSort = ^(NSInteger type) {
            //0  降序 1 升序
            MHLog(@"%ld",type);
             [weakSelf getdataWithpriceNumSort:type];
        };
        
    }
    return _headview;
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[MHBaseTableView alloc] initWithFrame:CGRectMake(0, 40,kScreenWidth, kScreenHeight-kTopHeight-40-kBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //        _tableView.backgroundColor = [UIColor redColor];
        [_tableView registerClass:[HomeproductCell class] forCellReuseIdentifier:NSStringFromClass([HomeproductCell class])];
      
        //        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  kScreenWidth, 44)];
        //        tableHeaderView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        //        _tableView.tableHeaderView = tableHeaderView;
        //    _tableView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kRealValue(280);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
//    vc.productId =[self.listArr[indexPath.row] productId];
//    vc.productdetailTYpe = 0;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    HomeproductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeproductCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (self.listArr.count > 0) {
         cell.ProductModel = self.listArr[indexPath.row];
    }
    
    //    cell.backgroundColor =kRandomColor;
    
    return cell;
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
