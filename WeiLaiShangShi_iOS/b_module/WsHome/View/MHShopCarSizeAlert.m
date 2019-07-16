
//
//  MHShopCarSizeAlert.m
//  mohu
//
//  Created by 余浩 on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarSizeAlert.h"
#import "MHstandardListModel.h"
#import "AttributeView.h"
#import "UIView+Extnesion.h"
#import "MHShopCarCountView.h"
#import "MHskuListModel.h"
@interface MHShopCarSizeAlert()<AttributeViewDelegate>
@property(nonatomic, strong)NSString *productstock;

@end
@implementation MHShopCarSizeAlert

-(instancetype)initWithFrame:(CGRect)frame height:(NSInteger)height data:(NSMutableDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.dict = dic;
        
        self.sectionArr = [NSMutableArray array];
        self.skulistArr = [NSMutableArray array];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.dict valueForKey:@"standardList"]];
          NSMutableArray *arr1 = [NSMutableArray arrayWithArray:[self.dict valueForKey:@"skuList"]];
        for (int i = 0; i< arr.count; i++) {
            MHstandardListModel *model = [[MHstandardListModel alloc]init];
            model.attributeName = [[arr objectAtIndex:i] valueForKey:@"attributeName"];
            model.attributeId = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] valueForKey:@"attributeId"]] ;
             model.arrtriuteArr = [[arr objectAtIndex:i] valueForKey:@"attributeValueList"];
            [self.sectionArr addObject:model];
        }
        self.skulistArr = [MHskuListModel baseModelWithArr:arr1];
        [self createviewWithheight:height data:dic];
        //设置默认的价格库存tupian
        if (self.skulistArr.count > 0) {
            MHskuListModel *firstmodel = [self.skulistArr objectAtIndex:0];
            NSString *str = [NSString stringWithFormat:@"%@",firstmodel.retailPrice];
            self.pricelabel.text = [NSString stringWithFormat:@"¥%.2f",[str floatValue]] ;
            self.stocknumlabel.text = [NSString stringWithFormat:@"库存剩余:  %@",firstmodel.amount];
            self.productstock =[NSString stringWithFormat:@"%@",firstmodel.amount];
             [self.productImg sd_setImageWithURL:[NSURL URLWithString:firstmodel.image] placeholderImage:kGetImage(@"img_bitmap_grey")];
        }
        
        
        self.alpha = 0;
    }
    return self;
}
-(void)createviewWithheight:(NSInteger)height data:(NSMutableDictionary *)dic
{
    _Height= height;
   
    self.backgroundColor = [UIColor clearColor];
    //半透明的背景
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.bgView.backgroundColor = KColorFromRGBA(0x00000, 0.4);
    self.bgView.userInteractionEnabled = YES;
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.bgView addGestureRecognizer:tap];
    //白色区域
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight  , kScreenWidth, height)];
    self.showView.backgroundColor = [UIColor whiteColor];
    self.showView.userInteractionEnabled = YES;
