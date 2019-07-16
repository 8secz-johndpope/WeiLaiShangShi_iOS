//
//  HSNewsRecommendViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsRecommendViewController.h"
#import "MHWebviewViewController.h"
#import "HSNewsOneCell.h"
#import "HSNewTwoCell.h"
#import "HSNewsThirdCell.h"
#import "HSNewsFourCell.h"
#import "SJTableViewCell.h"
#import "SJVideoPlayer.h"
#import "AliyunOSSDemo.h"
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
#import "HSNewsModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSNewsSixCell.h"
#import "HSNewsDetailViewController.h"
#import "HSEmporCell.h"
#import "MHTaskDetailModel.h"
#import "HSMemberThreeCell.h"
#import "HSMemberNoImgCell.h"
#import "HSMemberOneCell.h"
#import "HSMemberOneRight.h"
#import "HSMemberOneLeftCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSFriendShopViewController.h"
#import "HSNewsDetailViewController.h"
#import "HSTaskShareViewController.h"
#import "HSNewsOneCellRight.h"
#import "HSNewsOneLeftCell.h"
#import "HSQRcodeVC.h"
@interface HSNewsRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,SJPlayerAutoplayDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate,MHNoDataPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong) NSMutableArray *filmArr;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong) NSMutableArray *listArr;
//下拉加载
@property (nonatomic, strong) NSMutableArray *listArr2;
//下拉加载
@property (nonatomic, strong) NSMutableArray *listArrAd;


//上拉刷新
@property (nonatomic, strong) NSMutableArray *listArr3;

@property (nonatomic, strong) NSString *Fristdatetime;
//下拉加载的时间
@property (nonatomic, strong) NSString *dowmdatetime;
//上拉刷新的时间
@property (nonatomic, strong) NSString *updatetime;
//全局广告
@property (nonatomic, strong) NSString *advIds;
//全局任务
@property (nonatomic, strong) NSString *taskIds;

//guge
@property (nonatomic, assign) BOOL IsNodata;
@property (nonatomic, strong)NSMutableDictionary *userDic;
@property (nonatomic, strong)UIImageView *headimg;

