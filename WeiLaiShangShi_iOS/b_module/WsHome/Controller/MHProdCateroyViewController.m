//
//  MHProdCateroyViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProdCateroyViewController.h"
#import "MHCategorySearchView.h"
#import "MHSearchViewController.h"
#import "MHSearchResultViewController.h"
#import "MHMultilevelMenu.h"
#import "MHLoginViewController.h"
#import "MHHomeGoodsTypeListController.h"
#import "MHMenuModel.h"

@interface MHProdCateroyViewController ()<PYSearchViewControllerDelegate>{
    NSMutableArray * _list;
}
@property(strong,nonatomic)MHCategorySearchView *navSearchBar;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

@end

@implementation MHProdCateroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置title
    if (!self.isTabbar) {
        self.navigationItem.titleView = self.navSearchBar;
//        [_navSearchBar createSeachContent:[[GVUserDefaults standardUserDefaults].hotSearchArr count] > 0 ? [GVUserDefaults standardUserDefaults].hotSearchArr[0]:@""];
    }else{
        self.navigationItem.title = @"分类";
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_lefticon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(searchPush)];
        self.navigationItem.rightBarButtonItem = leftItem;
    }

    //初始化数据
   [self initData];

}


- (void)creatError{
    if (!self.emptyView) {
        self.emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:self.emptyView];
        
        self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
        self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 - 150);
        self.emptyOverlayImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
        [self.emptyView addSubview:self.emptyOverlayImageView];
        
        CGRect emptyOverlayViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.emptyView.frame), 20);
        UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel.numberOfLines = 0;
        emptyOverlayLabel.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel.text = @"网络异常";
        emptyOverlayLabel.font = [UIFont boldSystemFontOfSize:14];
        emptyOverlayLabel.frame = ({
            CGRect frame = emptyOverlayLabel.frame;
            frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
            frame;
        });
        emptyOverlayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        emptyOverlayLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.emptyView addSubview:emptyOverlayLabel];
        
        
        UILabel *emptyOverlayLabel1 = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel1.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel1.numberOfLines = 0;
        emptyOverlayLabel1.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel1.text = @"点击屏幕，重新加载";
        emptyOverlayLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        emptyOverlayLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        emptyOverlayLabel1.font = [UIFont boldSystemFontOfSize:12];
        emptyOverlayLabel1.frame = ({
            CGRect frame = emptyOverlayLabel1.frame;
            frame.origin.y = CGRectGetMaxY(emptyOverlayLabel.frame) + 20;
            frame;
        });
        [self.view addSubview:emptyOverlayLabel1];
        
        //        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
        [longPressUIemptyOverlay setMinimumPressDuration:0.001];
        [self.emptyView addGestureRecognizer:longPressUIemptyOverlay];
        self.emptyView.userInteractionEnabled = YES;
    }
    
}

- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        [self initData];
    }
}


-(void)searchPush{
    [self createSearchVC];
}

- (void)initData{
    
    [[MHUserService sharedInstance]initWitAllTypesCompletionBlock:^(NSDictionary *response, NSError *error) {
        
        if (ValidResponseDict(response)) {
            [self.emptyView  removeAllSubviews];
            self.emptyView  = nil;
            _list=[NSMutableArray array];
            NSArray *array = response[@"data"];
            
            for (int i=0; i<[array count]; i++) {
                
                MHMenuModel * meun=[[MHMenuModel alloc] init];
                meun.typeName=[array objectAtIndex:i][@"categoryName"];
                meun.typeId= [[array objectAtIndex:i][@"id"] intValue];
                meun.nextArray=[array objectAtIndex:i][@"list"];
                NSMutableArray * sub = [NSMutableArray array];
                
                for ( int j=0; j <[meun.nextArray count]; j++) {
                    
                    MHMenuModel * meun1=[[MHMenuModel alloc] init];
                    meun1.typeName=[meun.nextArray objectAtIndex:j][@"categoryName"];
                    meun1.nextArray=[meun.nextArray objectAtIndex:j][@"list"];
                    meun1.typeId = [[meun.nextArray objectAtIndex:j][@"id"] intValue];
                     meun1.typeImage=[meun.nextArray objectAtIndex:j][@"icon"];
                    
                    NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
                    for ( int k=0; k <[meun1.nextArray count]; k++) {
                        MHMenuModel * meun2=[[MHMenuModel alloc] init];
                        meun2.typeName=[meun1.nextArray objectAtIndex:k][@"categoryName"];
                        meun2.typeImage=[meun1.nextArray objectAtIndex:k][@"icon"];
                        meun2.typeId = [[meun1.nextArray objectAtIndex:k][@"id"] intValue];
                        [zList addObject:meun2];
                    }
                    
                    
                    meun1.nextArray=zList;
                    [sub addObject:meun1];
                }
                
                
                meun.nextArray=sub;
                [_list addObject:meun];
            }
            
            //初始化分类菜单
            [self initCategoryMenu];
            
        }
        if (error) {
            [self creatError];
        }
        
    }];

}

- (void)initCategoryMenu{
  NSInteger VCCount = self.navigationController.viewControllers.count;
    CGFloat  height = 0;
    if (VCCount>1) {
        height = self.view.height;
    }else{
        height = self.view.height - kTabBarHeight;
    }
  MHMultilevelMenu * view=[[MHMultilevelMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.width, height) WithData:_list withSelectIndex:^(NSInteger left, MHMenuModel *sectionInfo,MHMenuModel *info) {
      MHLog(@"%@",info);
      MHLog(@"%@",sectionInfo);
      MHHomeGoodsTypeListController *vc = [[MHHomeGoodsTypeListController alloc] initWithTypeId:[NSString stringWithFormat:@"%ld",info.typeId] parentID:[NSString stringWithFormat:@"%ld",sectionInfo.typeId]];
      vc.navtitle  = info.typeName;
      [self.navigationController pushViewController:vc animated:YES];
  }];

   view.needToScorllerIndex=0; //默认是 选中第一行
    view.leftSelectColor = [UIColor colorWithHexString:@"FF5100"];//选中文字颜色
    view.leftSelectBgColor = [UIColor whiteColor];//选中背景颜色
    view.isRecordLastScroll = NO;//是否记住当前位置
  [self.view addSubview:view];
}


-(MHCategorySearchView *)navSearchBar{
    if (!_navSearchBar) {
        _navSearchBar = [[MHCategorySearchView alloc] initWithFrame:CGRectMake(0,0, kRealValue(300), 30)];
        kWeakSelf(self);
        _navSearchBar.searchBarBlock=^(){
            kStrongSelf(weakself);
            [strongself createSearchVC];
        };
    }
    return _navSearchBar;
}


- (void)createSearchVC{
//    NSArray *hotSeaches = [GVUserDefaults standardUserDefaults].hotSearchArr;
//    MHSearchViewController *searchViewController = [MHSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:[hotSeaches count] > 0 ? hotSeaches[0]:@"" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        MHSearchResultViewController *vc = [[MHSearchResultViewController alloc] init];
//         vc.descStr = searchText;
//        [searchViewController.navigationController pushViewController:vc animated:NO];
//    }];
//    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
//    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
//    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModeModal;
////    searchViewController.delegate = self;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self  presentViewController:nav animated:NO completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