//    self.showView.layer.cornerRadius =20;
    [self addSubview:self.showView];
    //商品信息
    MHskuListModel *skuListModel;
    if (self.skulistArr.count > 0) {
        skuListModel = [self.skulistArr objectAtIndex:0];
    }
    
    self.productImg = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(15), -kRealValue(16), kRealValue(70), kRealValue(70))];
    self.productImg.backgroundColor = kRandomColor;
    self.productImg.layer.masksToBounds = YES;
    self.productImg.layer.shadowColor = [UIColor colorWithRed:117/255.0 green:106/255.0 blue:75/255.0 alpha:0.4].CGColor;
    self.productImg.layer.shadowOffset = CGSizeMake(0,3);
    self.productImg.layer.shadowOpacity = 1;
    self.productImg.layer.shadowRadius = 10;
    self.productImg.layer.cornerRadius =5;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:skuListModel.image] placeholderImage:kGetImage(@"img_bitmap_grey")];
    [self.showView addSubview:self.productImg];
    
    self.pricelabel=[[UILabel alloc]initWithFrame:CGRectMake( self.productImg.frame.size.width +self.productImg.frame.origin.x + kRealValue(10), kRealValue(10), kRealValue(200), kRealValue(22))];
    self.pricelabel.textColor = KColorFromRGB(0xf74916);
    self.pricelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    [self.showView addSubview:self.pricelabel];
    
    self.stocknumlabel=[[UILabel alloc]initWithFrame:CGRectMake( self.productImg.frame.size.width +self.productImg.frame.origin.x + kRealValue(5), kRealValue(45), kRealValue(200), kRealValue(22))];
    self.stocknumlabel.textColor = KColorFromRGB(0x666666);
    self.stocknumlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self.showView addSubview:self.stocknumlabel];
    
    self.showNoticelabel=[[UILabel alloc]initWithFrame:CGRectMake( self.productImg.frame.size.width +self.productImg.frame.origin.x + kRealValue(10), kRealValue(35), kRealValue(200), kRealValue(22))];
    self.showNoticelabel.textColor = KColorFromRGB(0x282828);
    self.showNoticelabel.text = @"";
    self.showNoticelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    [self.showView addSubview:self.showNoticelabel];
   
    //关闭按钮 ic_cloos_dark
    self.closeImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.showView.frame.size.width - kRealValue(40), kRealValue(20), kRealValue(30), kRealValue(30))];