@end
@implementation HSNewsRecommendViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self getUserInfo];
  
}
-(void)getUserInfo
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        
        self.userDic = [NSMutableDictionary dictionary];
        [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.userDic = [response valueForKey:@"data"];
            }
        }];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.advIds =@"";
    self.taskIds = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createview];
    self.index = 1;
    self.IsNodata = NO;
    self.listArr = [NSMutableArray array];
    self.listArr3 = [NSMutableArray array];
    self.listArrAd = [NSMutableArray array];
    
      [self getdata];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshhome:) name:KNotificationRereshPAGEONE object:nil];
    // Do any additional setup after loading the view.
}
-(void)refreshhome:(NSNotification *)notification
{
    NSLog(@"收到消息啦!!!\n %ld \n %@",self.locx, [notification.userInfo objectForKey:@"index"]);
    
    
    
    if ([[NSString stringWithFormat:@"%ld",self.locx] isEqualToString:[notification.userInfo objectForKey:@"index"]]) {
        self.updatetime = @"";
        self.advIds = @"";
        self.listArr = [NSMutableArray array];
        self.listArr3 = [NSMutableArray array];
        [self getReshData];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }
    
    
}
-(void)getdata
{
    
    [[MHUserService sharedInstance]initwithHSRecommendAriticeCategorypageIndex:1 pageSize:10 advIds:@"" taskIds:@""  dateTime:@""  CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[HSNewsModel baseModelWithArr:response[@"data"][@"list"]]];
            self.Fristdatetime =response[@"data"][@"dateTime"];
            self.dowmdatetime = response[@"data"][@"dateTime"];
          
            for (HSNewsModel *model  in self.listArr) {
                
                if ([model.tag isEqualToString:@"广告"]) {
                    if ([self.advIds isEqualToString:@""]) {
                         self.advIds = [NSString stringWithFormat:@"%@",model.id];
                    }else{
                        self.advIds = [NSString stringWithFormat:@"%@,%@",self.advIds,model.id];
                    }
                }

                if (!klDicisEmpty(model.extra)) {
                    MHTaskDetailModel *taskmodel =[MHTaskDetailModel baseModelWithDic:model.extra];
                    if ([self.taskIds isEqualToString:@""]) {

                        self.taskIds = [NSString stringWithFormat:@"%@", taskmodel.id];
                    }else{
                        self.taskIds = [NSString stringWithFormat:@"%@,%@",self.taskIds, taskmodel.id];
                    }
                }
                
               
                
               
            }
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView cyl_reloadData];
        }
        if (error) {
            [self endRefresh];
            [self.tableView cyl_reloadData];
            KLToast(@"请检查网络情况");
        }
        
    }];
    
}
//上拉加载更多
-(void)getdataMore
{
    self.listArr2 = [NSMutableArray array];
    [[MHUserService sharedInstance]initwithHSRecommendAriticeCategorypageIndex:self.index pageSize:10 advIds:self.advIds taskIds:self.taskIds  dateTime:self.dowmdatetime  CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            [self.listArr2  addObjectsFromArray:[HSNewsModel baseModelWithArr:response[@"data"][@"list"]]];
             self.dowmdatetime = response[@"data"][@"dateTime"];
            for (HSNewsModel *model  in self.listArr2) {
                if ([model.tag isEqualToString:@"广告"]) {
                    if ([self.advIds isEqualToString:@""]) {
                        self.advIds = [NSString stringWithFormat:@"%@", model.id];
                    }else{
                        self.advIds = [NSString stringWithFormat:@"%@,%@",self.advIds, model.id];
                    }
                }
                if (!klDicisEmpty(model.extra)) {
                    MHTaskDetailModel *taskmodel =[MHTaskDetailModel baseModelWithDic:model.extra];
                    if ([self.taskIds isEqualToString:@""]) {
                        
                        self.taskIds = [NSString stringWithFormat:@"%@", taskmodel.id];
                    }else{
                        self.taskIds = [NSString stringWithFormat:@"%@,%@",self.taskIds, taskmodel.id];
                    }
                }
            }
            [self.listArr addObjectsFromArray:self.listArr2];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
//            for (int i = 0 ; i < self.listArr.count; i++) {
//                HSNewsModel *mdeol = [self.listArr objectAtIndex:i];
//                if (mdeol.top == 1) {
//                    [self.listArr removeObject:mdeol];
//                    [self.listArr insertObject:mdeol atIndex:0];
//                }
//            }
            [self.tableView cyl_reloadData];
        }
        if (error) {
            [self endRefresh];
            KLToast(@"请检查网络情况");
        }
        
    }];
    
}
//下拉刷新
-(void)getReshData
{
   
    [[MHUserService sharedInstance]initwithRefreshHSRecommendAriticeCategorypageIndex:0 pageSize:10 advIds:self.advIds taskIds:self.taskIds dateTime:self.updatetime   CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            if (self.listArr3.count > 0) {
                [self.listArr3  insertObjects:[HSNewsModel baseModelWithArr:response[@"data"][@"list"]] atIndex:0];
            }else{
                [self.listArr3  addObjectsFromArray:[HSNewsModel baseModelWithArr:response[@"data"][@"list"]]];
            }
            ;
              self.updatetime = response[@"data"][@"dateTime"];
            for (HSNewsModel *model  in self.listArr3) {
                if ([model.tag isEqualToString:@"广告"]) {
                    if ([self.advIds isEqualToString:@""]) {
                         self.advIds = [NSString stringWithFormat:@"%@", model.id];
                    }else{
                          self.advIds = [NSString stringWithFormat:@"%@,%@",self.advIds, model.id];
                    }
                  
                }
                if (!klDicisEmpty(model.extra)) {
                    MHTaskDetailModel *taskmodel =[MHTaskDetailModel baseModelWithDic:model.extra];
                    if ([self.taskIds isEqualToString:@""]) {
                        
                        self.taskIds = [NSString stringWithFormat:@"%@", taskmodel.id];
                    }else{
                        self.taskIds = [NSString stringWithFormat:@"%@,%@",self.taskIds, taskmodel.id];
                    }
                }
            }
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            if (self.listArr3.count > 0) {
                [self getReshDataAct];
            }else{
                [self endRefresh];
                
            }
         
        }
        if (error) {
            [self endRefresh];
            KLToast(@"请检查网络情况");
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
    [self getdata];
}
-(void)NodataemptyOverlayClicked:(id)sender
{
    [self getReshData];
    self.IsNodata = YES;;
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.textLabel.text= @"点击刷新";
     networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

-(void)getReshDataAct
{
    NSMutableArray *Arr;
    NSMutableArray *indexAdArr;
    if (self.listArr3.count > 0) {
        if (self.listArr3.count < 10 ) {
            
            indexAdArr = [NSMutableArray array];
            Arr = [NSMutableArray array];
            for (int i = 0; i< self.listArr3.count; i++) {
                HSNewsModel *model = self.listArr3[i];
                if ([model.tag isEqualToString:@"广告"] && model.top != 1) {
                    [indexAdArr addObject:model];
                }else{
                    if (Arr.count == 10) {
                        break;
                    }
                    [Arr addObject:model];
                }
            }
            
            
        }else{
            //取数据
            //存储直到3条s广告数据
           indexAdArr = [NSMutableArray array];
            Arr = [NSMutableArray array];
            for (int i = 0; i< self.listArr3.count; i++) {
                 HSNewsModel *model = self.listArr3[i];
                if ([model.tag isEqualToString:@"广告"]&&model.top != 1) {
                    [indexAdArr addObject:model];
                }else{
                    if (Arr.count == 10) {
                        break;
                    }
                    [Arr addObject:model];
                }
            }
         
            
     
        }
        
        if (indexAdArr.count == 0) {
            
            if (self.listArrAd.count > 0) {
                for (int i = 0; i < self.listArrAd.count; i++) {
                    HSNewsModel *model = self.listArrAd[i];
                    [self.listArr removeObject:model];
                }
                
            }
            
        }
        if (indexAdArr.count <= self.listArrAd.count) {
           
            for (int i = 0; i < self.listArrAd.count; i++) {
                if (i < indexAdArr.count) {
                    HSNewsModel *model = indexAdArr[i];
                    [self.listArrAd removeObjectAtIndex:i];
                    [self.listArrAd insertObject:model atIndex:i];
                }else{
                    HSNewsModel *model =  self.listArrAd[i];
                    [indexAdArr addObject:model];
                   
                }
            }
           
            
        }else{
           
           
            
        }
        
        
        if (self.listArrAd.count ==0) {
            self.listArrAd = indexAdArr;
        }
        
        
        // 新数组的置顶文章
        NSInteger new_top = 0;
        NSMutableArray *new_topArr = [NSMutableArray array];
        NSInteger old_top = 0;
        
        for (int i = 0; i < Arr.count; i++) {
            HSNewsModel *model = Arr[i];
            if (model.top ==1) {
                if (![model.tag isEqualToString:@"广告"]) {
                    new_top ++;
                    [new_topArr addObject:model];
                }
            }
        }
        
        for (int i = 0; i < self.listArr.count; i++) {
            HSNewsModel *model = self.listArr[i];
            if (model.top ==1) {
                if (![model.tag isEqualToString:@"广告"]) {
                    old_top ++;
                    
                }
            }
        }
        if (old_top >= new_top) {
            //直接替换
           
            if (new_top != 0) {
                if (old_top != 0 ) {
                    [Arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[HSNewsModel class]]) {
                            HSNewsModel *model = obj;
                            if (model.top == 1) {
                                // 文章置顶 替换掉原来的文章
                                if (![model.tag isEqualToString:@"广告"]) {
                                    
                                    for (HSNewsModel *modelold in self.listArr) {
                                        if (modelold.top == 1) {
                                            if (![modelold.tag isEqualToString:@"广告"]) {
                                                NSInteger index = [self.listArr indexOfObject:modelold];
                                                [self.listArr removeObject:modelold];
                                                [Arr removeObject:model];
                                                [new_topArr addObject:model];
                                                [self.listArr insertObject:model atIndex:index];
                                                break;
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }];
                }
            }

        }else{
            if (old_top == 0) {
                [Arr removeObjectsInArray:new_topArr];
            }else{
                [self.listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[HSNewsModel class]]) {
                        HSNewsModel *modelold = obj;
                        if (modelold.top == 1) {
                            if (![modelold.tag isEqualToString:@"广告"]) {
                                for (HSNewsModel *model in Arr ) {
                                    if (model.top == 1) {
                                        if (![model.tag isEqualToString:@"广告"]) {
                                            NSInteger index = [self.listArr indexOfObject:modelold];
                                            [self.listArr removeObject:modelold];
                                            [Arr removeObject:model];
                                            [new_topArr removeObject:model];
                                            [self.listArr insertObject:model atIndex:index];
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }];
            }
        }
        // 新数组的置顶文章
        NSInteger new_Adtop = 0;
        NSMutableArray *new_AdtopArr = [NSMutableArray array];
        NSInteger old_Adtop = 0;
        for (int i = 0; i < Arr.count; i++) {
            HSNewsModel *model = Arr[i];
            if (model.top ==1) {
                if ([model.tag isEqualToString:@"广告"]) {
                    new_Adtop ++;
                    [new_AdtopArr addObject:model];
                }
            }
        }
        
        for (int i = 0; i < self.listArr.count; i++) {
            HSNewsModel *model = self.listArr[i];
            if (model.top ==1) {
                if ([model.tag isEqualToString:@"广告"]) {
                    old_Adtop ++;
                    
                }
            }
        }
        if (old_Adtop >= new_Adtop) {
            //直接替换
            
            if (new_Adtop != 0 ) {
     
            [Arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HSNewsModel class]]) {
                    HSNewsModel *model = obj;
                    if (model.top == 1) {
                        if ([model.tag isEqualToString:@"广告"]) {
                            // 有广告置顶 删除原有的广告的
                            for (HSNewsModel *modelold in self.listArr) {
                                if (modelold.top == 1) {
                                    if ([modelold.tag isEqualToString:@"广告"]) {
                                        NSInteger index = [self.listArr indexOfObject:modelold];
                                        [self.listArr removeObject:modelold];
                                        [self.listArr insertObject:model atIndex:index];
                                        [Arr removeObject:model];
                                        [new_AdtopArr removeObject:model];
                                        break;
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }];
        }
            
        }else{
            
            if (old_Adtop == 0 ) {
                [Arr removeObjectsInArray:new_AdtopArr];
            }else{
                [self.listArr  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[HSNewsModel class]]) {
                        HSNewsModel *modelold = obj;
                        if (modelold.top == 1) {
                            if ([modelold.tag isEqualToString:@"广告"]) {
                                for (HSNewsModel *model in Arr ) {
                                    if (model.top == 1) {
                                        if ([model.tag isEqualToString:@"广告"]) {
                                            NSInteger index = [self.listArr indexOfObject:modelold];
                                            [self.listArr removeObject:modelold];
                                            [self.listArr insertObject:model atIndex:index];
                                            [Arr removeObject:model];
                                            [new_AdtopArr removeObject:model];
                                            break;
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }];
            }
            
            ;
            
           
            
            
            
            
        }
        
        
        
        
        
        [self.listArr3 removeObjectsInArray:Arr];
        [self.listArr3 removeObjectsInArray:indexAdArr];
        
        if (new_top > old_top) {
            if (new_Adtop > old_Adtop) {
                // 新的置顶广告 > 以前的广告 新的置顶文章 > 以前的置顶文章
                //1  先插入广告
                [self.listArr insertObjects:new_AdtopArr atIndex:old_Adtop];
                //2  插入置顶文章
                [self.listArr insertObjects:new_topArr atIndex:old_Adtop+old_top+new_AdtopArr.count];
                //3  插入普通
                [self.listArr insertObjects:Arr atIndex:old_Adtop+old_top+new_AdtopArr.count+new_topArr.count];
                
                
                
            }else{
                // 新的置顶广告 <= 以前的广告   新的置顶文章> 以前的置顶文章
                //1  先插入广告
                //                [self.listArr insertObjects:new_AdtopArr atIndex:old_Adtop];
                //  位置够不需要插入
                //2  插入置顶文章
                [self.listArr insertObjects:new_topArr atIndex:old_Adtop+old_top];
                //3  插入普通
                [self.listArr insertObjects:Arr atIndex:old_Adtop+old_top+new_topArr.count];
            }
            
            
        }else{
            
            if (new_Adtop > old_Adtop) {
                // 新的置顶广告 > 以前的广告 新的置顶文章 <= 以前的置顶文章
                //1  先插入广告
                [self.listArr insertObjects:new_AdtopArr atIndex:old_Adtop];
                //2  插入置顶文章
                //  无需插入
                //                [self.listArr insertObjects:new_topArr atIndex:old_Adtop+old_top+new_AdtopArr.count];
                //3  插入普通
                [self.listArr insertObjects:Arr atIndex:old_Adtop+old_top+new_AdtopArr.count];
                
                
            }else{
                // 新的置顶广告 <= 以前的广告   新的置顶文章 <= 以前的置顶文章
                //1  先插入广告 (无需插入)
                //                [self.listArr insertObjects:new_AdtopArr atIndex:old_Adtop];
                //2  插入置顶文章
                //  无需插入
                //                [self.listArr insertObjects:new_topArr atIndex:old_Adtop+old_top+new_AdtopArr.count];
                //3  插入普通
                [self.listArr insertObjects:Arr atIndex:old_Adtop+old_top];
            }
            
            
        }
        // 插入固定位置的广告
        NSInteger sumTop = 0;
        for (int i = 0; i < 20; i++) {
             HSNewsModel *modelold = self.listArr[i];
            if (modelold.top == 1) {
                sumTop ++;
            }
        }
        
        for (int i = 0; i < indexAdArr.count; i++) {
            HSNewsModel *modelold = indexAdArr[i];
            if (modelold.top == 1) {
//                 [self.listArr insertObject:modelold atIndex:0];
            }else{
                 [self.listArr insertObject:modelold atIndex:modelold.advIndex+sumTop];
            }
           
        }
        if (indexAdArr.count == 0) {
            for (int i = 0; i <  self.listArrAd.count; i++) {
                HSNewsModel *modelold = self.listArrAd[i];
                if (modelold.top == 1) {
//                    [self.listArr insertObject:modelold atIndex:0];
                }else{
                    [self.listArr insertObject:modelold atIndex:modelold.advIndex+sumTop];
                }
            }
        }
        
        
        [self endRefresh];
        [self.tableView cyl_reloadData];
        
    }else{
        [self getReshData];
    }
}

-(void)createview
{
    //    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    //    bgview.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:bgview];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self endRefresh];
        [self getReshData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.IsNodata) {
            self.index = 0;
             self.index ++;
            self.IsNodata = NO;
        }else{
             self.index ++;
        }
       
        [self getdataMore];
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.1,kScreenWidth, kScreenHeight-kTabBarHeight-kRealValue(44)-kRealValue(42)-kStatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[HSEmporCell class] forCellReuseIdentifier:NSStringFromClass([HSEmporCell class])];
        [_tableView registerClass:[HSNewsOneCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsOneCell class])];
        [_tableView registerClass:[HSNewTwoCell class] forCellReuseIdentifier:NSStringFromClass([HSNewTwoCell class])];
        [_tableView registerClass:[HSNewsThirdCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsThirdCell class])];
        [_tableView registerClass:[HSNewsFourCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsFourCell class])];
         [_tableView registerClass:[HSNewsSixCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsSixCell class])];
        [_tableView registerClass:[HSNewsOneLeftCell class] forCellReuseIdentifier:NSStringFromClass([HSNewsOneLeftCell class])];
        [_tableView registerClass:[HSNewsOneCellRight class] forCellReuseIdentifier:NSStringFromClass([HSNewsOneCellRight class])];
        [_tableView registerClass:[HSMemberOneCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneCell class])];
       
        [_tableView registerClass:[HSMemberOneLeftCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
        [_tableView registerClass:[HSMemberNoImgCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
        [_tableView registerClass:[HSMemberOneRight class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneRight class])];
         [_tableView registerClass:[HSMemberThreeCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberThreeCell class])];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.listArr.count > 0) {
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        if (klDicisEmpty(model.extra)) {
            if ([model.articleType isEqualToString:@"ARTICLE"]) {
                //文章
                if ([model.coverPos isEqualToString:@"LEFT"]) {
                    
                    return   kRealValue(114);
                }
               if ([model.coverPos isEqualToString:@"RIGHT"]) {
                    
                    return   kRealValue(114);
                }
                
                if (model.cover.count == 0 ) {
                    if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> 30) {
                        return 100;
                    }
                    return kRealValue(55) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                }
                if (model.cover.count>1 ) {
                    
                    if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
                        return kRealValue(185);
                    }
                    return   kRealValue(133) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                }
                if (model.cover.count == 1) {
                    if ([model.coverPos isEqualToString:@"LEFT"]) {
                        
                        return   kRealValue(114);
                    }
                    else if ([model.coverPos isEqualToString:@"RIGHT"]) {
                        
                        return   kRealValue(114);
                    }
                    else {
                        if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
                            return kRealValue(320);
                        }
                         return kRealValue(270) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                    }
                }

            }
            if ([model.articleType isEqualToString:@"VIDEO"]) {
                
                
                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)] > 50) {
                    return   kRealValue(270) + kRealValue(47);
                }
                return   kRealValue(270) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
           
        }else{
             MHTaskDetailModel *taskmodel =[MHTaskDetailModel baseModelWithDic:model.extra];
            if (taskmodel.cover.count == 0) {
                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)] > 50) {
                    return   kRealValue(100);
                }
                return kRealValue(55) + [[NSString stringWithFormat:@"%@",taskmodel.title] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
            if (taskmodel.cover.count >1 ) {
                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)] > 50) {
                    return   kRealValue(185);
                }
                
                return kRealValue(133) + [[NSString stringWithFormat:@"%@",taskmodel.title] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
            }
            if (taskmodel.cover.count == 1) {
                if ([taskmodel.coverPos isEqualToString:@"LEFT"]) {
                    
                    return   kRealValue(124);
                }
                else if ([taskmodel.coverPos isEqualToString:@"RIGHT"]) {
                    
                    return   kRealValue(124);
                }
                else {
                    if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)] > 50) {
                        return   kRealValue(320);
                    }
                    
                    return kRealValue(267) + [[NSString stringWithFormat:@"%@",taskmodel.title] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
                }
                
        }
        
        
        }
    }
    
    return   0;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.listArr.count > 0 ) {
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
       
        if (klDicisEmpty(model.extra)) {
        
        
        
        if ([model.articleType isEqualToString:@"ARTICLE"]) {
            //文章
            if ([model.coverPos isEqualToString:@"LEFT"]) {
                
                HSNewsOneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneLeftCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                return cell;
            }
            if ([model.coverPos isEqualToString:@"RIGHT"]){
                HSNewsOneCellRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCellRight class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                 return cell;
            }
            if (model.cover.count == 0 ) {
                HSNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                return cell;
            }
            if (model.cover.count >1 ) {
                HSNewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewTwoCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:model];
                return cell;
            }
            if (model.cover.count == 1) {
                
                if ([model.coverPos isEqualToString:@"LEFT"]) {
                    
                    HSNewsOneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneLeftCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:model];
                    return cell;
                }else if ([model.coverPos isEqualToString:@"RIGHT"]){
                    HSNewsOneCellRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsOneCellRight class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:model];
                    
                }else{
                    HSNewsThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsThirdCell class])];
                    [cell createviewWithModel:model];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    return cell;
                }
                
               
            }
           
        }
        if ([model.articleType isEqualToString:@"VIDEO"]){
            HSNewsSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsSixCell class])];
            [cell createviewWithModel:model];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
        }
