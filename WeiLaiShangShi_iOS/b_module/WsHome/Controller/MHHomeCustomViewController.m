//
//  MHHomeCustomViewController.m
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeCustomViewController.h"
#import "HomeproductCell.h"
#import "MHProductModel.h"
#import "MHbannerCell.h"
#import "MHtitleCell.h"
#import "MHGoodsKindsCell.h"
#import "MHHomeGoodsTypeListController.h"
#import "MHProDetailViewController.h"
#import "MHPageSectionModel.h"
#import "MHPageItemModel.h"
#import "MHWebviewViewController.h"
//#import "MHPriceMoreViewController.h"
//#import "MHHuGuessViewController.h"
#import "MHSrollView.h"

@interface MHHomeCustomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *modelArray;
//分类模型
@property(strong,nonatomic)NSMutableArray *categoryItemArray;
@property (nonatomic, strong)NSMutableArray *sectionArr;
@property (nonatomic, strong)NSMutableArray *bannerArr;
@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@end
@implementation MHHomeCustomViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}
- (instancetype)initWithTypeId:(NSString *)typeId
{
    self = [super init];
    if (self) {
        
        self.parentId = typeId;
        
    }
    return self;
}
-(void)getdata
{
   
    self.sectionArr = [NSMutableArray array];
    self.categoryItemArray  = [NSMutableArray array];
    self.bannerArr = [NSMutableArray array];
    dispatch_queue_t quenet = dispatch_queue_create("getdata", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(quenet, ^{
        [[MHUserService sharedInstance]initWithRecommend:self.parentId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                NSMutableArray *Arr = [response valueForKey:@"data"];
                if (Arr.count > 0) {
                    MHPageSectionModel *model1 = [[MHPageSectionModel alloc]init];
                    model1.type = @"SCROLL_PIC";
                    model1.itemArr =Arr  ;
                    [self.sectionArr addObject:model1];
                }
              
            }
            
        }];
        
    });
    [[MHUserService sharedInstance] initWithFirstPageComponent:@"5" parentTypeId:self.parentId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSMutableArray *Arr = [NSMutableArray arrayWithArray:[response objectForKey:@"data"]];
            
            for (int i = 0; i <Arr.count ; i++) {
                if ([[[Arr objectAtIndex:i] valueForKey:@"type"] isEqualToString:@"SCROLL_PIC"]) {
                    
                }else{
                    MHPageSectionModel *model1 = [[MHPageSectionModel alloc]init];
                    model1.type = [[Arr objectAtIndex:i] valueForKey:@"type"];
                    model1.visible = [[Arr objectAtIndex:i] valueForKey:@"visible"];
                    model1.itemArr =[NSMutableArray arrayWithArray:[MHPageItemModel baseModelWithArr:[[[response objectForKey:@"data"] objectAtIndex:i] valueForKey:@"result"]]]  ;
                    [self.sectionArr addObject:model1];
                }

            }
            MHLog(@"self.sectionArr%ld",self.sectionArr.count);
            MHLog(@"%@",self.parentId);
            for (unsigned long i = 0; i<self.sectionArr.count; i++) {
                 MHPageSectionModel *model = [self.sectionArr objectAtIndex:i];
                if ([model.type isEqualToString:@"SUB_TYPES"]) {
                    self.categoryItemArray =[NSMutableArray arrayWithArray:model.itemArr] ;
                 
                }
                if ([model.type isEqualToString:@"SCROLL_PIC"]) {
                    NSMutableArray *Arr =[NSMutableArray arrayWithArray:model.itemArr] ;
                    self.bannerArr = [MHPageItemModel baseModelWithArr:Arr];
                    
                }

            }
             MHLog(@"%ld",self.categoryItemArray.count);
            [self.tableView reloadData];
        }else{
            KLToast(response[@"message"]);
        }
        
        
    }];
    
    [self getListData];
    
}



- (void)getListData{
    
//    [[MHUserService sharedInstance]initwithHomeCommand:self.parentId recommend:@"1" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index] completionBlock:^(NSDictionary *response, NSError *error) {
//        if (ValidResponseDict(response)) {
//            if (self.index == 1) {
//                [self.listArr removeAllObjects];
//            }
//            [self.listArr  addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]]];
//
//            if ([ response[@"data"][@"list"] count] > 0) {
//                [self endRefresh];
//            }else{
//                [self endRefreshNoMoreData];
//            }
//                [self.tableView reloadData];
//        }
//        if (error) {
//            [self endRefresh];
//            KLToast(@"请检查网络情况");
//        }
//    }];
    
    [[MHUserService sharedInstance]initwithTypeIdList:self.parentId name:@"" brandId:@"" minPrice:@"" maxPrice:@"" order:@"" sort:@"" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",self.index ] completionBlock:^(NSDictionary *response, NSError *error) {
        
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"]]];
            
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView reloadData];
        }
        if (error) {
            [self endRefresh];
            KLToast(@"请检查网络情况");
        }
        
    }];
    
    
}



