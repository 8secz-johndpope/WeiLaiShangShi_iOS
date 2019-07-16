//
//  MHShopCarViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarViewController.h"
#import "MHShopCarCell.h"
#import "MHShopCarAction.h"
#import "MHShopCarTableviewProxy.h"
#import "MHShopCarBottomView.h"
#import "MHShopCarSizeAlert.h"
#import "MHShopCarHeadView.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHShopCarBrandModel.h"
#import "MHShopCarProductModel.h"
#import "MHSumbitOrderVC.h"
#import "MHProDetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
//#import "MHTaskVC.h"
//#import "MHNewbeeVC.h"
@interface MHShopCarViewController ()<UITableViewDataSource,UITableViewDelegate, MHNetworkErrorPlaceHolderDelegate,ShopCarProxyFrameDelegate>
@property (nonatomic, strong) UITableView *shopcartTableView;   /**< 购物车列表 */
@property (nonatomic, strong) UIButton *editButton;    /**< 编辑按钮 */
@property (nonatomic, strong) MHShopCarTableviewProxy *shopcartTableViewProxy;    /**< tableView代理 */
@property (nonatomic, strong) MHShopCarAction *ShopCarAction;  /**< 购物车的逻辑处理 */
@property (nonatomic, strong) MHShopCarBottomView *shopcarBottomView;  /**< 购物车底部界面 */
@end

@implementation MHShopCarViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestShopcartListData];
    if (self.shopcarBottomView) {
        self.shopcarBottomView.allSelectButton.selected = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.IsComeFromdetail) {
        self.isShowLiftBack = YES;
    }else{
        self.isShowLiftBack = NO;
    }
    self.title = @"购物车";
    self.view.backgroundColor =KColorFromRGB(0xF1F2F1);
    [self createview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti2:) name:KNotificationShopCarChange object:nil];
}
-(void)noti2:(NSNotification *)noti
{
    
}
-(void)createview
{
    [self addview];
    [self setlayout];
    
}

- (void)requestShopcartListData {
    [self.ShopCarAction requestShopcartProductList];
}

-(void)addview
{
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    [self.view addSubview:self.shopcartTableView];
    [self.view addSubview:self.shopcarBottomView];
    
    
}
#pragma mark lazy

-(MHShopCarBottomView *)shopcarBottomView
{
    if (_shopcarBottomView == nil) {
        _shopcarBottomView = [[MHShopCarBottomView alloc]init];
        __weak __typeof(self) weakself = self;
        _shopcarBottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected) {
            MHLog(@"%d",isSelected);
            [weakself.ShopCarAction selectAllProductWithStatus:isSelected]; 
        };
        _shopcarBottomView.shopcartBotttomViewDeleteBlock = ^{
            [weakself.ShopCarAction beginToDeleteSelectedProducts];
        };
        _shopcarBottomView.shopcartBotttomViewSettleBlock = ^{
             [weakself.ShopCarAction settleSelectedProducts];
        };
        
        
        
        
    }
    return _shopcarBottomView;
}

-(UIButton *)editButton
{
    if (_editButton == nil) {
            _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _editButton.frame = CGRectMake(0, 0, 40, 40);
            [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
            [_editButton setTitle:@"保存" forState:UIControlStateSelected];
            [_editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateSelected];
         [_editButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
        return _editButton;
    
}

- (void)editButtonAction {
    self.editButton.selected = !self.editButton.isSelected;
    self.shopcartTableViewProxy.isEdit = self.editButton.selected;
    [self.shopcartTableView reloadData];
    [self.shopcarBottomView changeShopcartBottomViewWithStatus:self.editButton.isSelected];
}
-(MHShopCarAction *)ShopCarAction
{
    if (_ShopCarAction == nil) {
        _ShopCarAction = [[MHShopCarAction alloc]init];
        _ShopCarAction.delegate = self;
    }
    return _ShopCarAction;
}
- (UITableView *)shopcartTableView {
    if (_shopcartTableView == nil){
        _shopcartTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _shopcartTableView.backgroundColor = KColorFromRGB(0xF1F2F1);
        _shopcartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_shopcartTableView registerClass:[MHShopCarCell class] forCellReuseIdentifier:@"MHShopCarCell"];
        [_shopcartTableView registerClass:[MHShopCarHeadView class] forHeaderFooterViewReuseIdentifier:@"MHShopCarHeadView"];
        _shopcartTableView.showsVerticalScrollIndicator = NO;
        _shopcartTableView.delegate = self.shopcartTableViewProxy;
        _shopcartTableView.dataSource = self.shopcartTableViewProxy;
        _shopcartTableView.rowHeight = kRealValue(134);
    }
    return _shopcartTableView;
}
- (MHShopCarTableviewProxy *)shopcartTableViewProxy {
    if (_shopcartTableViewProxy == nil){
        _shopcartTableViewProxy = [[MHShopCarTableviewProxy alloc] init];
        _shopcartTableViewProxy.delegate = self;
        __weak __typeof(self) weakSelf = self;
        _shopcartTableViewProxy.shopcarProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section) {
             [weakSelf.ShopCarAction selectBrandAtSection:section isSelected:isSelected];
            
        };
        //去升级的按钮
        _shopcartTableViewProxy.UsergotoUpgrade = ^{
            
            if ([[GVUserDefaults standardUserDefaults].userRole intValue] == 0) {
                //内部员工
            }
            if ([[GVUserDefaults standardUserDefaults].userRole intValue] == 1) {
                //
//                MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[GVUserDefaults standardUserDefaults].userRole intValue] > 1) {
                //
//                MHTaskVC *vc = [[MHTaskVC alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
            }
            
        };
        
        
        //进入详情页面
        _shopcartTableViewProxy.shopCarProxyEnterDetail = ^(NSIndexPath *indexPath) {
              [weakSelf.ShopCarAction enterDetailAtIndexPath:indexPath];
            
        };
        //选中某一行的cell
        _shopcartTableViewProxy.shopCarProxyProductSelectBlock = ^(BOOL isSelelct, NSIndexPath *indexPath) {
            [weakSelf.ShopCarAction selectProductAtIndexPath:indexPath isSelected:isSelelct];
        };
        
        _shopcartTableViewProxy.shopCarProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath){
            [weakSelf.ShopCarAction changeCountAtIndexPath:indexPath count:count];
        };
        _shopcartTableViewProxy.shopCarProxyShowProductSizeBlock = ^(NSIndexPath *indexPath) {
//
//            MHShopCarSizeAlert *aler = [[MHShopCarSizeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) height:kRealValue(400) data:nil];
//            aler.alpha = 0;
//            [[UIApplication sharedApplication].keyWindow addSubview:aler];
//            [aler showAlert];
            
        };
        _shopcartTableViewProxy.shopCarProxyDeleteBlock  = ^(NSIndexPath *indexPath){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:  UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.ShopCarAction deleteProductAtIndexPath:indexPath];
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
      
        
       
    }
    return _shopcartTableViewProxy;
}
#pragma mark
-(void)setlayout
{
    [self.shopcartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.right.equalTo(self.view.mas_right).offset(-kRealValue(10));
        make.bottom.equalTo(self.shopcarBottomView.mas_top);
    }];
    
    if (self.IsComeFromdetail) {
        [self.shopcarBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kBottomHeight);
            make.height.equalTo(@50);
        }];
    }else{
        [self.shopcarBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-(50+kBottomHeight));
            make.height.equalTo(@50);
        }];
    }
    
}