//        if ([model.articleType isEqualToString:@"ADV"]) {
//            //广告
//            HSNewsSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSNewsSixCell class])];
//            [cell createviewWithModel:model];
//            cell.authlabel.hidden = YES;
//            cell.timelabel.hidden = YES;
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            return cell;
//        }
        }else{
            MHTaskDetailModel *taskmodel =[MHTaskDetailModel baseModelWithDic:model.extra];
            if (taskmodel.cover.count == 0) {
                HSMemberNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:taskmodel];
                return cell;
            }
            if (taskmodel.cover.count >1 ) {
                HSMemberThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberThreeCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                [cell createviewWithModel:taskmodel];
                return cell;
            }
            if (model.cover.count == 1) {
                if ([taskmodel.coverPos isEqualToString:@"LEFT"]) {
                    
                    HSMemberOneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:taskmodel];
                    return cell;
                }
                else if ([taskmodel.coverPos isEqualToString:@"RIGHT"]) {
                    HSMemberOneRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneRight class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:taskmodel];
                    return cell;
                }
                else {
                    HSMemberOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneCell class])];
                    cell.selectionStyle= UITableViewCellSelectionStyleNone;
                    [cell createviewWithModel:taskmodel];
                    return cell;
                }
                
                
            }
            
            
        }
    }
    
    
    HSEmporCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSEmporCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        
        if (klDicisEmpty(model.extra)) {
       
        
        HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
        HSNewsModel *model = [self.listArr objectAtIndex:indexPath.row];
        
        vc.ariticeID =model.id;
        if ([model.articleType isEqualToString:@"VIDEO"]) {
            vc.IsshowTop = YES;
            
        }else{
             vc.IsshowTop = YES;
        }
       
        if ([model.tag isEqualToString:@"广告"]) {
            vc.IsAd = @"ad";
        }
        [self.navigationController pushViewController:vc animated:YES];
        }else{
            MHTaskDetailModel *taskmodel = [MHTaskDetailModel baseModelWithDic:model.extra];
            if ([taskmodel.property isEqualToString:@"REVIEW"]) {
                //审核任务
                HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([taskmodel.property isEqualToString:@"APPOINT"]){
                //阅读指定任务
                
                
            }else if ([taskmodel.property isEqualToString:@"APPOINT_ADV"]) {
                //阅读指定广告
//                [self getMHTaskDetailModel:taskmodel];
                
            }else if ([taskmodel.property isEqualToString:@"SHARE"]) {
                //分享任务
                
                HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                    vc.IsshowTop = YES;
                    
                }else{
                    vc.IsshowTop = NO;
                }
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([taskmodel.property isEqualToString:@"DOWNLOAD"]) {
                //下载任务
                HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                    vc.IsshowTop = YES;
                    
                }else{
                    vc.IsshowTop = NO;
                }
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([taskmodel.property isEqualToString:@"READ_ADV"]) {
                //阅读广告任务
                
                
            }else if ([taskmodel.property isEqualToString:@"READ"]) {
                //阅读广告任务
                //下载任务
                HSTaskShareViewController *vc = [[HSTaskShareViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",taskmodel.id];
                if ([taskmodel.detailType isEqualToString:@"VIDEO"]) {
                    vc.IsshowTop = YES;
                    
                }else{
                    vc.IsshowTop = NO;
                }
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            
        }
    }
  
}
-(void)getMHTaskDetailModel:(MHTaskDetailModel *)model
{
    // 阅读指定任务
    // 未领取
    if ([model.status isEqualToString:@"PENDING"]) {
        
        if (!klDicisEmpty(self.userDic)) {
            //判断友力值
            if ([model.power integerValue] > [[self.userDic valueForKey:@"availablePower"] integerValue] ) {
                //友力值不足，展示弹框
                [[MHBaseClass sharedInstance]presentAlertWithtitle:@"哎呀，友力值余额不足无法领取任务啦！ 解决办法：①邀友获赠②友力值商城购买" message:@"" leftbutton:@"取消" rightbutton:@"获取友力值" leftAct:^{
                    HSQRcodeVC *vc =[[HSQRcodeVC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } rightAct:^{
                    HSFriendShopViewController *vc = [[HSFriendShopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];;
                return;
            }else{
                
            }
        }else{
            
        }
        
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                //获取任务类型
                [[MHUserService sharedInstance]initwithHSAriticeDetailariticeId:model.remark ISAd:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        [MBProgressHUD hideHUD];
                        if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                            //视频
                            
                            HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                            vc.ariticeID = model.remark;
                            if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                                vc.IsAd = @"ad";
                            }else{
                                vc.IsAd =@"no";
                            }
                            
                            vc.IsshowTop =YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                        }
                        if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"ARTICLE"]) {
                            //文章
                            HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                            vc.ariticeID = model.remark;
                            if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                                vc.IsAd = @"ad";
                            }else{
                                vc.IsAd =@"no";
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                        }
                        
                        
                    }else{
                        [MBProgressHUD hideHUD];
                        KLToast(response[@"message"]);
                    }
                    if (error) {
                        [MBProgressHUD hideHUD];
                    }
                    
                    
                }];
            }else{
                
                [MBProgressHUD hideHUD];
                KLToast([response valueForKey:@"message"]);
                
            }
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [MBProgressHUD showActivityMessageInWindow:@"领取失败,请刷新后重试"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                    });
                    
                });
            }
        }];
    }
    //进行中
    if ([model.status isEqualToString:@"ACTIVE"]) {
        [MBProgressHUD showActivityMessageInWindow:@""];
        [[MHUserService sharedInstance]initwithHSAriticeDetailariticeId:model.remark ISAd:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [MBProgressHUD hideHUD];
                if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"VIDEO"]) {
                    //视频
                    
                    HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                    vc.ariticeID = model.remark;
                    if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                        vc.IsAd = @"ad";
                    }else{
                        vc.IsAd =@"no";
                    }
                    vc.IsshowTop =YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"articleType"] isEqualToString:@"ARTICLE"]) {
                    //文章
                    HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                    if ([model.property isEqualToString:@"APPOINT_ADV"]) {
                        vc.IsAd = @"ad";
                    }else{
                        vc.IsAd =@"no";
                    }
                    vc.ariticeID = model.remark;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                
                
            }else{
                [MBProgressHUD hideHUD];
                KLToast(response[@"message"]);
            }
            if (error) {
                [MBProgressHUD hideHUD];
            }
            
            
        }];
    }
    if ([model.status isEqualToString:@"DONE"]) {
        KLToast(@"您已完成该任务");
    }
    
    
    
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
