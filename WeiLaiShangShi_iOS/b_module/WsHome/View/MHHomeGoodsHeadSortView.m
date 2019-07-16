
//
//  MHHomeGoodsHeadSortView.m
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeGoodsHeadSortView.h"
#import "MHProductBrandModel.h"
#import "AttributeView.h"
#import "UIView+Extnesion.h"
@interface MHHomeGoodsHeadSortView()<AttributeViewDelegate>
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UIView *showView;
@property(nonatomic, strong)UIImageView *productImg;
@property(nonatomic, strong)UIImageView *closeImg;
@property(nonatomic, assign)NSInteger width;
@property (nonatomic ,weak) UILabel *label0;
@property (nonatomic ,weak) UILabel *label1;
@property (nonatomic ,weak) UILabel *label2;
/** 电商 */
@property (nonatomic ,weak) AttributeView *attributeViewDS;
/** 巨头 */
@property (nonatomic ,weak) AttributeView *attributeViewJT;
/** 国家 */
@property (nonatomic ,weak) AttributeView *attributeViewGJ;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableArray *brandArr;
@property (nonatomic, strong) NSMutableArray *typeNameArr;
@property (nonatomic, strong) NSMutableArray *brandNameArr;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *Brandstr;
@property (nonatomic, strong) UITextField *minpricefield ;
@property (nonatomic, strong)UITextField *maxpricefield ;
@property (nonatomic, assign) NSInteger widthlox;
@property (nonatomic, strong) NSString * typeIdlox;
@property (nonatomic, strong) NSMutableDictionary * dictlox;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end
@implementation MHHomeGoodsHeadSortView
-(instancetype)initWithFrame:(CGRect)frame width:(NSInteger)width dataArr:(NSMutableDictionary*)dict typeid:(NSString *)typeId
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.widthlox = width;
        self.typeIdlox = typeId;
        self.dictlox = dict;
        self.btnArr = [NSMutableArray array];
        [self createviewWithWidth:width dataArr:dict typeid:typeId];
    }
    return self;
}
-(void)createviewWithWidth:(NSInteger)width dataArr:(NSMutableDictionary*)dict typeid:(NSString *)typeId
{
    
    //
    if (!klObjectisEmpty(dict)) {
        self.typeArr = [NSMutableArray array];
        self.brandArr = [NSMutableArray array];
        self.typeNameArr = [NSMutableArray array];
        self.brandNameArr = [NSMutableArray array];
        self.typeArr = [MHProductBrandModel baseModelWithArr:[dict valueForKey:@"typeList"]];
        MHProductBrandModel *model = [[MHProductBrandModel alloc]init];
        model.typeName = @"全部";
        model.typeId = [NSString stringWithFormat:@"%@",typeId];
        [self.typeArr insertObject:model atIndex:0];
        self.brandArr = [MHProductBrandModel baseModelWithArr:[dict valueForKey:@"brandList"]];
        for (int i = 0; i < self.typeArr.count ; i++) {
            MHProductBrandModel *model = self.typeArr[i];
            [self.typeNameArr addObject: model.typeName];
        }
        for (int i = 0; i < self.brandArr.count ; i++) {
             MHProductBrandModel *model = self.brandArr[i];
            [self.brandNameArr addObject: model.name];
        }
    }
    
    
    _width= width;
    self.backgroundColor = [UIColor clearColor];
    //半透明的背景
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.bgView.backgroundColor = KColorFromRGBA(0x00000, 0.4);
    self.bgView.userInteractionEnabled = YES;
    self.bgView.hidden= YES;
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.bgView addGestureRecognizer:tap];
    //白色区域
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0  , self.width, kScreenHeight)];
    self.showView.backgroundColor = [UIColor whiteColor];
    self.showView.userInteractionEnabled = YES;
    [self addSubview:self.showView];
    
    //规格选择
    // 创建最底层的scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, self.width, 1)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    // 创建类型属性视图
    
    NSArray *dsData = self.typeNameArr;
    AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:@"类型" titleFont:[UIFont boldSystemFontOfSize:14] attributeTexts:dsData viewWidth:self.width IsSort:YES];
    self.attributeViewDS = attributeViewDS;
    
    //添加价格
    UILabel *pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(attributeViewDS.frame)+15, 60, 17)];
    pricelabel.text = @"价格(元) :";
    pricelabel.textAlignment = NSTextAlignmentLeft;
    pricelabel.font = [UIFont fontWithName:kPingFangMedium size:14];
    [scrollView addSubview:pricelabel];
    
    self.minpricefield = [[UITextField alloc]initWithFrame:CGRectMake(10, pricelabel.frame.size.height+pricelabel.frame.origin.y+10, 100, 29)];
    self.minpricefield.keyboardType = UIKeyboardTypePhonePad;
    self.minpricefield.textAlignment = NSTextAlignmentCenter;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    self.minpricefield.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"最低价" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:KColorFromRGB(0x999999)}];
    self.minpricefield.layer.cornerRadius = kRealValue(6);
    self.minpricefield.backgroundColor =KColorFromRGB(0xE1E2E1);