-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = kBackGroudColor;
    _listArr = [NSMutableArray array];
     [self.view addSubview:self.tableView];
    self.index = 1;
    [self getdata];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshhome) name:KNotificationRereshHome object:nil];
    // Do any additional setup after loading the view.
}
-(void)refreshhome
{
    self.index = 1;
    [self getdata];
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight-30)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[HomeproductCell class] forCellReuseIdentifier:NSStringFromClass([HomeproductCell class])];
        [_tableView registerClass:[MHGoodsKindsCell class] forCellReuseIdentifier:NSStringFromClass([MHGoodsKindsCell class])];
        [_tableView registerClass:[MHbannerCell class] forCellReuseIdentifier:NSStringFromClass([MHbannerCell class])];
        [_tableView registerClass:[MHtitleCell class] forCellReuseIdentifier:NSStringFromClass([MHtitleCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self getdata];
        }];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getListData];
        }];
        
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.sectionArr.count > 0) {
//        if (indexPath.section<self.sectionArr.count ) {
//            MHPageSectionModel *model = self.sectionArr[indexPath.section];
//            if ( [model.type isEqualToString:@"SCROLL_PIC"]) {
//                return kScreenWidth *0.453;
//            }
//            if ( [model.type isEqualToString:@"SUB_TYPES"]) {
//
//                if (self.categoryItemArray.count == 0) {
//                    return 0;
//                }
//                if (self.categoryItemArray.count>4) {
//                    return kRealValue(208);
//                }
//                if (self.categoryItemArray.count<=4) {
//                    return kRealValue(90);
//                }
//            }
//        }
//
//        if (indexPath.section == self.sectionArr.count && indexPath.row == 0) {
//            return kRealValue(40);
//        }
//         return kRealValue(280);
//    }
     return kRealValue(280);
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    if (self.sectionArr.count >0) {
//        if (section < self.sectionArr.count) {
//            return 1;
//        }else{
//            return self.listArr.count + 1;
//        }
//    }else{
//        return 0;
//    }
    return self.listArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.sectionArr.count > 0) {
//        return self.sectionArr.count+1;
//    }
//    return 0;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    kWeakSelf(self);
//    if (self.sectionArr.count > 0) {
//        
//        if (indexPath.section<self.sectionArr.count ) {
//            
//       
//     MHPageSectionModel *model = self.sectionArr[indexPath.section];
//    if ( [model.type isEqualToString:@"SCROLL_PIC"]) {
//        MHbannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHbannerCell class])];
//        cell.changepage = ^(NSString *code, NSString *parm) {
//            
//            if ([code isEqualToString:@"0"]) {
//                MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:parm comefrom:@"firstpage"];
//                [weakself.navigationController pushViewController:vc animated:YES];
//            }
//            if ([code isEqualToString:@"5"]) {
//                //产品详情
////                MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
////                vc.productId = parm;
////                [self.navigationController pushViewController:vc animated:YES];
//            }
//            if ([code isEqualToString:@"7"]) {
//                //奖多多
////                MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
////                [self.navigationController pushViewController:vc animated:YES];
//            }
//            if ([code isEqualToString:@"8"]) {
//                //胡猜
////                MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
////                [self.navigationController pushViewController:vc animated:YES];
//            }
//            
//        };
//        cell.selectionStyle= UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.comeform = @"sencondPage";
//        cell.bannerArr = self.bannerArr;
//        
//        return cell;
//    }
//    
//    if ( [model.type isEqualToString:@"SUB_TYPES"]) {
//        MHGoodsKindsCell *cell ;
//         __weak __typeof(self) weakSelf = self;
//        if (!klArrayisEmpty(self.categoryItemArray)) {
//            cell = [[MHGoodsKindsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MHGoodsKindsCell class]) menuArray:self.categoryItemArray ImageArray:nil];
//        }
//        else{
//            cell = [[MHGoodsKindsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MHGoodsKindsCell class])];
//        }
//        
//        cell.block = ^(NSInteger type, NSString *titile) {
//            MHLog(@"%ld %@",type,titile);
//            MHHomeGoodsTypeListController *vc = [[MHHomeGoodsTypeListController alloc] initWithTypeId:[NSString stringWithFormat:@"%ld",type] parentID:[NSString stringWithFormat:@"%ld",type]];
//            vc.navtitle = titile;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//            
//        };
//        
//        cell.selectionStyle= UITableViewCellSelectionStyleNone;
////        cell.backgroundColor =kRandomColor;
//        return cell;
//    }
//        }else{
//            if (indexPath.section >=self.sectionArr.count && indexPath.row == 0) {
//                MHtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHtitleCell class])];
//                cell.selectionStyle= UITableViewCellSelectionStyleNone;
//                cell.title.text = @"优品推荐";
//                //        cell.backgroundColor =kRandomColor;
//                
//                return cell;
//            }
//        }
//    
//    }
    
    HomeproductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeproductCell class])];
    if ([self.listArr count]>0) {
       
             cell.ProductModel = self.listArr[indexPath.row];
        
       
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.sectionArr.count >0) {
//        if (indexPath.section == self.sectionArr.count) {
//            if ([_listArr count] >0) {
//                if (indexPath.row == 0) {
//                    return;
//                }
//                MHProductModel *model = _listArr[indexPath.row];
//                MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
//                vc.productId = model.productId;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//
//        }
//    }
//
    if ([_listArr count] >0) {
        
                        MHProductModel *model = _listArr[indexPath.row];
                        MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
                        vc.productId = model.productId;
                        [self.navigationController pushViewController:vc animated:YES];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
