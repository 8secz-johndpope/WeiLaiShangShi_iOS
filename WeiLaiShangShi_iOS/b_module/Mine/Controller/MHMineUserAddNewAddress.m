
//
//  MHMineUserAddNewAddress.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserAddNewAddress.h"
#import "MHMineUserInfoCommonViewThrid.h"
#import "MHMineuserAddress.h"
#import "JKCityPickViewController.h"
#import <BRPickerView.h>

@interface MHMineUserAddNewAddress ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic, strong)UIScrollView *activityScroll;
@property (nonatomic, strong) UIButton *addNewaddress;
@property (nonatomic, strong) MHMineUserInfoCommonViewThrid *username;
@property (nonatomic, strong) MHMineUserInfoCommonViewThrid *phonenum;
@property (nonatomic, strong)  MHMineUserInfoCommonViewThrid *address;
@property (nonatomic, strong) UILabel *citylabel;
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *area;
@end

@implementation MHMineUserAddNewAddress
- (instancetype)initWithModel:(MHMineuserAddress *)adressModel
{
    self = [super init];
    if (self) {
        self.adressModel = adressModel;
      
        
    }
    return self;
}
//-(void)setAdressModel:(MHMineuserAddress *)adressModel
//{
//    self.username.textfield.text = [NSString stringWithFormat:@"%@",adressModel.userName];
//    self.phonenum.textfield.text =[NSString stringWithFormat:@"%@",adressModel.userPhone];
//    self.citylabel.text = [NSString stringWithFormat:@"%@ %@ %@ ",adressModel.province,adressModel.city, adressModel.area];
//    self.textview.text = [NSString stringWithFormat:@"%@",adressModel.details];
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"添加地址";
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kRealValue(10), kRealValue(30), kRealValue(30));
        btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:KColorFromRGB(0xFA3E3E) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(Addnewress) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [self.navigationItem setRightBarButtonItem:rightItem];
    
    
    self.view.backgroundColor = KColorFromRGB(0x000000);
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    self.activityScroll.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.contentSize = CGSizeMake(0,kScreenHeight);
    
    self.username = [[MHMineUserInfoCommonViewThrid alloc]initWithFrame:CGRectMake(0, kRealValue(0), kScreenWidth, kRealValue(44)) lefttitle:@"" textfield:@"请输入姓名" istopLine:YES isBottonLine:YES];
    self.username.textfield.returnKeyType = UIReturnKeyDone;
    self.username.textfield.delegate =self;
    [self.activityScroll addSubview:self.username];
    
    self.phonenum = [[MHMineUserInfoCommonViewThrid alloc]initWithFrame:CGRectMake(0, kRealValue(44), kScreenWidth, kRealValue(44)) lefttitle:@"" textfield:@"手机号码" istopLine:NO isBottonLine:YES];
    self.phonenum.textfield.returnKeyType = UIReturnKeyDone;
    self.phonenum.textfield.delegate =self;
    self.phonenum.textfield.keyboardType = UIKeyboardTypeNumberPad;
    [self.activityScroll addSubview:self.phonenum];
    
    self.address = [[MHMineUserInfoCommonViewThrid alloc]initWithFrame:CGRectMake(0, kRealValue(88), kScreenWidth, kRealValue(44)) lefttitle:@"" textfield:@"" istopLine:NO isBottonLine:YES];
    self.address.textfield.hidden = YES;
    self.citylabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(14), kRealValue(230), kRealValue(17))];
    self.citylabel.text=@"省份、城市、地区";
    self.citylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.citylabel.userInteractionEnabled =YES;
    self.citylabel.textColor=KColorFromRGB(0xB9BABF);
    [self.address addSubview:self.citylabel];
    
    UITapGestureRecognizer *citytap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityAct)];
    [self.address addGestureRecognizer:citytap];
    [self.activityScroll addSubview:self.address];
    
    
//    UIImageView *imagejiantou = [[UIImageView alloc]init];
//    imagejiantou.image = kGetImage(@"ic_public_open");
//    imagejiantou.frame = CGRectMake(kScreenWidth - kRealValue(40), kRealValue(14), kRealValue(22), kRealValue(22));
//    [self.address addSubview:imagejiantou];
    
    UIView *textfrontview= [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(132), kScreenWidth, kRealValue(44))];
    textfrontview.backgroundColor = KColorFromRGB(0xffffff);
    [self.activityScroll addSubview:textfrontview];
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(132), kScreenWidth, kRealValue(44))];
    self.textview.placeholder = @"详细地址，如街道，楼牌号等";
    self.textview.returnKeyType = UIReturnKeyDone;
    self.textview.delegate =self;
    self.textview.font= [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    [self.activityScroll addSubview:self.textview];
    
    [self.activityScroll addSubview:self.selelctBtn];
    [self.selelctBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.activityScroll.mas_centerX).offset(0);
        make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(205));
    }];
    