#pragma mark delegate

-(void)shopCartFormatenteyDetailwithMHShopCarProductModel:(MHShopCarProductModel *)model
{
    MHProdetailViewController *vc = [[MHProdetailViewController alloc]init];
    vc.productId =model.productId;
   
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray
{
    self.shopcartTableViewProxy.dataArray = dataArray;
    if ( self.shopcartTableViewProxy.dataArray.count == 0) {
        self.editButton.hidden=YES;
        self.shopcarBottomView.hidden = YES;
    }else{
         self.editButton.hidden=NO;
        self.shopcarBottomView.hidden = NO;
    }
    [self.shopcartTableView cyl_reloadData];
}
-(void)goaround
{
    if (self.IsComeFromdetail == YES) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.tabBarController setSelectedIndex:0];
    }
    
}
//购物车视图需要更新时的统一回调
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected {
    [self.shopcarBottomView configureShopcartBottomViewWithTotalPrice:totalPrice totalCount:totalCount isAllselected:isAllSelected];
   [self.shopcartTableView cyl_reloadData];
    if ( self.shopcartTableViewProxy.dataArray.count == 0) {
        self.editButton.hidden=YES;
        self.shopcarBottomView.hidden=YES;
    }else{
         self.editButton.hidden=NO;
        self.editButton.hidden = NO;
    }
}

//点击结算按钮后的回调
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts {
    MHLog(@"%@",selectedProducts);
    
//    NSArray *arr = @[@{@"productId":[dic valueForKey:@"productId"],@"skuId":[dic valueForKey:@"skuId"],@"productNum":[dic valueForKey:@"amount"]}];
    NSMutableArray *Arr = [NSMutableArray array];
    NSMutableArray *cartIdArr = [NSMutableArray array];
    for (int i = 0; i < selectedProducts.count;i++) {
        MHShopCarBrandModel *model = [selectedProducts objectAtIndex:i];
        NSMutableArray *arr = model.selectedArray;
        for (int j = 0; j < arr.count; j++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            MHShopCarProductModel *productmodel = [arr objectAtIndex:j];
            [dic setObject:[NSString stringWithFormat:@"%@",productmodel.productId] forKey:@"productId"];
            [dic setObject:[NSString stringWithFormat:@"%@",productmodel.skuId] forKey:@"skuId"];
            [dic setObject:[NSString stringWithFormat:@"%@",productmodel.productCount] forKey:@"productNum"];
            NSNumber * Membership_Id =  [NSNumber numberWithInteger:[productmodel.cartId integerValue]];
            [cartIdArr addObject:Membership_Id];
            [dic setObject:[NSString stringWithFormat:@"%@",productmodel.activitySkuId] forKey:@"activitySkuId"];
            [Arr addObject:dic];
        }
    }
    
    
    MHSumbitOrderVC *vc = [[MHSumbitOrderVC alloc]init];
    vc.cartIdArr = cartIdArr;
    vc.arr = Arr;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//批量删除回调
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认要删除这%ld个宝贝吗？", selectedProducts.count] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.ShopCarAction deleteSelectedProducts:selectedProducts];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//全部删除回调
- (void)shopcartFormatHasDeleteAllProducts {
    if ( self.shopcartTableViewProxy.dataArray.count == 0) {
        self.editButton.hidden=YES;
        self.shopcarBottomView.hidden = YES;
    }else{
        self.editButton.hidden = NO;
         self.shopcarBottomView.hidden = NO;
    }
}



- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
