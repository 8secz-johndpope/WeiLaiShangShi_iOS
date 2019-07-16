//
//  MHMineUserInfoAddressViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoAddressViewController.h"
#import "MHMineUserAddressCell.h"
#import "MHMineUserAddNewAddress.h"
#import "MHMineuserAddress.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSAddressCell.h"
@interface MHMineUserInfoAddressViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *addressListArr;
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIButton *addNewaddress;
@property (nonatomic, strong)  MHMineUserAddressCell *cell;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置
@end

@implementation MHMineUserInfoAddressViewController

-(instancetype)initWithcomeform:(NSString *)awordprize
{
    self = [super init];
    if (self) {
        self.awordprize = awordprize;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNetdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.title = @"地址管理";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    UIImageView *lineView = [[UIImageView alloc]initWithImage:kGetImage(@"shop_line")];
    lineView.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(7)) ;
    [self.view addSubview:lineView];
    [self.view addSubview:self.contentTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kRealValue(10), kRealValue(70), kRealValue(30));
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [btn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0x222222) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Address) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
//    self.addNewaddress = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addNewaddress setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF4D5D"],[UIColor colorWithHexString:@"FF3344"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
//    self.addNewaddress.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
//    [self.addNewaddress setTitle:@" 十 添加新地址" forState:UIControlStateNormal];
//    self.addNewaddress.layer.masksToBounds =YES;
//    [self.addNewaddress addTarget:self action:@selector(Address) forControlEvents:UIControlEventTouchUpInside];
//    self.addNewaddress.frame =CGRectMake(kRealValue(16), kScreenHeight- kBottomHeight-kTopHeight-kRealValue(70), kRealValue(343), kRealValue(40));
//     self.addNewaddress.layer.cornerRadius = kRealValue(20);
//    [self.view addSubview:self.addNewaddress];
    
}
-(void)getNetdata
{
    self.addressListArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithGetUserAdressInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.addressListArr=[MHMineuserAddress baseModelWithArr:response[@"data"]];
        }
        [self.contentTableView cyl_reloadData];
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
   
    [self getNetdata];
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {

    UIView *bgView = [[UIView alloc] initWithFrame:_contentTableView.frame];
    bgView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
 
    
    
    UIImageView *signBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRealValue(140), kRealValue(71), kRealValue(84))];
    signBtn.image = kGetImage(@"shop_address_icon");
    [bgView addSubview:signBtn];
    signBtn.centerX = bgView.centerX;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(240), kScreenWidth, kRealValue(30))];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.numberOfLines = 0;
    label.text = @"请添加您的收货地址";
    [bgView addSubview:label];
    
    
    return bgView;
}

-(void)Address
{
    MHMineUserAddNewAddress *vc = [[MHMineUserAddNewAddress alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, kRealValue(7),kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xF1F3F4);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHMineUserAddressCell class] forCellReuseIdentifier:NSStringFromClass([MHMineUserAddressCell class])];
       
        [_contentTableView registerClass:[HSAddressCell class] forCellReuseIdentifier:NSStringFromClass([HSAddressCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return kRealValue(88);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     kWeakSelf(self);
    HSAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSAddressCell class])];
    self.cell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (self.addressListArr.count > 0) {
//        self.cell.adressModel = [self.addressListArr objectAtIndex:indexPath.row];
        [cell createCellWithModel:[self.addressListArr objectAtIndex:indexPath.row]];
    }
    cell.Tap1 = ^{
        if (!klStringisEmpty(self.awordprize)) {
            MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        if ([self.type isEqualToString:@"sumbit"]) {
            MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    cell.Tap2 = ^{
        MHMineuserAddress *adressModel =  [weakself.addressListArr objectAtIndex:indexPath.row];
        MHMineUserAddNewAddress *vc = [[MHMineUserAddNewAddress alloc]initWithModel:adressModel];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
    
       self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineUserAddressCell class])];
//        cell.backgroundColor = kRandomColor;
        self.cell.selectionStyle= UITableViewCellSelectionStyleNone;
   
    self.cell.deleteAct = ^(NSInteger index) {
        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"删除地址" message:@"确认删除地址吗" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
            
        } rightAct:^{
            MHMineuserAddress  *adressModel = [weakself.addressListArr objectAtIndex:indexPath.row];
            [[MHUserService sharedInstance]initWithdeleteAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",adressModel.id]  CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"删除成功");
                    [weakself getNetdata];
                }
            }];
        }];
       
        
    
    };
    self.cell.editAct = ^(NSInteger index) {
       MHMineuserAddress *adressModel =  [weakself.addressListArr objectAtIndex:indexPath.row];
        MHMineUserAddNewAddress *vc = [[MHMineUserAddNewAddress alloc]initWithModel:adressModel];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    self.cell.setdefaultAct = ^(NSInteger index) {
        MHMineuserAddress  *adressModel = [weakself.addressListArr objectAtIndex:indexPath.row];
        if ([[NSString stringWithFormat:@"%@",adressModel.state] isEqualToString:@"0"]) {
            [[MHUserService sharedInstance]initWithSetDefaultAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",adressModel.id] CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"设置成功");
                    [weakself getNetdata];
                }
            }];
        }else{
           
        }
        
       

    };
    if (self.addressListArr.count > 0) {
        self.cell.adressModel = [self.addressListArr objectAtIndex:indexPath.row];
    }
        return self.cell;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.addressListArr.count>0 ) {
        return self.addressListArr.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (!klStringisEmpty(self.awordprize)) {
//        MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
//    if ([self.type isEqualToString:@"sumbit"]) {
//        MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //第二组可以左滑删除
   
    return YES;
}

#pragma mark - viewDidLayoutSubviews
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}
#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // 获取选项按钮的reference
    if (@available(iOS 11.0, *)){
        
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.contentTableView.subviews)
        {
            NSLog(@"%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 1)
            {
                // 和iOS 10的按钮顺序相反
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
    else{
        // iOS 8-10层级 (Xcode 8编译): UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        HSAddressCell *tableCell = [self.contentTableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
            NSLog(@"subview%@-----%zd",subview,subview.subviews.count);
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 1)
            {
                UIButton *deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton{
    if (deleteButton) {
        [deleteButton setImage:[UIImage imageNamed:@"hsdelete"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor colorWithHexString:@"FA3E3E"]];
        
    }
}


#pragma mark - setupTableView

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.editingIndexPath = nil;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //title不设为nil 而是空字符串 理由为啥 ？   自己实践 跑到ios11以下的机器上就知道为啥了
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"        " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSLog(@"哈哈哈哈");
        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"删除地址" message:@"确认删除地址吗" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
            
        } rightAct:^{
            MHMineuserAddress  *adressModel = [self.addressListArr objectAtIndex:indexPath.row];
            [[MHUserService sharedInstance]initWithdeleteAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",adressModel.id]  CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"删除成功");
                    [self getNetdata];
                }
            }];
        }];
        [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
    }];
    return @[deleteAction];
}


-(void)backBtnClicked{
    
    if ([self.addressListArr count] == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:nil];
         [self.navigationController popViewControllerAnimated:YES];
    }else{
        MHMineuserAddress *model = [self.addressListArr objectAtIndex:0];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

@end