//    self.addNewaddress = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addNewaddress setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF4D5D"],[UIColor colorWithHexString:@"FF3344"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
//    self.addNewaddress.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
//    [self.addNewaddress setTitle:@"保存地址" forState:UIControlStateNormal];
//    self.addNewaddress.layer.masksToBounds =YES;
//
//    [self.addNewaddress addTarget:self action:@selector(Addnewress) forControlEvents:UIControlEventTouchUpInside];
//    self.addNewaddress.frame =CGRectMake(kRealValue(16), kRealValue(320), kRealValue(343), kRealValue(40));
//    self.addNewaddress.layer.cornerRadius = kRealValue(20);
//    [self.activityScroll addSubview:self.addNewaddress];
    
    [self.view addSubview:self.activityScroll];
    
    if (!klObjectisEmpty(self.adressModel) ) {
        self.username.textfield.text = [NSString stringWithFormat:@"%@",self.adressModel.contact];
        self.phonenum.textfield.text =[NSString stringWithFormat:@"%@",self.adressModel.phone];
        self.citylabel.text = [NSString stringWithFormat:@"%@ %@ %@ ",self.adressModel.province,self.adressModel.city, self.adressModel.area];
        self.textview.text = [NSString stringWithFormat:@"%@",self.adressModel.detail];
        self.textview.placeholder= @"";
        self.citylabel.textColor = KColorFromRGB(0x000000);
        self.title= @"编辑地址";
    }
    
    UITapGestureRecognizer *Viewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewtapAct)];
    [self.view addGestureRecognizer:Viewtap];

    
   
    // Do any additional setup after loading the view.
}
-(void)SelectButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
- (UIButton *)selelctBtn {
    if (_selelctBtn == nil){
        _selelctBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selelctBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [_selelctBtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_selelctBtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateSelected];
        _selelctBtn.titleLabel.font = [UIFont systemFontOfSize:kFontValue(12)];
        [_selelctBtn setImage:[UIImage imageNamed:@"ic_public_choice_unselect"] forState:UIControlStateNormal];
        [_selelctBtn setImage:[UIImage imageNamed:@"ic_public_choice_select_main"] forState:UIControlStateSelected];
        //        [_selelctBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        _selelctBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_selelctBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [_selelctBtn addTarget:self action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selelctBtn;
}
-(void)ViewtapAct
{
    [self.view endEditing:YES];
}

-(void)Addnewress
{
    if (self.username.textfield.text.length <= 0 ) {
        KLToast(@"请输入收货人姓名");
        return;
    }
    if (self.phonenum.textfield.text.length <= 0 ) {
        KLToast(@"请输入收货人手机号");
        return;
    }
    if (self.phonenum.textfield.text.length < 11 ) {
        KLToast(@"请输入正确的手机号");
        return;
    }
    if (self.city.length <= 0 || self.province.length <= 0 || self.area.length <= 0) {
        if (klObjectisEmpty(self.adressModel)) {
            KLToast(@"请选择收货地址");
            return;
        }else{
            self.city = self.adressModel.city;
            self.province =self.adressModel.province;
            self.area = self.adressModel.area;
        }
    }
    if (self.textview.text.length <= 0) {
        KLToast(@"请输入详细收货地址");
        return;
    }
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance] initWithChangeAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",self.adressModel.id] userName:self.username.textfield.text userPhone:self.phonenum.textfield.text province:self.province city:self.city area:self.area details:self.textview.text addressState:[NSString stringWithFormat:@"%d",self.selelctBtn.selected]  CompletionBlock:^(NSDictionary *response, NSError *error) {
           [MBProgressHUD hideHUD];
        if (ValidResponseDict(response)) {
           
           KLToast(@"保存成功");
           [self.navigationController popViewControllerAnimated:YES];
       }
        
        if (error) {

                KLToast(@"保存失败，请重试");
            
        }
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phonenum.textfield) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.phonenum.textfield.text.length >= 11) {
            self.phonenum.textfield.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    return YES;
}
-(void)cityAct
{
    [self.view endEditing:YES];
    // 【转换】：以@" "自字符串为基准将字符串分离成数组，如：@"浙江省 杭州市 西湖区" ——》@[@"浙江省", @"杭州市", @"西湖区"]
    NSArray *defaultSelArr = [self.citylabel.text componentsSeparatedByString:@" "];
    // NSArray *dataSource = [weakSelf getAddressDataSource];  //从外部传入地区数据源
    if ([GVUserDefaults standardUserDefaults].areaList) {
        NSArray *dataSource =  [GVUserDefaults standardUserDefaults].areaList;
        [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            self.citylabel.text  = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
            self.citylabel.textColor=KColorFromRGB(0x000000);
            self.province = province.name;
            self.city =  city.name;
            self.area = area.name;
            NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
            NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
            NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
            NSLog(@"--------------------");
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    }else{
        [[MHUserService sharedInstance]initwithCityListCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [GVUserDefaults standardUserDefaults].areaList = response[@"data"];
                NSArray *dataSource =  [GVUserDefaults standardUserDefaults].areaList;
                [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                    self.citylabel.text  = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                    self.citylabel.textColor=KColorFromRGB(0x000000);
                    self.province = province.name;
                    self.city =  city.name;
                    self.area = area.name;
                    NSLog(@"省[%@]：%@，%@", @(province.index), province.code, province.name);
                    NSLog(@"市[%@]：%@，%@", @(city.index), city.code, city.name);
                    NSLog(@"区[%@]：%@，%@", @(area.index), area.code, area.name);
                    NSLog(@"--------------------");
                } cancelBlock:^{
                    NSLog(@"点击了背景视图或取消按钮");
                }];
            }
        }];
    }
    
    
    
    
//    NSArray *dataSource = nil; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
    
    
//    [JKCityPickViewController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
//
//        // 选择结果回调
//        self.citylabel.text = address;
//        MHLog(@"%@--%@--%@--%@",address,province,city,area);
//        self.province =province;
//        self.city = city;
//        self.area = area;
//
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  {  if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
         return NO;
    }  return YES;
    
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
