//
//  HSShopChildVC.m
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSShopChildVC.h"
#import "HSShopCollectionCell.h"
#import "HSShopDetailVC.h"
#import "MHWebviewViewController.h"
#import "HSShopItemModel.h"
#import "MHLoginViewController.h"



@interface HSShopChildVC ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (strong, nonatomic)  NSString *typeId;
@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, strong)NSMutableArray  *listArr;

@end

@implementation HSShopChildVC


- (instancetype)initWithCategoryId:(NSString *)typeId
{
    self = [super init];
    if (self) {
        
        _typeId = typeId;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithHexString:@"f2f2f2"];
    self.index = 1;
    _listArr = [NSMutableArray array];
    [self initCollectionView];
    [self getData];
}


-(void)getData{
    [[MHUserService sharedInstance]initwithHSProdList:@"INTEGRAL" pageIndex:self.index pageSize:10 categoryId:_typeId CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
            }
            [self.listArr addObjectsFromArray:[HSShopItemModel baseModelWithArr:response[@"data"]]];
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.collectionView reloadData];
        }
    }];
}



-(void)endRefresh{
 [self.collectionView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
  [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}


#pragma mark initCollection
- (void) initCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kRealValue(170),kRealValue(253));
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];// 128  71
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight - kTopHeight  -  kRealValue(50)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.collectionView registerClass:[HSShopCollectionCell class] forCellWithReuseIdentifier:@"collectioncell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.alwaysBounceHorizontal = YES;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
}

#pragma collectionview delegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.listArr count] ;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HSShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    if ([self.listArr count] > 0) {
        [cell creatItemModel:self.listArr[indexPath.item]];
    }

    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HSShopItemModel *itemModel = self.listArr[indexPath.item];
    HSShopDetailVC *VC = [[HSShopDetailVC alloc] initWithProdId:[NSString stringWithFormat:@"%ld",itemModel.productId]];
    [self.navigationController pushViewController:VC animated:YES];
    
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kRealValue(12), kRealValue(12),kRealValue(12), kRealValue(12));
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <=0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationFatherSrcoll object:nil userInfo:nil];
    }
    
    
}

@end