//    self.closeImg.backgroundColor = kRandomColor;
    self.closeImg.image = kGetImage(@"ic_cloos_dark");
    self.closeImg.userInteractionEnabled =YES;
    [self.showView addSubview:self.closeImg];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.closeImg addGestureRecognizer:tap1];
    //
    // 创建最底层的scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kRealValue(70), self.width, kRealValue(280))];
    scrollView.backgroundColor = [UIColor whiteColor];
    NSInteger AttributeViewheight = 0;
    self.skuStr =[self.dict valueForKey:@"productId"];
    NSArray *attrstr = [skuListModel.attribute componentsSeparatedByString:@"/"];
    for (int i = 0; i < self.sectionArr.count; i++) {
        if (self.sectionArr.count == attrstr.count) {
            MHstandardListModel *model = [self.sectionArr objectAtIndex:i];
            NSArray *dsData = model.arrtriuteArr;
            
            AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:model.attributeName titleFont:[UIFont boldSystemFontOfSize:14] attributeTexts:dsData viewWidth:self.width IsSort:NO IsSelectDefault:attrstr[i] tag:i];
            attributeViewDS.y = AttributeViewheight;
            AttributeViewheight = CGRectGetMaxY(attributeViewDS.frame) + 15;
            attributeViewDS.Attribute_delegate = self;
            attributeViewDS.tag = 21000+i;
            [scrollView addSubview:attributeViewDS];
            self.skulaber= [[UILabel alloc]initWithFrame:CGRectMake(100 *i, 0, 70, 30)];
            self.skulaber.text =[NSString stringWithFormat:@"%@|%@",model.attributeId,attrstr[i]] ;
            self.skulaber.tag = 14000+i;
            self.skulaber.hidden = YES;
            [scrollView addSubview:self.skulaber];
            self.DesStrlabel= [[UILabel alloc]initWithFrame:CGRectMake(100 *i, 30, 100, 30)];
            self.DesStrlabel.text =[NSString stringWithFormat:@"/%@",attrstr[i]] ;
            self.DesStrlabel.tag = 14100+i;
            self.DesStrlabel.hidden = YES;
            [scrollView addSubview:self.DesStrlabel];
            self.DesStr = [[NSString alloc]init];
            self.skuId =[NSString stringWithFormat:@"%@",attrstr[i]];
            
            UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(15), attributeViewDS.frame.size.height -1 ,kScreenWidth - 2* kRealValue(15) ,1/kScreenScale )];
            lineview.backgroundColor = KColorFromRGB(0xe2e2e2);
            [attributeViewDS addSubview:lineview];
            
            
        }else{
            MHstandardListModel *model = [self.sectionArr objectAtIndex:i];
            NSArray *dsData = model.arrtriuteArr;
            NSString *str =@"";
            NSString *str2 = @"";
            int j = 0;
            for (int i = 0; i < dsData.count; i++) {
                NSString *desstr = [NSString stringWithFormat:@"%@|%@",model.attributeId,dsData[i]];
                if ([skuListModel.key rangeOfString:desstr].location !=NSNotFound) {
                   
                    //第一次匹配上
                    if (j== 0 ) {
                        str = dsData[i];
                        str2 = dsData[i];
                        j= 1;
                    }else{
                     //第二次匹配
                        str2 = dsData[i];
                        if (str.length < str2.length) {
                            str = str2;
                        }
                        
                    }
                 
                    
            }
            }
            AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:model.attributeName titleFont:[UIFont boldSystemFontOfSize:14] attributeTexts:dsData viewWidth:self.width IsSort:NO IsSelectDefault:str tag:i];
            attributeViewDS.y = AttributeViewheight;
            AttributeViewheight = CGRectGetMaxY(attributeViewDS.frame) + 15;
            attributeViewDS.Attribute_delegate = self;
            attributeViewDS.tag = 21000+i;
            [scrollView addSubview:attributeViewDS];
            self.skulaber= [[UILabel alloc]initWithFrame:CGRectMake(100 *i, 0, 70, 30)];
            self.skulaber.text =[NSString stringWithFormat:@"%@|%@",model.attributeId,str] ;
            self.skulaber.tag = 14000+i;
            self.skulaber.hidden = YES;
            [scrollView addSubview:self.skulaber];
            self.DesStrlabel= [[UILabel alloc]initWithFrame:CGRectMake(100 *i, 30, 100, 30)];
            self.DesStrlabel.text =[NSString stringWithFormat:@"/%@",str] ;
            self.DesStrlabel.tag = 14100+i;
            self.DesStrlabel.hidden = YES;
            [scrollView addSubview:self.DesStrlabel];
            self.DesStr = [[NSString alloc]init];
            self.skuId =[NSString stringWithFormat:@"%@",attrstr[i]];
            
            UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(15), attributeViewDS.frame.size.height -1 ,kScreenWidth - 2* kRealValue(15) ,1/kScreenScale )];
            lineview.backgroundColor = KColorFromRGB(0xe2e2e2);
            [attributeViewDS addSubview:lineview];
            
            
        }
       
        
    }
    for (int i = 0; i < self.skulistArr.count; i++) {
        MHskuListModel *model = [self.skulistArr objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%@",self.skuStr]  isEqualToString:[NSString stringWithFormat:@"%@",model.key]]) {
            
            [self changeViewwithModel:model];
        }
    }
    UILabel *chosseNumlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(10), AttributeViewheight + kRealValue(10), kRealValue(100), kRealValue(15))];
    chosseNumlabel.text = @"购买数量:";
    chosseNumlabel.textAlignment = NSTextAlignmentLeft;
    chosseNumlabel.textColor = KColorFromRGB(0x2b2b2b);
    chosseNumlabel.font = [UIFont fontWithName:kPingFangMedium size:14];
    [scrollView addSubview:chosseNumlabel];
    
    self.decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.decreaseButton setImage:[UIImage imageNamed:@"ic_number_reduce"] forState:UIControlStateNormal];
    [self.decreaseButton setImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
    [self.decreaseButton addTarget:self action:@selector(decreaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.decreaseButton.frame = CGRectMake(kScreenWidth-kRealValue(115), chosseNumlabel.frame.origin.y , kRealValue(25), kRealValue(25));
    [scrollView addSubview:self.decreaseButton];

    self.editTextField = [[UILabel alloc] init];
    self.editTextField.textColor = [UIColor colorWithHexString:@"6E6E6E"];
    self.editTextField.textAlignment = NSTextAlignmentCenter;

    self.editTextField.text =@"1";
     self.editTextField.layer.borderColor = [[UIColor colorWithHexString:@"ffffff"] CGColor];
   self.editTextField.layer.borderWidth = 1/kScreenScale;
    self.editTextField.font=[UIFont systemFontOfSize:kFontValue(12)];
    self.editTextField.backgroundColor = [UIColor whiteColor];
    self.editTextField.frame = CGRectMake(self.decreaseButton.frame.size.width+self.decreaseButton.frame.origin.x+kRealValue(10), chosseNumlabel.frame.origin.y, kRealValue(30), kRealValue(25));
    [scrollView addSubview:self.editTextField];


    self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.increaseButton setImage:[UIImage imageNamed:@"ic_number_plus"] forState:UIControlStateNormal];
    [self.increaseButton setImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
    [self.increaseButton addTarget:self action:@selector(increaseButtonAction) forControlEvents:UIControlEventTouchUpInside];
     self.increaseButton.frame = CGRectMake(self.editTextField.frame.size.width+self.editTextField.frame.origin.x+kRealValue(10) ,chosseNumlabel.frame.origin.y, kRealValue(25), kRealValue(25));
       [scrollView  addSubview:self.increaseButton];
    
 
   

    
     scrollView.contentSize = (CGSize){0,AttributeViewheight + kRealValue(100)};
    [self.showView addSubview:scrollView];
 
    self.Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F74C16"],[UIColor colorWithHexString:@"FF8319"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    self.Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    self.Buybtn.userInteractionEnabled = YES;
    self.Buybtn.frame = CGRectMake(0, self.showView.frame.size.height-kRealValue(49), kScreenWidth, kRealValue(49));
    [self.Buybtn addTarget:self action:@selector(buyBtnAct) forControlEvents:UIControlEventTouchUpInside];
    [self.Buybtn setTitle:@"确定" forState:UIControlStateNormal];
     [self.showView addSubview:self.Buybtn];
    

    
}
-(void)buyBtnAct
{
    self.skuStr =[self.dict valueForKey:@"productId"];
    self.DesStr = @"";
    
    for (int i = 0; i < self.sectionArr.count; i++) {
      UILabel *label1 = [self  viewWithTag:14100+i];
        UILabel *label = [self  viewWithTag:14000+i];
        self.skuStr = [NSString stringWithFormat:@"%@|%@",self.skuStr,label.text];
         self.DesStr =  [NSString stringWithFormat:@"%@%@",self.DesStr,label1.text];
    }
    for (int i = 0; i < self.skulistArr.count; i++) {
        MHskuListModel *model = [self.skulistArr objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%@",self.skuStr]  isEqualToString:model.key]) {

            [self changeViewwithModel2:model];
        }
    }
    if (self.changeName) {
        self.changeName(self.DesStr );
    }
    for (int i = 0; i < self.sectionArr.count; i++) {
       
        UILabel *label1 = [self  viewWithTag:14100+i];
        if (klStringisEmpty(label1.text) ) {
            KLToast(@"请先选择规格")
            return;
        }
       
    }
    //购物车
    if (self.fromtype == 1) {
        MHLog(@"hahahha%@", self.editTextField.text );
        [[MHUserService sharedInstance] initWithAddShopCartProductId:[self.dict valueForKey:@"productId"] skuId:self.skuId amount:self.editTextField.text completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                KLToast(@"加入购物车成功");
            }else{
                KLToast([response valueForKey:@"message"]);
            }
            
            
            
        }];
    }
    //立即购买
    if (self.fromtype == 2) {
        NSString *str = @"";
        for (int i = 0; i < self.skulistArr.count; i++) {
            MHskuListModel *model = [self.skulistArr objectAtIndex:i];
            if ([self.skuId isEqualToString:[NSString stringWithFormat:@"%@",model.id]]) {
                str = [NSString stringWithFormat:@"%@",model.activitySkuId];
            }
        }
        NSMutableDictionary *dic= [NSMutableDictionary dictionary];
        [dic setObject:[self.dict valueForKey:@"productId"] forKey:@"productId"];
        [dic setObject:self.skuId forKey:@"skuId"];
        
         [dic setObject:self.editTextField.text forKey:@"amount"];
        [dic setObject:str forKey:@"activitySkuId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationbuyNow object:nil userInfo:dic];
        
    }
    
    if (self.makesureAct ) {
        self.makesureAct([self.dict valueForKey:@"productId"], self.skuId, self.editTextField.text);
        [self hideView];
    }
    
}

- (void)decreaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    NSInteger numcount =--count;
    if (numcount<1) {
        self.editTextField.text = @"1";
    }else{
         self.editTextField.text = [NSString stringWithFormat:@"%ld",numcount];
    }
   
    if (self.CountViewDecreaseBlock) {
        self.CountViewDecreaseBlock(-- count);
          self.editTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
}

- (void)increaseButtonAction {
    NSInteger count = self.editTextField.text.integerValue;
    ;
    NSInteger numcount =++count;
    if (numcount > [self.productstock integerValue]) {
         self.editTextField.text = [NSString stringWithFormat:@"%@",self.productstock];
    }else{
         self.editTextField.text = [NSString stringWithFormat:@"%ld",numcount];
        MHLog(@"%@",self.editTextField.text);
    }
    
//    if (self.CountViewAddBlock) {
//        self.CountViewAddBlock(++ count);
//
//    }
}
-(void)hideView
{
   
    [UIView animateWithDuration:0.2 animations:^{
          self.showView.frame=CGRectMake(0, kScreenHeight  , kScreenWidth, self.Height);
         self.alpha = 0;
         
     } completion:^(BOOL fin){
//         [self removeFromSuperview];

         self.bgView.hidden =YES;
         
         
     }];
    
    
}
-(void)showAlert
{
    self.bgView.hidden =NO;
     self.alpha = 1;
    self.fromtype = 0;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showView.frame =CGRectMake(0, kScreenHeight - self.Height -kBottomHeight, kScreenWidth, self.Height);
       
    } completion:^(BOOL finished) {
        
    }];
 
}
-(void)showAlertwithShopCar:(NSInteger )type
{
    self.fromtype = type;
    self.bgView.hidden =NO;
    self.alpha = 1;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showView.frame =CGRectMake(0, kScreenHeight - self.Height-kBottomHeight , kScreenWidth, self.Height);
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showAlertwithbyNow:(NSInteger )type
{
    self.fromtype = type;
    self.bgView.hidden =NO;
    self.alpha = 1;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showView.frame =CGRectMake(0, kScreenHeight - self.Height-kBottomHeight , kScreenWidth, self.Height);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn{
    // 判断, 根据点击不同的attributeView上的标签, 执行不同的代码
    if (view.tag == 21000) {
        MHLog(@"1");
        if (btn.tag == 29000) {
//             return;
            btn.selected =YES;
        }else{
            UIButton *btn = [self viewWithTag:29000];
            btn.selected = NO;
        }
    }
    if (view.tag == 21001) {
        MHLog(@"2");
        if (btn.tag == 29001) {
//             return;
             btn.selected =YES;
        }else{
            UIButton *btn = [self viewWithTag:29001];
            btn.selected = NO;
        }
    }
    if (view.tag == 21002) {
        MHLog(@"2");
        if (btn.tag == 29002) {
            return;
        }else{
            UIButton *btn = [self viewWithTag:29002];
            btn.selected = NO;
        }
    }
    
    
    
    NSString *title = btn.titleLabel.text;
    if (!btn.selected) {
        title = @"";
    }
    self.skuStr =[self.dict valueForKey:@"productId"];
    self.DesStr = @"";
   
    for (int i = 0; i < self.sectionArr.count; i++) {
        MHstandardListModel *model = [self.sectionArr objectAtIndex:i];
        if (view.tag == 21000 + i) {
            UILabel *label = [self  viewWithTag:14000+i];
            UILabel *label1 = [self  viewWithTag:14100+i];
         
            label.text = [NSString stringWithFormat:@"%@|%@",model.attributeId,title] ;
            label1.text = [NSString stringWithFormat:@"/%@",title] ;
        }
        UILabel *label = [self  viewWithTag:14000+i];
        UILabel *label1 = [self  viewWithTag:14100+i];
        self.DesStr =  [NSString stringWithFormat:@"%@%@",self.DesStr,label1.text];
        self.skuStr = [NSString stringWithFormat:@"%@|%@",self.skuStr,label.text];
    }
    BOOL IsMatching = YES;
    for (int i = 0; i < self.skulistArr.count; i++) {
        MHskuListModel *model = [self.skulistArr objectAtIndex:i];
        if ([self.skuStr  isEqualToString:model.key]) {
            IsMatching = YES;
            [self changeViewwithModel:model];
            return;
        }else{
            IsMatching = NO;
        }
    }
    if (IsMatching == NO) {
        [self changeViewwithModel3];
    }
    
}
-(void)changeViewwithModel:(MHskuListModel *)model
{
    [self.Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F74C16"],[UIColor colorWithHexString:@"FF8319"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    self.Buybtn.userInteractionEnabled = YES;
    self.showNoticelabel.hidden = YES;
    self.skuId =[NSString stringWithFormat:@"%@",model.id];
    MHLog(@"%@",model.retailPrice);
    NSString *str = [NSString stringWithFormat:@"%@",model.retailPrice];
    self.pricelabel.text = [NSString stringWithFormat:@"¥%.2f",[str floatValue]] ;
    self.stocknumlabel.text =[NSString stringWithFormat:@"库存%@",model.amount] ;
    self.productstock =[NSString stringWithFormat:@"%@",model.amount];
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kGetImage(@"img_bitmap_grey")];
    self.editTextField.text =@"1";
    if ([[NSString stringWithFormat:@"%@",model.amount] isEqualToString:@"0"]) {
        [self.Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"f1f2f3"],[UIColor colorWithHexString:@"e0e0e0"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        self.Buybtn.userInteractionEnabled = NO;
    }
}
-(void)changeViewwithModel2:(MHskuListModel *)model
{
   [self.Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F74C16"],[UIColor colorWithHexString:@"FF8319"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    self.Buybtn.userInteractionEnabled = YES;
    self.showNoticelabel.hidden = YES;
    self.skuId =[NSString stringWithFormat:@"%@",model.id];
    MHLog(@"%@",model.retailPrice);
    NSString *str = [NSString stringWithFormat:@"%@",model.retailPrice];
    self.pricelabel.text = [NSString stringWithFormat:@"¥%.2f",[str floatValue]] ;
    self.stocknumlabel.text =[NSString stringWithFormat:@"库存%@",model.amount] ;
    self.productstock =[NSString stringWithFormat:@"%@",model.amount];
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kGetImage(@"img_bitmap_grey")];
    
    
}
-(void)changeViewwithModel3
{
    self.showNoticelabel.hidden = YES;
    self.pricelabel.text =@"已售完" ;
    self.stocknumlabel.text =[NSString stringWithFormat:@"库存%@",@"0"] ;
   [self.Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"f1f2f3"],[UIColor colorWithHexString:@"e0e0e0"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    self.Buybtn.userInteractionEnabled = NO;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing coder
}
*/

@end