//    self.minpricefield.layer.borderColor = KColorFromRGB(0xcccccc).CGColor;
//    self.minpricefield.layer.borderWidth =1;
    [scrollView addSubview:self.minpricefield];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.minpricefield.frame.origin.x+self.minpricefield.frame.size. width+20, self.minpricefield.frame.origin.y + 15, 10, 1)];
    lineView.backgroundColor = KColorFromRGB(0x999999);
    [scrollView addSubview:lineView];
    
    self.maxpricefield = [[UITextField alloc]initWithFrame:CGRectMake(160, pricelabel.frame.size.height+pricelabel.frame.origin.y+10, 100, 29)];
    self.maxpricefield.keyboardType = UIKeyboardTypePhonePad;
    self.maxpricefield.textAlignment = NSTextAlignmentCenter;
    self.maxpricefield.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"最高价" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:KColorFromRGB(0x999999)}];
//    self.maxpricefield.layer.borderColor = KColorFromRGB(0xcccccc).CGColor;
//    self.maxpricefield.layer.borderWidth =1;
    self.maxpricefield.layer.cornerRadius = kRealValue(6);
    self.maxpricefield.backgroundColor =KColorFromRGB(0xE1E2E1);
    [scrollView addSubview:self.maxpricefield];
    
    
    // 创建品牌属性视图
    NSArray *jtData =self.brandNameArr;
    AttributeView *attributeViewJT = [AttributeView attributeViewWithTitle:@"品牌" titleFont:[UIFont boldSystemFontOfSize:14] attributeTexts:jtData viewWidth:self.width IsSort:YES];
    self.attributeViewJT = attributeViewJT;
    
    if (self.brandNameArr.count == 0) {
        self.attributeViewJT.hidden =YES;
    }

    
    // 这里不用设置attriButeView的frame, 只需要设置y值就可以了,而且Y值是必须设置的,高度是已经在内部计算好的.可以更改宽度.
    attributeViewDS.y = 0;
    attributeViewJT.y = CGRectGetMaxY(attributeViewDS.frame) + 15+67;

    
    // 显示电商信息
    UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(attributeViewJT.frame)  + 50, (self.width ) / 3, 50)];
    label0.text = @"全部";
    label0.hidden =YES;
    self.label0 = label0;
    
    // 显示巨头信息
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20 + label0.width, label0.y, label0.width, 50)];
    label1.text = @"默认文字";
    label1.hidden = YES;
    self.label1 = label1;
    
    // 显示国家信息
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20 + label1.width * 2, label0.y,label0.width, 50)];
    label2.text = @"默认文字";
    label2.hidden =YES;
    self.label2 = label2;
    
    // 设置代理
    attributeViewDS.Attribute_delegate = self;
    attributeViewJT.Attribute_delegate = self;
   
    
    // 添加到scrollview上
    [scrollView addSubview:attributeViewDS];
    [scrollView addSubview:attributeViewJT];
    
    [scrollView addSubview:label0];
    [scrollView addSubview:label1];
    [scrollView addSubview:label2];
    scrollView.contentSize = (CGSize){0,CGRectGetMaxY(attributeViewJT.frame) + 350};
    
    // 添加scrollview到当前view上
    [self.showView addSubview:scrollView];
    // 通过动画设置scrollview的高度, 也可以一开始就设置好
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        scrollView.height += [UIScreen mainScreen].bounds.size.height - 30;
    } completion:nil];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct)];
    [scrollView addGestureRecognizer:tap1];
    
    UIButton *resetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetbtn.frame = CGRectMake(0, kScreenHeight-40-kBottomHeight-kTopHeight, self.width/2, 40);
    [resetbtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetbtn addTarget:self action:@selector(resetbtnAct) forControlEvents:UIControlEventTouchUpInside];
    [resetbtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    resetbtn.backgroundColor = KColorFromRGB(0xE0E0E0);
    [self.showView addSubview:resetbtn];
    
    UIButton *sortbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortbtn.frame= CGRectMake(self.width/2, kScreenHeight -40-kBottomHeight-kTopHeight, self.width/2, 40);
    [sortbtn setTitle:@"筛选" forState:UIControlStateNormal];
    [sortbtn addTarget:self action:@selector(sortbtnAct) forControlEvents:UIControlEventTouchUpInside];
    [sortbtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    [self.showView addSubview:sortbtn];
    
    
    
    
    
    
    
}
-(void)resetbtnAct
{
    for (int i = 0; i < self.btnArr.count ; i ++ ) {
        UIButton *btn = [self.btnArr objectAtIndex:i];
        btn.selected = NO;
    }
    self.label0.text = @"全部";
    self.label1.text  = @"";
    self.label2.text  = @"";
    self.minpricefield.text =@"";
    self.maxpricefield.text = @"";
    
}
-(void)sortbtnAct
{
    self.str = @"";
    for (int i = 0; i < self.typeArr.count ; i++) {
        MHProductBrandModel *model = [self.typeArr objectAtIndex:i];
        if ([model.typeName isEqualToString:self.label0.text]) {
            self.str = [NSString stringWithFormat:@"%@",model.typeId];
        }
       
    }
    self.Brandstr = @"";
    for (int i = 0; i < self.brandArr.count ; i++) {
        MHProductBrandModel *model = [self.brandArr objectAtIndex:i];
        if ([model.name isEqualToString:self.label1.text]) {
            self.Brandstr = [NSString stringWithFormat:@"%@",model.id];
        }
        
    }
    if (self.sortwithkey) {
        self.sortwithkey(self.str, self.Brandstr, self.maxpricefield.text, self.minpricefield.text,self.label0.text);
    }
}
-(void)tapAct
{
    [self endEditing:YES];
}
-(void)hideView
{
    self.alpha = 0;
    [self endEditing:YES];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         self.showView.frame =CGRectMake( kScreenWidth , 0 , self.width, kScreenHeight);
        
    } completion:^(BOOL finished) {
         self.bgView.hidden =YES;
    }];
    
    
}
-(void)showAlert
{
    self.bgView.hidden =NO;
    self.alpha = 1;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showView.frame =CGRectMake( kScreenWidth -self.width, 0 , self.width, kScreenHeight);
       
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn{
    // 判断, 根据点击不同的attributeView上的标签, 执行不同的代码
    
    [self.btnArr addObject:btn];
    NSString *title = btn.titleLabel.text;
    if (!btn.selected) {
        title = @"默认文字";
    }
    if ([view isEqual:self.attributeViewDS]) {
        
        self.label0.text = title;
    }else if ([view isEqual:self.attributeViewJT]){
        
        self.label1.text = title;
    }else{
        self.label2.text = title;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
